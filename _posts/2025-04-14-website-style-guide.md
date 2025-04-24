---
layout: post
title:  "Website Style Guide"
date:   2025-04-14 17:51:00 +0530 # Adjust date/time if needed
author: Vaibhav Deokar
categories: [Design]
tags: [style guide, css, design system, html, frontend] # Moved Frontend to tags
# image: /images/path/to/optional/post-image.jpg # Optional: Add an image if you like
---

This post outlines the core visual styles and components used throughout the website, primarily based on the `styles.css` file and demonstrated in `styles.html`.

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

```html
<h1>H1 Heading.</h1>
<h2>H2 Heading.</h2>
<h3>H3 Heading.</h3>
<h4>H4 Heading.</h4>
<h5>H5 Heading.</h5>
<h6>H6 Heading.</h6>

<p class="lead">This is a lead paragraph example.</p>
<p>This is a standard paragraph.</p>
```

## Text Elements

### Paragraphs, Links & Inline Styles

Standard HTML tags for text formatting are styled accordingly.

```html
<p>
    This is a paragraph with <a href="#">a link</a>,
    <abbr title="Example Abbreviation">abbrebation</abbr>,
    <strong>strong text</strong>, <em>em text</em>,
    <del>deleted text</del>, and
    <mark>this is a mark text.</mark>
    Inline code looks like this: <code>.code</code>.
</p>
```

### Image Alignment

Use helper classes to float images within text content.

```html
<p>
    <img width="120" height="120" class="h-pull-left" 
    alt="sample-image" src="images/sample-image.jpg">
    Lorem ipsum dolor sit amet, consectetuer adipiscing elit...
</p>
```

### Drop Caps

Add the `.drop-cap` class to a paragraph to style the first letter as a drop cap.

```html
<p class="drop-cap">
    Far far away, behind the word mountains, far from the countries...
</p>
```

### Small Print

Use the `<small>` tag for less important text.

```html
<p><small>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</small></p>
```

## Quotes

### Pull Quotes

Use the `pull-quote` class on a `figure` element containing a `blockquote`.

```html
<figure class="pull-quote">
    <blockquote>
        <p>
            When you look in the eyes of grace... it will not motivate you to sin.
            It will motivate you to righteousness.
        </p>
        <footer>
            <cite>Judah Smith</cite>
        </footer>
    </blockquote>
</figure>
```

### Block Quotes

Standard `<blockquote>` elements are styled with optional `cite` in the `footer`.

```html
<blockquote cite="http://where-i-got-my-info-from.com">
    <p>
        For God so loved the world, that he gave his only Son...
    </p>
    <footer>
        <cite><a href="#0">John 3:16-17 ESV</a></cite>
    </footer>
</blockquote>
```

## Lists

### Ordered & Unordered Lists

Standard `<ol>` and `<ul>` lists are styled. Unordered lists default to disc bullets. Nested lists are supported.

```html
<ol>
    <li>Here is an example</li>
    <li>of an ordered list.</li>
    <li>
        A parent list item.
        <ul>
            <li>one</li>
            <li>two</li>
            <li>three</li>
        </ul>
    </li>
    <li>A list item.</li>
</ol>

<ul class="disc"> <!-- Default style, class optional -->
    <li>Here is an example</li>
    <li>of an unordered list.</li>
</ul>
```

### Definition Lists

Use `<dl>` with the `.dictionary-style` class for term/definition pairs.

```html
<dl class="dictionary-style">
    <dt><strong>This is a term</strong></dt>
    <dd>this is the definition of that term...</dd>
    <dt><strong>Another Term</strong></dt>
    <dd>And it gets a definition too...</dd>
    <dd>This is a 2<sup>nd</sup> definition...</dd>
</dl>
```

### Skill Bars

Use the `.skill-bars` class on a `<ul>` with specific `<li>` structures.

```html
<ul class="skill-bars">
    <li>
        <div class="progress percent90"><span>90%</span></div>
        <strong>HTML</strong>
    </li>
    <li>
        <div class="progress percent85"><span>85%</span></div>
        <strong>CSS</strong>
    </li>
    <!-- etc. -->
</ul>
```

## Buttons

Buttons have a base style (`.btn`, `button`, `input[type="submit"]`) and modifiers.

*   **Base:** Gray background (`--color-btn`), black text (`--color-btn-text`). Hover changes to black background (`--color-btn-hover`) and white text (`--color-btn-hover-text`). Height is `--vspace-btn` (approx 6.4rem).
*   **Primary (`.btn--primary`):** Black background (`--color-btn-primary`), white text. Hover uses a darker gray (`--color-btn-primary-hover`).
*   **Stroke (`.btn--stroke`):** Transparent background, black border and text. Hover fills with black background and white text.
*   **Sizes:** `.btn--small`, `.btn--medium`, `.btn--large` adjust height (not explicitly shown in `styles.html` example, but defined in CSS).
*   **Full Width (`.h-full-width`):** Makes the button take up 100% of its container width.

```html
<!-- Standard Button -->
<a class="btn h-full-width" href="#0">Default Button</a>

<!-- Primary Button -->
<a class="btn btn--primary h-full-width" href="#0">Primary Button</a>

<!-- Stroke Button -->
<a class="btn btn--stroke h-full-width" href="#0">Stroke Button</a>

<!-- Used in forms -->
<input class="btn--primary h-full-width" type="submit" value="Submit">
```

## Grid System

The layout uses a flexbox-based grid system.

*   Rows are defined by the `.row` class.
*   Columns are defined by the `.column` class.
*   Widths are controlled by responsive classes like `.large-6` (50% width on large screens), `.medium-4` (33.3% on medium screens), `.tab-12` (100% on tablets), `.mob-12` (100% on mobile), etc. Combining classes allows for different layouts at different breakpoints (e.g., `.large-3 .tab-6 .mob-12`).
*   Block grids (e.g., `.block-large-1-3`) create equally sized columns within a row (not shown in `styles.html` example, but available).

```html
<!-- Example: Two equal columns on large screens, full width on mobile -->
<div class="row">
    <div class="column large-6 mob-12">
        <p>Column 1 Content...</p>
    </div>
    <div class="column large-6 mob-12">
        <p>Column 2 Content...</p>
    </div>
</div>

<!-- Example: Four equal columns on large, two on tablet, full on mobile -->
<div class="row">
    <div class="column large-3 tab-6 mob-12">
        <p>Column A</p>
    </div>
    <div class="column large-3 tab-6 mob-12">
        <p>Column B</p>
    </div>
    <div class="column large-3 tab-6 mob-12">
        <p>Column C</p>
    </div>
    <div class="column large-3 tab-6 mob-12">
        <p>Column D</p>
    </div>
</div>
```

## Spacing

Vertical spacing is managed using CSS variables based on `--space` (3.2rem).

*   Examples: `--vspace-1` (3.2rem), `--vspace-0_5` (1.6rem), `--vspace-2` (6.4rem), etc.
*   Margins and padding are applied to elements like paragraphs (`<p>`), lists (`<ul>`, `<ol>`), headings, sections, etc., using these variables (e.g., `margin-bottom: var(--vspace-1);`). Spacing helper classes (e.g. `h-add-bottom`) might also be used.

## Media

### Responsive Images

Use `<img>` with `srcset` and `sizes` attributes for responsive images. Optional `<figcaption>` can be added within a `<figure>`.

```html
<figure>
    <img
        src="images/sample-525.jpg"
        srcset="
            images/sample-1050.jpg 1050w,
            images/samaple-525.jpg  525w
        "
        sizes="(max-width: 1050px) 100vw, 1050px"
        alt="Description of image"
    />
    <figcaption>Here is some random picture.</figcaption>
</figure>
```

### Responsive Video

Wrap embedded video (like `<iframe>`) in a `div` with the class `.video-container`.

```html
<div class="video-container">
    <iframe
        src="https://player.vimeo.com/video/14592941?color=00a650"
        width="500" height="281" frameborder="0"
        allowfullscreen>
    </iframe>
</div>
```

## Tables

Use standard HTML table markup (`<table>`, `<thead>`, `<tbody>`, `<tr>`, `<th>`, `<td>`). Wrap the table in a `div` with class `.table-responsive` for horizontal scrolling on smaller screens.

```html
<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Sex</th>
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>William J. Seymour</td>
                <td>34</td>
                <td>Male</td>
                <td>Azusa Street</td>
            </tr>
            <tr>
                <td>Jennie Evans Moore</td>
                <td>30</td>
                <td>Female</td>
                <td>Azusa Street</td>
            </tr>
        </tbody>
    </table>
</div>
```

## Forms

Standard form elements are styled. Use helper classes like `.h-full-width` for layout control. Custom select dropdowns use the `.ss-custom-select` wrapper.

```html
<form>
    <div>
        <label for="sampleInput">Your email</label>
        <input class="h-full-width" type="email" placeholder="test@mailbox.com" id="sampleInput">
    </div>
    <div>
        <label for="sampleRecipientInput">Reason for contacting</label>
        <div class="ss-custom-select">
            <select class="h-full-width" id="sampleRecipientInput">
                <option value="Option 1">Questions</option>
                <option value="Option 2">Report</option>
                <option value="Option 3">Others</option>
            </select>
        </div>
    </div>

    <label for="exampleMessage">Message</label>
    <textarea class="h-full-width" placeholder="Your message" id="exampleMessage"></textarea>

    <label class="h-add-bottom">
        <input type="checkbox">
        <span class="label-text">Send a copy to yourself</span>
    </label>

    <input class="btn--primary h-full-width" type="submit" value="Submit">
</form>
```

## Components

### Alert Boxes

Use `div` elements with `.alert-box` and modifier classes (`.alert-box--error`, `.alert-box--success`, `.alert-box--info`, `.alert-box--notice`). A close button is included.

```html
<div class="alert-box alert-box--error">
    <p>Error Message. Your Message Goes Here.</p>
    <span class="alert-box__close"></span>
</div>

<div class="alert-box alert-box--success">
    <p>Success Message. Your Message Goes Here.</p>
    <span class="alert-box__close"></span>
</div>

<div class="alert-box alert-box--info">
    <p>Info Message. Your Message Goes Here.</p>
    <span class="alert-box__close"></span>
</div>

<div class="alert-box alert-box--notice">
    <p>Notice Message. Your Message Goes Here.</p>
    <span class="alert-box__close"></span>
</div>
```

### Pagination

Use the `.pgn` class on a `<nav>` element containing a `<ul>` list of pagination links. Use specific classes for previous/next links, current page, and number links.

```html
<nav class="pgn">
    <ul>
        <li><span class="pgn__prev" href="#0"> Prev </span></li>
        <li><a class="pgn__num" href="#0">1</a></li>
        <li><span class="pgn__num current">2</span></li>
        <li><a class="pgn__num" href="#0">3</a></li>
        <li><span class="pgn__num dots">…</span></li>
        <li><a class="pgn__num" href="#0">8</a></li>
        <li><span class="pgn__next" href="#0"> Next </span></li>
    </ul>
</nav>
```

### Stats Tabs

Use the `.stats-tabs` class on a `<ul>` containing `<li><a>` elements.

```html
<ul class="stats-tabs">
    <li><a href="#0">1,234 <em>Peter</em></a></li>
    <li><a href="#0">567 <em>James</em></a></li>
    <li><a href="#0">23,456 <em>John</em></a></li>
    <!-- etc. -->
</ul>
```

### Code Blocks

Use `<pre>` and `<code>` tags for displaying blocks of code. Add language classes (e.g., `language-css`) for potential syntax highlighting.

```html
<pre><code class="language-css">
code {
    font-size: 1.4rem;
    margin: 0 .2rem;
    padding: .2rem .6rem;
    white-space: nowrap;
    background: #F1F1F1;
    border: 1px solid #E1E1E1;
    border-radius: 3px;
}
</code></pre>
```

---

This guide covers the most common styles and components demonstrated in `styles.html`. Refer to `css/styles.css` for the complete styling implementation.
