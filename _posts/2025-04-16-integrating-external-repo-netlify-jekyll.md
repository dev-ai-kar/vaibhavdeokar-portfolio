---
layout: post
title: "Integrating External Repositories into Jekyll on Netlify"
date: 2025-04-16
categories: [Web Development, Jekyll, Netlify]
tags: [Git, GitHub Actions, CI/CD, Automation, Build Process]
description: "A detailed guide on automatically including content from separate Git repositories into your main Jekyll site during the Netlify build process using a custom build script."
author: Vaibhav Deokar
# Optional: Add an image: /images/path/to/relevant/image.jpg
---

Many developers maintain separate repositories for different types of content. For instance, you might have your main portfolio website in one repository and detailed technical notes (like C++ notes) in another. But what if you want to publish those notes as part of your main website, automatically updating the site whenever the notes change?

This post details a robust and scalable method to achieve this using Jekyll, Netlify, GitHub Actions, and a custom build script. We'll use the example of integrating a `cpp-notes` repository into a main portfolio site.

## The Challenge

We want to:

1.  Keep the `cpp-notes` repository completely separate from the main portfolio site repository.
2.  Automatically trigger a rebuild and deployment of the portfolio site on Netlify whenever changes are pushed to the `cpp-notes` repository.
3.  Include the content from `cpp-notes` within the Jekyll build process of the main site.
4.  (Optional but common) Handle cases where the external content (e.g., Markdown files) might lack the YAML Front Matter Jekyll needs for processing within collections.

## The Solution: Build Script & Automation

We'll orchestrate this using several components:

1.  **Netlify Build Hook:** A unique URL provided by Netlify that triggers a new build for your main site when requested.
2.  **GitHub Secret:** Securely stores the Netlify build hook URL within the *external* notes repository.
3.  **GitHub Action:** A workflow within the *external* notes repository that automatically sends a request to the Netlify build hook URL upon a push event.
4.  **Custom Build Script (`netlify-build.sh`):** A shell script within your *main* portfolio repository that Netlify will execute. This script handles cloning the external repository, performs any necessary pre-processing (like adding front matter), and then runs the standard Jekyll build.
5.  **Netlify Configuration (`netlify.toml`):** Tells Netlify to execute our custom build script instead of the default build command.
6.  **Jekyll Configuration (`_config.yml`):** Defines the directory where the external content is cloned as a Jekyll collection so it gets processed correctly.

## Step-by-Step Implementation

Here's how to set it up:

### 1. Create Netlify Build Hook (Main Site)

*   Log in to Netlify and navigate to your main portfolio site's settings.
*   Go to **Site settings > Build & deploy > Continuous deployment > Build hooks**.
*   Click **"Add build hook"**.
*   Give it a descriptive name (e.g., `trigger-from-cpp-notes`).
*   Select the branch Netlify should build when this hook is triggered (usually your production branch, like `main` or `jekyll-integration`).
*   Click **"Save"**.
*   **Important:** Copy the generated URL. You'll need it for the next step.

### 2. Create GitHub Secret (External Repo)

*   Navigate to your *external* notes repository on GitHub (e.g., `cpp-notes`).
*   Go to **Settings > Secrets and variables > Actions**.
*   Click **"New repository secret"**.
*   Set the **Name** to `NETLIFY_BUILD_HOOK_URL`.
*   Paste the build hook URL copied from Netlify into the **Value** field.
*   Click **"Add secret"**.

### 3. Create GitHub Action Workflow (External Repo)

*   In your *external* notes repository (`cpp-notes`), create the following directory structure and file if it doesn't exist: `.github/workflows/trigger_netlify_build.yml`.
*   Add the following content to `trigger_netlify_build.yml`:

    ```yaml
    name: Trigger Netlify Build

    on:
      push:
        branches:
          - main # Or whichever branch you push final notes to

    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - name: Trigger Netlify Build Hook
            run: curl -X POST -d '{}' ${{ secrets.NETLIFY_BUILD_HOOK_URL }}
    ```
*   This workflow triggers on pushes to the specified branch (`main` in this case) and sends an empty POST request to the build hook URL stored in the secret, kicking off a Netlify build for your main site.
*   Commit and push this file to your external notes repository.

### 4. Create the Build Script (Main Site Repo)

*   In the root directory of your *main* portfolio repository (`vaibhavdeokar-portfolio`), create a file named `netlify-build.sh`.
*   Add the following content:

    ```bash
    #!/bin/bash
    # Exit script if any command fails
    set -e

    echo "Cloning external repositories..."
    # --- C++ Notes ---
    echo "Cloning cpp-notes..."
    # Replace with your actual repo URL if different
    git clone https://github.com/dev-ai-kar/cpp-notes.git _cpp_notes

    # --- Add future repos below ---
    # echo "Cloning repo2..."
    # git clone https://github.com/user/repo2.git _repo2_notes

    echo "Processing cloned repositories..."
    # --- Add front matter for cpp-notes (if needed) ---
    echo "Adding front matter to cpp-notes..."
    # This 'find' command adds empty front matter to all .md files
    find _cpp_notes -name '*.md' -exec sed -i '1i---\
    ---' {} +

    # --- Add processing for future repos below (if needed) ---
    # echo "Adding front matter to repo2..."
    # find _repo2_notes -name '*.md' -exec sed -i '1i---\
    # ---' {} +

    echo "Running Jekyll build..."
    # Use 'bundle exec' if you manage gems with Bundler
    bundle exec jekyll build

    echo "Build script finished."
    ```
*   **Explanation:**
    *   `set -e`: Ensures the script stops if any command fails.
    *   `git clone ...`: Clones the external repository into a specified directory (here, `_cpp_notes`).
    *   `find ... -exec sed ...`: This line is crucial if your external markdown files lack front matter. It finds all `.md` files in the cloned directory and uses `sed` to insert an empty front matter block (`---\n---`) at the beginning of each file. **If your external files already have front matter, you can remove this `find` command.**
    *   `bundle exec jekyll build`: Runs the standard Jekyll build process.

### 5. Set Execute Permissions (Main Site Repo)

*   Before committing `netlify-build.sh`, you need to tell Git it should be executable. In your local terminal (Git Bash, Linux, macOS):
    ```bash
    # Stage the file first if you haven't already
    # git add netlify-build.sh
    git update-index --chmod=+x netlify-build.sh
    ```
*   This command updates Git's index to record the execute permission for the script.

### 6. Update `netlify.toml` (Main Site Repo)

*   Edit the `netlify.toml` file in your main repository.
*   Modify the `[build]` section to execute your new script:

    ```toml
    [build]
      # Execute the build script instead of the direct command
      command = "./netlify-build.sh"
      publish = "_site/" # Jekyll's default output directory

    # Keep other settings like [build.environment] if needed
    [build.environment]
      RUBY_VERSION = "3.4.2"
    ```

### 7. Update `_config.yml` (Main Site Repo)

*   Edit the `_config.yml` file in your main repository.
*   Define the directory you cloned into (`_cpp_notes`) as a Jekyll collection:

    ```yaml
    collections:
      posts: # Your existing posts collection
        output: true
        permalink: /blog/:year/:month/:day/:title.html
      cpp_notes: # The new collection
        output: true # Generate pages for each note
        permalink: /notes/cpp/:path.html # Define the URL structure
    ```
*   Adjust the `permalink` as desired. `:path` ensures the directory structure from `_cpp_notes` is reflected in the URL, and Jekyll handles the `.md` to `.html` conversion.

### 8. Commit and Push (Main Site Repo)

*   Commit the new `netlify-build.sh` script and the changes to `netlify.toml` and `_config.yml`. Use a descriptive commit message.
*   Push these changes to the branch Netlify deploys (e.g., `jekyll-integration` or `main`).

## Making the Content Accessible

Now that the external notes are being included in the build, you need to provide ways for users to find them:

1.  **Create an Index Page:** Add a new page (e.g., `notes/cpp.md` or similar) in your main repository. Use Liquid to loop through the collection and list the notes:
    *(Note: `note.data.title` assumes you might add a `title:` field in the front matter later; otherwise, `note.name` gives the filename.)*
2.  **Add Navigation:** Edit your site's header include (`_includes/header.html` or similar) to add a link to your new index page.

## Conclusion

This setup provides a powerful, automated, and scalable way to manage content across multiple repositories while presenting it seamlessly on a single Jekyll site built with Netlify. By leveraging build hooks, GitHub Actions, and a custom build script, you maintain separation of concerns while ensuring your site always reflects the latest updates from all your content sources. Remember to adapt repository URLs, branch names, and directory structures to match your specific project needs.
