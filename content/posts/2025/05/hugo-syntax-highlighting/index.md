+++
layout =    "single"
type =      "blog"

date =      2025-05-19T08:47:00-07:00
draft =     false

title =     "Adaptive Syntax Highlighting for Light & Dark Modes in Hugo"
tagline =   ""
image =     ""
tags =      ["today-i-learned", "programming"]

aliases =   []
+++

Hugo has built in support for [syntax highlighting using Chroma](https://gohugo.io/content-management/syntax-highlighting/), but the default configuration doesn't allow for dynamically setting light/dark syntax highlighting. Fortunately there's an easy workaround with a few configs!

<!--more-->

By default, your `config.toml` may look something like this, which tells the renderer to use the `monokai` style everywhere:

```toml
[markup]
  [markup.highlight]
    style = monokai
```

Instead, we can set `noClasses=false` to use an external stylesheet, which will allow us to dynamically set the theme depending if the current colour scheme is light or dark. Change the `config.toml` to this instead:

```toml
[markup]
  [markup.highlight]
    guessSyntax = true
    noClasses = false
```

And then generate your desired stylesheets using the [Hugo CLI](https://gohugo.io/commands/hugo_gen_chromastyles/) (see [here](https://gohugo.io/quick-reference/syntax-highlighting-styles/) for the full list of supported themes):

```sh
# Light mode
hugo gen chromastyles --style=monokailight > static/css/syntax.css
# Dark mode
hugo gen chromastyles --style=monokai > static/css/syntax-dark.css
```

And then include the following in your header to use these stylesheets depending on the colour scheme:

```html
<link rel="stylesheet" href="/css/syntax.css" media="screen">
<link rel="stylesheet" href="/css/syntax-dark.css" media="screen and (prefers-color-scheme: dark)">
```

<hr>

Depending on your other stylesheets, this may be all you need. However, if this still results in some wonky dark mode colours, you can make some manual edits to fix it. The exported chroma stylesheet contains empty classes, which normally would inherit the default text colour from your site, but since we're defining two stylesheets, it may end up inheriting from the light theme instead. 

To resolve this, we'll need to do a **search and replace** of `{  }` to `{ color:inherit }` in the second stylesheet, to properly render the text colours based on the colour scheme. So change this:

```css
/* Generated using: hugo gen chromastyles --style=monokai */

/* Background */ .bg { color:#f8f8f2;background-color:#272822; }
/* PreWrapper */ .chroma { color:#f8f8f2;background-color:#272822; }
/* Other */ .chroma .x {  }
...
```

To this:

```css {hl_lines=[5]}
/* Generated using: hugo gen chromastyles --style=monokai */

/* Background */ .bg { color:#f8f8f2;background-color:#272822; }
/* PreWrapper */ .chroma { color:#f8f8f2;background-color:#272822; }
/* Other */ .chroma .x { color:inherit }
...
```

Optionally, you can add the following to change the background dynamically in your main stylesheet, along with any other additional styles:

```css
:root {
  /* Light background */
  --codebackground: #fafafa;
}

@media (prefers-color-scheme: dark) {
  :root {
    /* Dark background */
    --codebackground: #282828;
  }
}

pre {
  /* This sets the codeblock background, e.g. if you don't like the default colour */
  background-color: var(--codebackground) !important;
}

code {
  /* This sets the inline code background */
  background-color: var(--codebackground);
}

pre code {
  /* You may need this so the default text inherits
  the correct light/dark text color from your own stylesheet*/
  color: inherit;
}
```

Now your site will have consistently themed syntax highlighting!