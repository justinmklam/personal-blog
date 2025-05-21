+++
title =     "Obsidian Blog Workflow"
date =      2025-05-19T16:06:14-07:00
tagline =   ""
image =     ""
tags =      [""]
draft =     true

layout =    "single"
type =      "blog"
aliases =   []
+++

This is my new blogging workflow.

<!--more-->

Be sure to disable "Use Wikilinks" so that markdown format is used for image links, and select "Default location for new attachments" is set to the "Same folder as current file", which works well if page bundles are used.

![Obsidian settings](Pasted%20image%2020250519160808.png)

Git set up:

```sh
git clone -n --depth=1 --filter=tree:0 https://github.com/justinmklam/personal-blog.git

cd personal-blog

git sparse-checkout set --no-cone /content

git checkout

git fetch origin drafts

git checkout -b drafts FETCH_HEAD

# to store credentials for next time, with PAT
git config --global credential.helper 'store --file ~/.my-credentials'
```
