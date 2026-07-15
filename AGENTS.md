# AGENTS.md — personal-blog

## Tech Stack

- **Static site generator**: [Hugo](https://gohugo.io/) (extended, v0.161.1 via CI)
- **Theme**: Custom-built with [Neat CSS](https://github.com/codazoda/neatcss)
- **Output to `_docs/`** (not `public/` — this is configured for GitHub Pages)
- **Hosting**: GitHub Pages, deployed via GitHub Actions from the `gh-pages` branch
- **Domain**: justinmklam.com (managed at Namecheap)
- **Analytics**: Umami (production only)
- **Comments**: Giscus (GitHub Discussions-backed)
- **Fonts**: Atkinson Hyperlegible (headings/body), JetBrains Mono (code) — all self-hosted via `static/fonts/`

## Essential Commands

| Command | Action |
|---|---|
| `make build` | `hugo` — build site to `_docs/` |
| `make serve` | `hugo -D serve` — dev server (includes drafts) at localhost:1313 |
| `make serve-local` | Binds to all interfaces using host IP — for testing on other devices |
| `make clean` | Removes `_docs/` and `resources/_gen/` |
| `make new title="post-name"` | Creates `content/posts/YYYY/MM/post-name/index.md` (page bundle) |
| `make new-single title="post-name"` | Creates `content/posts/YYYY/MM/post-name.md` (flat file) |
| `hugo --minify` | Production build used in CI |

## Code Organization

```
config.yaml              # Hugo config (baseURL, menu, params, markdown, related content)
Makefile                 # build/serve/clean/new commands
archetypes/posts.md      # Front matter template for `make new`

content/
  about.md, colophon.md, contact.md, now.md, uses.md  # Pages (layout: basic)
  archives.md             # Archive listing (layout: archives, pageType: blog)
  projects.md             # Project listing (layout: archives, pageType: project)
  posts/YYYY/MM/slug/     # Blog posts as Hugo page bundles (index.md + images)
  .trash/                 # Deleted posts (git-ignored-ish, content remains)

layouts/
  index.html              # Homepage — shows latest 3 blog posts, greatest hits, latest 3 projects, tag cloud
  404.html                # 404 page with rabbit SVG
  _default/
    single.html           # Main blog/project post layout (layout: single)
    basic.html            # Minimal page layout (about, contact, colophon)
    archives.html         # Archive listing by year (used by /archives and /projects)
    rss.xml               # Custom RSS that filters to type=blog/project with layout=single
    _markup/
      render-image.html   # Hook: renders markdown images into responsive captioned figures/videos
      render-heading.html # Hook: adds clickable anchor links to headings
  partials/
    header.html           # <head> — SEO meta, Open Graph/Twitter cards, CSS pipeline, Umami, theme script
    navbar.html           # Nav bar with theme toggle button (sun/moon SVG icons)
    footer.html           # Copyright, RSS link, /colophon link
    footer-js.html        # MathJax, Feather icons, Giscus comment counts, theme toggle JS
    blog-metadata.html    # "Posted on X · Y min read · #tags" line used by blog-snippets and single
    blog-snippets.html    # Blog post preview card (title, metadata, image, summary, read more)
    giscus.html           # Giscus comment widget (disabled in dev mode)
    related.html          # Related posts via Hugo's .Related
    resize-image.html     # Image processing: resize to max 1920px, convert to JPG (skips GIF/PNG/SVG/WebP)
    support.html          # "Buy me a coffee / GitHub Sponsor / RSS" callout
    pagination.html       # (empty)
  shortcodes/
    img.html              # {{< img src="" caption="" >}} — deprecated in favor of render-image hook
    loop-vid.html         # {{< loop-vid src="" caption="" >}} — looping video with caption
    vid.html              # {{< vid src="" caption="" >}} — embedded iframe (YouTube, etc.)
    fb-video.html         # {{< fb-video src="" >}} — Facebook post embed
    current-date.html     # {{< current-date "Jan 2, 2006" >}} — renders current date
  taxonomy/tag.html       # Tag page (e.g., /tags/keyboards/)

assets/
  css/
    theme.css             # CSS custom properties (light/dark color scheme)
    custom.scss           # Layout, typography, navbar, code blocks, responsive tweaks
    neat.css              # Neat CSS framework (minimal classless CSS)
    syntax.css            # Light-mode syntax highlighting (Chroma)
    syntax-dark.css       # Dark-mode syntax highlighting (Chroma)
  js/giscus-comments.js   # Client-side Giscus comment count fetching
  icons/sun.svg, moon.svg # Theme toggle icons

static/
  fonts/, imgs/, files/   # Static assets served at root path
  .htaccess, CNAME        # GitHub Pages + Namecheap custom domain config
```

## Content Types & Front Matter

There are two content types, both using `layout: single`:

**Blog posts** (`type: blog`):
```yaml
---
title: Post Title
date: 2025-01-15T10:00:00-08:00
tagline: Short subtitle shown on listings
image: banner.jpg                    # Filename in page bundle; rendered as header image
image_source: https://...            # Source link for header image
image_source_text: "Photo by..."     # Source attribution text
tags: [tag1, tag2]
draft: true
updated:                             # Optional: "2025-02-01"
layout: single
type: blog
---
```

**Projects** (`type: project`): Same front matter, just `type: project`. Listed separately on homepage and `/projects`.

**Static pages** (`layout: basic`): Pages like /about, /colophon. No image processing, no comments, no related posts.

### Important: Page Bundles

Every post MUST use Hugo page bundles (a folder with `index.md` + assets). Images referenced in markdown are looked up as page resources via `Resources.Get`. If an image isn't found, Hugo logs a `warnf` at build time.

`make new` creates a page bundle under `content/posts/YYYY/MM/slug/`. `make new-single` creates a flat file — only use this for non-bundle content.

## Image Handling

Images in markdown (`![caption](file.jpg)`) go through `_markup/render-image.html`:

1. Strips `/static/` prefix from image paths (so `![x](/static/imgs/foo.jpg)` works in preview while rendering as `/imgs/foo.jpg`)
2. For page bundle images: resizes to max 1920px and converts to JPG (`resize-image.html`) — **skips GIF, PNG, SVG, WebP** (left as-is)
3. For non-bundle images (`static/`): passed through as-is
4. Wraps in a responsive `<figure>`-like div with caption and optional source attribution
5. MP4/WebM files get a `<video>` tag with autoplay+loop+muted+controls

To add source attribution in markdown:
```markdown
![Alt text](image.jpg "Source Name|https://example.com")
```

## Image Previews on Listings

`blog-snippets.html` picks up `.Params.image` as the preview thumbnail on homepage/archive views. It processes it through `resize-image.html`.

## Theme System

Light/dark mode uses **three mechanisms** working together:

1. **CSS custom properties** in `theme.css` define colors for `--dark`, `--lessdark`, `--link`, `--codebackground` etc. in both light and dark variants
2. **Inline script** in `header.html` checks localStorage first, then `prefers-color-scheme`, and sets `dark`/`light` class on `<html>` before rendering (prevents flash of wrong theme)
3. **Theme toggle button** in `navbar.html` swaps the class and saves to localStorage; also toggles syntax highlighting stylesheet and Giscus theme

The theme toggle JS in `footer-js.html` handles the cycle: dark → light → dark. The syntax-dark CSS media query is programmatically toggled.

**Gotcha**: The syntax highlighting stylesheets (`syntax.css` / `syntax-dark.css`) are loaded separately — the dark one has its `media` attribute toggled by JS rather than using `prefers-color-scheme`, so the syntax theme matches the manual toggle.

**Gotcha**: `header.html` has an inline `<script>` that runs before any CSS loads — this sets the initial `dark`/`light` class on `<html>`. This script MUST be inline and at the top of `<head>` to avoid a flash of wrong theme.

## Image Processing

`resize-image.html` is critical — it's called by both `render-image.html` (inline markdown images) and `blog-snippets.html` (listing thumbnails). It:

- Defines `$maxSizePx := 1920`
- For landscape images wider than 1920px: resizes to 1920px wide
- For portrait images taller than 1920px: resizes to 1920px tall
- For smaller images: just converts to JPG format without resizing
- GIF/PNG/SVG/WebP: left completely untouched (pass-through)
- Returns the processed image resource

## RSS

Custom RSS template in `_default/rss.xml`. Filters to only include pages where `(type == "blog" OR type == "project") AND layout == "single"`. Includes full content (`content:encoded`).

## Comments (Giscus)

Giscus is loaded in `giscus.html` using the `justinmklam/personal-blog` repo's GitHub Discussions. Disabled in development mode (`hugo.Environment == "development"`). The theme syncs with the site's dark/light toggle via `window.setGiscusTheme()`.

Comment counts on listing/blog-metadata use a separate JS bundle (`giscus-comments.js`).

## MathJax

Enabled per-page via front matter `math: true`. Loads `tex-chtml.js` from CDN. Uses Goldmark passthrough extensions — inline math with `\(...\)`, block math with `\[...\]` or `$$...$$`.

## Analytics (Umami)

Production only (`hugo.IsDevelopment` check). Umami script ID is `6b7445a7-ca25-4dcd-b8b0-453ee282678e`.

## Deployment

GitHub Actions workflow (`.github/workflows/main.yml`):
- Triggers on push to `main`
- Checks out with submodules and full history
- Uses `peaceiris/actions-hugo@v3` with Hugo v0.161.1 (extended)
- Runs `hugo --minify`
- Deploys `_docs/` to `gh-pages` branch via `peaceiris/actions-gh-pages@v3`

## Notable Gotchas

1. **`publishdir: _docs`** in `config.yaml` — NOT `public/`. The `_docs/` folder is the publish output and is git-ignored but used by GitHub Actions deployment.
2. **`disableKinds: [section, taxonomy]`** — Section and taxonomy list pages are disabled. Only the custom `tag.html` layout renders tag pages. Individual taxonomy pages still work (e.g., `/tags/keyboards/`).
3. **Front matter uses `type: blog` / `type: project`** and `layout: single` — these are separate concepts. `type` controls content classification; `layout` selects the template.
4. **`canonifyurls: false`** — URLs are NOT canonicalized. Be careful when constructing absolute URLs (the RSS feed and OG tags use `.Site.BaseURL` explicitly).
5. **Image path quirk**: Images in content can use `/static/` prefix in the markdown (so they render in GitHub preview), but `render-image.html` strips this prefix on build.
6. **`markup.goldmark.renderer.unsafe: true`** — raw HTML in markdown is allowed.
7. **`noClasses: false`** for syntax highlighting — Chroma generates inline styles instead of class-based highlighting, which lets the light/dark stylesheet swapping work.
8. **Page bundles only**: `Resources.Get` in `resize-image.html` will return nil if the image isn't in the page bundle. A `warnf` is logged if the image can't be found.
9. **`support.html`** partial is included on every blog post — it's the "Buy me a coffee / GitHub Sponsor / RSS" callout.
10. **`.trash/` folder** in content/posts — contains deleted drafts, not published content.
