---
layout: post
title:  "Building This Portfolio: Integrating Jekyll with an Existing Static Site on Netlify"
date:   2025-04-14 20:01:00 +0530 # Adjust date/time if needed
author: Vaibhav Deokar
categories: [Workflow, Webdev] # Updated as requested
tags: [portfolio, jekyll, netlify, git, ruby, ssg, ci-cd, development] # Moved Development and Jekyll to tags
image: /images/sample-image.jpg # Placeholder image - update later
---

This portfolio site started as a standard static website, but as the need for a blog section grew, managing pure HTML files became cumbersome. This post details the journey of integrating Jekyll, a powerful static site generator, into the existing structure and setting up a deployment workflow using Netlify.

## Phase 1: The Existing Site

The initial version of the site was built using standard web technologies:

*   **HTML:** Core structure for pages like Home, About, and Contact.
*   **CSS:** Styling provided by `styles.css` and `vendor.css`.
*   **JavaScript:** Interactivity handled by jQuery, various plugins, and custom scripts in `main.js`.

Deployment was initially handled directly via Netlify, likely linked to the `main` branch of the GitHub repository.

![Placeholder: Original Site Screenshot]({{ site.baseurl }}/images/sample-1050.jpg)
*(Replace with an actual screenshot of the original site)*

## Phase 2: Jekyll Integration

To simplify blog post creation and management, Jekyll was chosen. Here's how it was integrated:

### Prerequisites
Jekyll is built on Ruby. The first step was ensuring Ruby and the RubyGems package manager were installed. On Windows, this was easily done using [RubyInstaller](https://rubyinstaller.org/downloads/), making sure to select the "Ruby+Devkit" version and adding Ruby to the system PATH. We also needed Bundler, a Ruby dependency manager, installed via `gem install bundler`.

### Setting Up Jekyll
Instead of creating a new site from scratch, Jekyll was initialized within the existing project:

1.  **`Gemfile`:** A `Gemfile` was created in the project root to list Jekyll and any necessary plugins (like `jekyll-feed` for RSS).

    ```ruby
    # Gemfile
    source "https://rubygems.org"

    gem "jekyll", "~> 4.2"
    gem "bundler"
    gem "jekyll-feed", "~> 0.12"
    ```
2.  **Install Dependencies:** Running `bundle install` read the `Gemfile` and installed Jekyll and its dependencies locally.
3.  **`_config.yml`:** The main Jekyll configuration file was created to define site-wide variables (like `title`, `email`, `url`, `baseurl`), build settings (e.g., `markdown: kramdown`), plugins to activate, and files/directories to exclude or keep during the build process.

### Restructuring for Jekyll
The core concept of Jekyll involves using layouts and includes for reusable code:

1.  **Layouts (`_layouts/`):**
    *   `default.html`: Created as the base template containing the `<html>`, `<head>`, `<body>`, header, and footer structure. It uses `{% raw %}{% include %}{% endraw %}` tags for common elements and `{% raw %}{{ content }}{% endraw %}` as a placeholder for page-specific content.
    *   `post.html`: Created specifically for blog posts, inheriting from `default.html` and adding post-specific elements like title, metadata (author, date, categories, tags), and the main post content (`{% raw %}{{ content }}{% endraw %}`).
2.  **Includes (`_includes/`):** Common HTML sections like the site header (`header.html`), footer (`footer.html`), and head content (`head.html`) were extracted from the original HTML files and placed here. These are pulled into layouts using `{% raw %}{% include head.html %}{% endraw %}`.
3.  **Updating Pages:** The existing `index.html`, `about.html`, and `contact.html` were modified by:
    *   Adding YAML Front Matter at the top (lines between `---`) to specify the layout (`layout: default`) and page-specific metadata (like `title`, `description`).
    *   Removing the original `<head>`, `<header>`, and `<footer>` sections, as they are now handled by the layout.

    ```html
    ---
    layout: default
    title: About - Vaibhav Deokar
    description: The story of Vaibhav Deokar...
    ---

    <!-- Page specific content goes here -->
    <section class="s-content">
      ...
    </section>
    ```

### Creating Blog Content
1.  **`_posts/` Directory:** This is where all blog posts reside.
2.  **Markdown Conversion:** The content from the original static blog page (`single-standard.html`) was moved into a new Markdown file, named following the required `YYYY-MM-DD-title.md` format (e.g., `2025-04-14-standard-format-post.md`).
3.  **Post Front Matter:** Essential metadata was added to the top of the post file, including `layout: post`, `title`, `date`, `author`, `categories`, and `tags`.

### Handling Assets
The existing `css/`, `js/`, and `images/` directories were kept. Jekyll was configured in `_config.yml` to copy these directly into the final build output using the `keep_files` directive. Paths in layouts and includes were updated to use `{% raw %}{{ site.baseurl }}{% endraw %}` (e.g., `<link rel="stylesheet" href="{% raw %}{{ site.baseurl }}{% endraw %}/css/styles.css">`) to ensure they work correctly regardless of where the site is deployed.

### Local Testing
Throughout the process, `bundle exec jekyll serve` was used. This command builds the site locally into a `_site` directory and starts a development server (usually at `http://localhost:4000`), allowing for immediate previewing of changes.

![Placeholder: Jekyll Serve Output]({{ site.baseurl }}/images/sample-1050.jpg)
*(Replace with an image of the terminal running jekyll serve)*

## Phase 3: Deployment Workflow

To safely manage the Jekyll integration without affecting the live site, a Git branch and Netlify's deployment features were used:

1.  **Git Branching:** A new branch, `jekyll-integration`, was created from the `main` branch. All Jekyll-related development occurred on this branch (`git checkout -b jekyll-integration`).
2.  **Committing Changes:** All new files (`Gemfile`, `_config.yml`, `netlify.toml`, `_layouts/`, `_includes/`, `_posts/`, `.gitignore`) and modified files (`index.html`, `about.html`, `contact.html`, `css/styles.css`) were committed to this branch (`git add .`, `git commit -m "..."`).
3.  **Pushing to GitHub:** The `jekyll-integration` branch was pushed to the remote GitHub repository (`git push -u origin jekyll-integration`).
4.  **Netlify Configuration (`netlify.toml`):** A configuration file was added to tell Netlify how to build the Jekyll site:

    ```toml
    # netlify.toml
    [build]
      command = "bundle exec jekyll build" # Build command
      publish = "_site/"                  # Output directory

    [build.environment]
      RUBY_VERSION = "3.4.2" # Ensure correct Ruby version
    ```
5.  **Netlify CLI for Preview:**
    *   The Netlify CLI was installed (`npm install -g netlify-cli`).
    *   The local project was linked to the Netlify site (`netlify link`).
    *   A draft preview was deployed using `netlify deploy --build`. This builds the site locally based on `netlify.toml` and uploads the `_site` folder, generating a unique preview URL (e.g., `https://<deploy-hash>--vaibhavdeokar.netlify.app`).
6.  **Automatic Branch Deploys (Alternative):** Configuring Netlify via its UI to watch the `jekyll-integration` branch allows for automatic rebuilds and updates to a branch-specific URL (e.g., `https://jekyll-integration--vaibhavdeokar.netlify.app`) on every push to that branch on GitHub.

![Placeholder: Netlify Settings]({{ site.baseurl }}/images/sample-1050.jpg)
*(Replace with a screenshot of Netlify branch deploy settings or build settings)*

## Key Technologies Used

*   **HTML, CSS, JavaScript:** The site's foundational structure, styling, and client-side interactivity.
*   **Ruby:** The programming language Jekyll is built with.
*   **Jekyll:** The static site generator used for templating and blog management.
*   **Bundler:** Manages Ruby gem dependencies (like Jekyll).
*   **Markdown:** Simple syntax used for writing blog posts.
*   **Git & GitHub:** Version control system and remote repository hosting.
*   **Netlify:** Platform for hosting the static site and handling continuous deployment.
*   **Netlify CLI:** Command-line tool for interacting with Netlify services.

## Conclusion

Integrating Jekyll into an existing site required restructuring content into layouts, includes, and posts, but provides a much more streamlined way to manage blog content using Markdown. Utilizing Git branches and Netlify's deployment features (either via CLI previews or automatic branch deploys) ensures that development and testing can happen safely without impacting the live production site until changes are ready to be merged.
