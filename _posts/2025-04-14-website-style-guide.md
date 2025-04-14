---
layout: post
title:  "Website Style Guide"
date:   2025-04-14 17:51:00 +0530 # Adjust date/time if needed
author: Vaibhav Deokar
categories: [Design, Frontend]
tags: [style guide, css, design system]
# image: /images/path/to/optional/post-image.jpg # Optional: Add an image if you like
---

This post outlines the core visual styles and components used throughout the website, based on the `styles.css` file.

## Colors

The website utilizes a specific color palette defined using CSS variables.

### Primary Colors:

*   `--color-1`: hsla(222, 88%, 33%, 1) - A strong blue, used for links.
*   `--color-2`: hsla(358, 65%, 46%, 1) - A distinct red, often used for hover states or accents.

### Grayscale:

A wide range of gray shades are defined, from `--color-black` (#000000) to `--color-white` (#ffffff), with numbered grays in between (e.g., `--color-gray-1` to `--color-gray-19`).

*   **Text:** Default text uses `--color-text` (var(--color-gray-16)). Dark text is `--color-text-dark` (black), and light text is `--color-text-light` (var(--color-gray-7)).
*   **Background:** The main background is `--color-bg` (var(--color-gray-1)).

### Feedback Colors:

Used for alert boxes:
*   Error: `--color-error` (background), `--color-error-content` (text)
*   Success: `--color-success` (background), `--color-success-content` (text)
*   Info: `--color-info` (background), `--color-info-content` (text)
*   Notice: `--color-notice` (background), `--color-notice-content` (text)

## Typography

Three main font families are imported and used via CSS variables:

*   `--font-1`: "Inter", sans-serif (Primary UI and body font)
*   `--font-2`: "DM Serif Text", serif (Used for H1-H5 headings)
*   `--font-3`: "DM Serif Display", serif (Used for large display text, like the hero section heading)
*   `--font-mono`: Consolas, Monaco, monospace (Used for `<code>` and `<pre>` tags)

### Type Scale (Base Size: 1.8rem)

Headings (`h1` to `h6`) and helper classes (`.h1` to `.h6`) follow a defined scale:

*   `h1`, `.h1`: `--text-display-1` (approx 53.75px)
*   `h2`, `.h2`: `--text-xxl` (approx 37.32px)
*   `h3`, `.h3`: `--text-xl` (approx 31.10px)
*   `h4`, `.h4`: `--text-lg` (approx 25.92px)
*   `h5`, `.h5`: `--text-md` (approx 21.60px)
*   `h6`, `.h6`: `--text-sm` (approx 15.00px), uppercase, letter-spacing

Paragraph text uses `--text-size` (1.8rem).

Lead paragraphs (`.lead`) use `--text-md` (approx 21.60px) with a lighter font-weight (300).

## Buttons

Buttons have a base style (`.btn`, `button`, `input[type="submit"]`) and modifiers.

*   **Base:** Gray background (`--color-btn`), black text (`--color-btn-text`). Hover changes to black background (`--color-btn-hover`) and white text (`--color-btn-hover-text`). Height is `--vspace-btn` (approx 6.4rem).
*   **Primary (`.btn--primary`):** Black background (`--color-btn-primary`), white text. Hover uses a darker gray (`--color-btn-primary-hover`).
*   **Stroke (`.btn--stroke`):** Transparent background, black border and text. Hover fills with black background and white text. Used in the hero section.
*   **Sizes:** `.btn--small`, `.btn--medium`, `.btn--large` adjust height.
*   **Full Width (`.h-full-width`):** Makes the button take up 100% of its container width.

```html
<!-- Standard Button -->
<button class="btn">Standard Button</button>

<!-- Primary Button -->
<a href="#" class="btn btn--primary">Primary Button</a>

<!-- Stroke Button -->
<a href="#" class="btn btn--stroke">Stroke Button</a>
```

## Grid System

The layout uses a flexbox-based grid system.

*   Rows are defined by the `.row` class.
*   Columns are defined by the `.column` class.
*   Widths are controlled by classes like `.large-6` (50% width on large screens), `.medium-4` (33.3% on medium screens), `.tab-12` (100% on tablets), etc.
*   Block grids (e.g., `.block-large-1-3`) create equally sized columns within a row.

## Spacing

Vertical spacing is managed using CSS variables based on `--space` (3.2rem).

*   Examples: `--vspace-1` (3.2rem), `--vspace-0_5` (1.6rem), `--vspace-2` (6.4rem).
*   Margins are applied to elements like paragraphs (`<p>`), lists (`<ul>`, `<ol>`), headings, etc., using these variables (e.g., `margin-bottom: var(--vspace-1);`).

This guide covers the fundamental styles. Refer to `css/styles.css` for more detailed component styling (forms, navigation, footer, etc.).
