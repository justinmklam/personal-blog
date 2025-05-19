+++
date = "2025-05-18T13:48:02-07:00"
draft = false
title = "Colophon"
hidedate = true
layout = "basic"
+++

This site has gone through multiple iterations over the years. In 2015, the inception of my personal blog was created on [Wordpress](https://wordpress.com/) and hosted on [Bluehost](https://www.bluehost.ca/), and was intended to be a portfolio of my personal projects to showcase when applying to jobs. I spent a lot of time hunting for a suitable theme, and stuck with one for about a year.

In 2016, I wanted to start writing blog posts instead of just having a portfolio, and since I wanted more flexibility in how I was displaying content, I ventured into static site generators and settled on [Hugo](https://gohugo.io/) and used [Bootstrap](https://getbootstrap.com/) to create a custom theme. Later on, as I matured in my career, I realized that having a portfolio was no longer as relevant, so I combined the two types of content into a single blog-like website.

In 2019, I updated the styling to use more modern themeing. Then in 2021, I tried optimizing the git history to reduce the size when checking out, but made some critical errors (in not understanding what commands[^1] I was executing from [StackOverflow](https://stackoverflow.com/questions)) and had migrated to a new repo since, at the time, it was easier to start fresh than try and fix the mess that I made.

[^1]: Pro tip: Don't run `git filter-repo --strip-blobs-bigger-than 1M` thinking that it won't also nuke all your currently used media files above that size.

Returning from a break of creating content in 2025, I had a wave of motivation to update my website yet again. This current version is the third (and hopefully final) iteration, which does away with Bootstrap in favour of a more lightweight option. The site’s design uses plain HTML, CSS, and very minimal Javascript, and is based on a custom theme styled with [Neat CSS](https://github.com/codazoda/neatcss). The typeface leverages `system-ui` instead of custom typography from [Google Fonts](https://fonts.google.com/) to ensure fast page rendering and avoid the dreaded [FOUT](https://en.wikipedia.org/wiki/Flash_of_unstyled_content).

Content is written in [Goldmark-powered Markdown](https://github.com/yuin/goldmark). Code syntax highlighting is enabled by [Chroma](https://github.com/alecthomas/chroma). Mathematical formulas are rendered by [Mathjax](https://www.mathjax.org/). Icons are provided by [Font Awesome](https://fontawesome.com/).

Domain management and DNS are handled through [Namecheap](https://www.namecheap.com/). Hosting is managed by [Github Pages](https://pages.github.com/), where the site's content is stored in [this repository](https://github.com/justinmklam/personal-blog) and deployed automatically via [Github Actions](https://github.com/features/actions).

This site uses [Google Analytics](https://marketingplatform.google.com/about/analytics/) to help understand visitor traffic and usage patterns. Data collected is anonymous and used solely for improving the website experience.

