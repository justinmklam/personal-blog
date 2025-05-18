# Personal Project Website
Increasing my online presence by showcasing projects and posts that I've worked on over the years.

# Dependencies
+ Static website built with [Hugo](https://gohugo.io/)
+ Custom theme built with [Neat CSS](https://github.com/codazoda/neatcss)

*Note: Install hugo via `snap` instead of `apt` to get the latest version.*

# How To Use
## Basic Hugo commands
To compile the website (where output is in `docs/` folder):

```
make build
```

To start a local server for live website testing (at localhost:1313):
```
make serve
```
## Adding Content

To create a new blog post:
```
make new title="my-blog-post"
```

__Note:__ Using page bundles, post images can be uploaded in the same directory as the post. All other assets (header images, files, etc.) should be uploaded to the `static/` directory.

## Publishing

Publishing is done via Github Actions on commits on main, and deployed via the `gh-pages` branch.

# Notes
## Namecheap Setup for Custom Domain
These settings are managed under the `Advanced DNS` tab. See [GitHub Help](https://help.github.com/en/articles/setting-up-an-apex-domain#configuring-a-records-with-your-dns-provider) for details.

| Type | Host | Value | TTL |
|---|---|---|---|
| A Record | @ | 185.199.108.153 | Automatic |
| A Record | @ | 185.199.109.153 | Automatic |
| A Record | @ | 185.199.110.153 | Automatic |
| A Record | @ | 185.199.111.153 | Automatic |
| CNAME Record | www | justinmklam.github.io. | Automatic |
| TXT Record | @ | google-site-verification=[KEY] | Automatic |
