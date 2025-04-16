# Project Context for AI (Cline)

This file documents key configurations and setups within the `vaibhavdeokar-portfolio` repository for future reference, particularly regarding complex integrations.

## External Repository Integration (e.g., `cpp-notes`)

This project integrates content from external Git repositories (like `cpp-notes`) into the Jekyll build process managed by Netlify.

**Mechanism:**

1.  **Netlify Build Script (`netlify-build.sh`):**
    *   Located in the repository root.
    *   Executed by Netlify as the primary build command (configured in `netlify.toml`).
    *   **Clones** external repositories (e.g., `git clone https://github.com/dev-ai-kar/cpp-notes.git _cpp_notes`).
    *   **Adds Front Matter:** Uses `find ... -exec sed ...` to inject empty YAML front matter (`---\n---`) into all `.md` files within the cloned directories. This is necessary if the source repositories don't include front matter, which Jekyll requires for collection processing.
    *   Runs the standard Jekyll build (`bundle exec jekyll build`).
    *   Designed to be extensible for adding more repositories.

2.  **Netlify Configuration (`netlify.toml`):**
    *   The `[build].command` is set to `./netlify-build.sh`.
    *   The `[build].publish` directory is `_site/`.

3.  **Jekyll Configuration (`_config.yml`):**
    *   Each cloned external repository directory (e.g., `_cpp_notes`) is defined as a Jekyll **collection**.
    *   Example:
        ```yaml
        collections:
          cpp_notes:
            output: true
            permalink: /notes/cpp/:path.html
        ```
    *   This tells Jekyll to process the files within these directories and generate pages according to the specified `permalink`.

4.  **Automation Trigger (GitHub Action):**
    *   Each *external* repository (e.g., `cpp-notes`) contains a GitHub Action workflow (`.github/workflows/trigger_netlify_build.yml`).
    *   This workflow triggers on `push` events to the external repository's main branch.
    *   It sends a POST request to a **Netlify Build Hook URL** specific to the main portfolio site.
    *   The build hook URL is stored securely as a **GitHub Secret** (e.g., `NETLIFY_BUILD_HOOK_URL`) within the external repository's settings.
    *   This triggers a new build of the main portfolio site on Netlify, ensuring the latest content from the external repository is included.

**Workflow Summary:**

Push to external repo -> GitHub Action triggers -> Sends request to Netlify Build Hook -> Netlify starts build for main portfolio -> `netlify-build.sh` runs (clones external repo, adds front matter) -> Jekyll builds site including external content -> Netlify deploys.

## General Project Conventions (from README.md)

*   **Blog Post Categories:** Use a single, broad category (e.g., `AI`, `Web Development`, `Personal`).
*   **Blog Post Tags:** Use multiple, specific tags to describe the post's topics (e.g., `Neo4j`, `RAG`, `Jekyll`, `React`).
*   **Commit Messages:** Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification for Git commit messages (e.g., `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`). This helps maintain a clear and automated commit history.

## Common Jekyll Front Matter Variables (Posts)

*   `layout:` (Required) Layout file from `_layouts` (e.g., `post`).
*   `title:` (Required) Post title.
*   `date:` (Required for `_posts`) Publication date (e.g., `YYYY-MM-DD` or full timestamp). Must match filename date format.
*   `categories:` (Optional) Single string or list for broad topic (e.g., `AI`).
*   `tags:` (Optional) List or string of specific keywords (e.g., `[Jekyll, Netlify]`).
*   `description:` (Recommended) Short summary for SEO and social previews.
*   `author:` (Optional) Author name.
*   `image:` (Recommended) Path to featured image for social previews (e.g., `/images/my-image.jpg`).
*   `published:` (Optional) Set to `false` to prevent publishing (defaults to `true`).
*   _(Custom variables can also be added as needed by the layout)._
