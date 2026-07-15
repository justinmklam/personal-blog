---
title: "Dev Log 1: Dreaming of my Perfect Keyboard"
date: 2025-11-15T22:18:06-08:00
tagline:
image: mystery-keycap.png
image_source: https://www.royalkeycaps.com/product/mario-mystery-block-keycap/
image_source_text: Royal Keycaps
tags:
  - keyboards
  - devlog
  - dabao
draft: true
layout: single
type: blog
aliases:
---

They say the endgame keyboard doesn't exist, but it doesn't mean there haven't been attempts to achieve it. After having been through a handful of keyboards (42-key Corne, 36-key Corne, then a Skeletyl), I developed a few of my own requirements that I haven't yet come across in a keyboard.

And so, begins my journey of designing my own keyboard.

<!--more-->

# Design Requirements

## (Mostly) Wireless
When I'm at my desk, I don't mind wired. Although the aesthetic isn't as nice, the keyboard isn't moving around often so it's easy to keep the cable out of the way. It also means one less thing to charge, which is nice. However, having a wireless keyboard is more handy when using it on the go with a laptop.

Most wireless splits have individual batteries, where the main half drains much faster than the peripheral. Some people get around this by having a dongle so both halves act as peripherals, but this isn't viable when on the go. Also having two batteries to manage that discharge at different rates is not enticing.

## Integrated Pointing Device
Not needing to move hands to the mouse is ideal. The best option of avoiding mouse use is hotkeys, where I personally use vim-oriented shortcuts wherever possible. QMK and ZMK both have the ability to control the mouse via mouse keys, but it's a little finicky to use. Sometimes the most efficient way is to use an actual pointing device though.

Trackballs are popular options, but not great for portability and also require maintenance of having to be lubed and kept clean. With my floor desk and dog, this will be very difficult for me.

Touchpads are a nice option in theory, but usually their small size renders them fairly unusable. Their precision is also usually not as good, especially when compared to macbook touchpads.

Trackpoints address these issues, with the caveat of having a learning curve. However, having used Thinkpads for quite some time, I'm a big fan of the nipple. I do find they tend to slip a little since my fingers run moist, but usually only an issue in the warmer months.

## Split AND Unibody
Most people (including myself) want split keyboards to provide maximum flexibility in how each half is positioned on a desk. However, when I use my laptop on the couch or when space is tight, it's easier to have a unibody in those situations since one piece is easier to manage than two separate halves (especially if they're wired).

## Low Profile Switches
Choc is the way to go for portability.

# Design Inspiration
- Santoku
- Duet
- Totem - sleek
- Tempest - Enticing splay
- Cheapino - practical
- Ferris OG - wired, gpio expander

# Design Questions

## How to Make it Convertible?

### Magnets?
How would this be achieved? Well, that's the main novel element of this design exercise. Keyboards these days are mainly slight layout variants of others, where it consists of one (or two) microcontrollers, diodes, and switches. Fairly simple. But for this, the challenge will be to figure out how to join the two together...

I came across this other keyboard that uses a magnetic connector, which I thought was a great idea. And these can be found on Aliexpress. However, this particular keyboard only works as a unibody.

My initial thought was to have one connector to connect it as a unibody, and another connector to be used as a cable for when it's split.

### Why Not a Unibody Case?
You may be wondering, why not just take an existing wireless keyboard and modify the case to allow it to unite as a unibody keyboard? It would definitely be easier, but I don't want to deal with having to charge two things. By having a unibody design, it also:
- Keeps the costs lower of not having to buy two microcontrollers and batteries
- Makes it easier to program since flashing two halves is not needed

### What Type of Cable?
My initial plan was to use a single cable to pass through all 9 wires. There aren't many off the shelf cables that have this many conductors, but some are:
- VGA
- HDMI
- Ethernet
- USB C

VGA and HDMI are quite big. Ethernet is used in Cheapino and it's not terrible, but unfortunately it only has 8 conductors. USB has a whopping 24 pins, and although some are duplicated because of reversibility, I thought it would still have enough.

Turns out I was wrong...

It would also be nice to use the same cable for charging and for connecting the two halves. But even though it's technically possible, I also wanted to not have to use a special usb c cable since they're not all the same, and it's hard to know how many conductors are actually connected without testing continuity.

< talk about usb c spec >

So thus, I need to ues the MP3017, which communicates over I2C and needs 4 wires. I could use TRRS like other keyboards, but that poses a risk of shorting when unplugging if the keyboard is on.

## Where to Source the Trackpoint?
Harvest from Thinkpad keyboards, but kind of expensive. Sprintek also sells them, but it's quite expensive due to shipping costs of just buying one.

Subreddit is present but Discord is more active, was linked to an Aliexpress seller who you can message to ask about buying a trackpoint module directly.

## What Microcontroller
NiceNano and its pro micro variants are popular, but Xiao is also nice because of how small it is. I had an extra Xiao RP2040 from my handwired skeletyl build, but it doesn't support wireless. Also Xiao doesn't have enough pins for all my needs.

# Final Thoughts
- [ ] Figured out the design of what I could, excited to start prototyping!
