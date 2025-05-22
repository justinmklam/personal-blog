+++
title =     "Corne Keyboard"
date =      2025-05-19T15:57:51-07:00
tagline =   ""
image =     "corne.JPEG"
tags =      [""]
draft =     true

layout =    "single"
type =      "blog"
aliases =   []
+++

Been using a split ergonomic mechanical keyboard for 6 months. This is how it's going.

<!--more-->

- July 2016: Cmstorm tkl blue
- Aug 2016: Lenovo 
- Sep 2017: Poker 61 cherry black
- Nov 2017: Havit 87 blue kaihl switches
- March 2019: Tada68 with gateron silent red
Started off with a paltry 50 wpm, steadily increased back up to my normal typing speed.

![Steadily increasing WPM](pic-monkeytype.png)

Tried going full ergo, but didn't really work with my set up. Was too high for my elbows.

![Ergonomics](pic-ergo.png)
Tried different switches.
![](Pasted%20image%2020250519162513.png)

Mimicking the use of layers on a normal qwerty using [keyd](https://github.com/rvaiya/keyd).

```ini
[ids]
*

[main]
capslock = overload(control, esc)
j+k = esc
=+backspace = C-backspace
meta = layer(meta)

[meta]
h = left
j = down
k = up
l = right
```

Test edit from mobile
