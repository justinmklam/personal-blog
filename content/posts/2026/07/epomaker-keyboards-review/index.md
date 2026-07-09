---
title: Epomaker Keyboards Review
date: 2026-07-01T09:48:16-07:00
tagline: New keyboards, who dis?
image: DSCF3290.jpg
image_source:
image_source_text:
tags:
  - keyboards
  - review
draft: true
updated:
layout: single
type: blog
aliases:
---
After spending quite a bit of time in the land of ergonomic keyboards, I kind of turned my back to regular mechanical keyboards. But the landscape of mechanical keyboards has changed quite a bit in the recent years, where they're becoming more of an affordable commodity rather than needing to spend hundreds of dollars and waiting months for group buys to ship.

Epomaker reached out to me and asked if I'd like to try a few of their boards, and as a sucker for testing out new keyboards, I gladly obliged. Out of their roster, the keyboards that caught my eye and which I ended up requesting were:
- [Luma40](https://epomaker.com/products/epomaker-luma40) - a tiny ortholinear keyboard with an aluminum case
- [Hack70](https://epomaker.com/products/epomaker-hack70) - a mostly-ortholinear keyboard with a split spacebar
- [Split70](https://epomaker.com/products/epomaker-split70) - a traditional row-staggered split

Read on to find out what I thought about them!

<!--more-->

> Disclaimer: Epomaker sent me these keyboards for review, though all opinions are my own.
# Luma40

## Overview

The Luma40 is a 40% ortholinear board in a silver aluminum case. I've wanted to try a true ortholinear layout for years, and the Luma40 finally gave me an excuse. The aluminum case is enticing: hefty, solid, and feels more premium than the price suggests. It might not be the most ergonomic board, but it sure looks sleek.

The translucent keycaps let RGB shine through nicely. While the switches feel premium, the keycaps make the whole thing feel slightly cheaper than the rest of the board deserves. 

The bottom has thin rubber pads that keep it surprisingly sturdy despite how small it is. One quirk: the spacebar has no stabilizers, so it can feel a bit "bindy" depending on where you hit it. If you tend to press spacebar off-center, you'll notice it catching slightly.

![Luma40, lights off.](DSCF3255.jpg)

![RGB lights on!](DSCF3266.jpg)

As with all of Epomaker's boards, this one has three modes of connectivity: USB-C cable, USB-A dongle via 2.4GHz, or Bluetooth. VIA is used to remap the keyboard, which is a bit quirky because you need to manually upload the `.json` config to get the app to recognize the keyboard.

![View of the back showing the USB-C connector and wire/bluetooth toggle, as well as the mount point for the optional strap.](DSCF3258.jpg)

![Underside of the keyboard.](DSCF3270.jpg)

## Switches

These are low-profile linears — smooth travel, no tactile bump. Quiet and consistent, though if you're coming from a clicky or tactile switch the lack of feedback might feel weird. They're also not the thockiest, a shame with an aluminum case this nice. More of a muted clack than a deep thock. 

## Keycaps

The translucent material lets the underglow shine through nicely, but the profile itself is a mixed bag. The top surface of each keycap is a circular dish rather than the typical cylindrical or spherical scoop, which looks distinctive but isn't comfortable for extended typing. I kept slipping off the edges until I got used to it. If I were keeping this board, keycaps would be the first thing I'd swap.

![Close up of the keycap.](DSCF3446.jpg)

## Teardown

With a 40% board, layers are everything. You don't have enough keys for every function, so modifiers give you secondary layers. Five small screws and the PCB lifts free, revealing foam at the bottom for sound dampening.

![Keycaps removed.](DSCF3416.jpg)

![PCB removed, exposing a foam panel at the bottom of the case.](DSCF3424.jpg)

The 1450mAh battery is thin and glued to the case, and connected to the PCB with what looks like a standard JST connector. Good for modularity, but replacement down the road might be troublesome. The microcontroller is some unknown MILLER chip that didn't yield any search results.

![1450mAh battery is nice and thin, glued securely to the case.](DSCF3433.jpg)

![Close up of the PCB.](DSCF3435.jpg)

Even though the switches are supposed to be hot-swappable, the plate tolerances seemed way too tight and made it almost impossible to remove the switch. I was able to remove the one in the corner after wiggling it out (since I wanted to see what was underneath the plate, which turned out to be a nice little gasket for additional damping), but I didn't have any luck removing any others without risk of damaging the switch.

![Switch removed, exposing thin gasket between the plate and PCB.](DSCF3440.jpg)

## Using It

So who is this for? The Luma40 would make a nice TV or couch keyboard if you have a computer connected to your television — the compact size and optional carrying strap practically beg for it. The single spacebar sits between the B and N keys, the standard ortholinear position. Feels natural once you adjust. Honestly, this board grew on me the more I used it. First impressions weren't the best — the keycaps, mainly — but the solid aluminum case and the fun of typing on such a tiny, dense board won me over. It's not a daily driver for me, but it's charming in a way that bigger boards aren't.

# Hack70

## Overview

The Hack70 is the most interesting of the three on paper. Ortholinear, but larger than the Luma40, fitting quite a few keys into a compact package. The layout is smart: less desk space than a standard 65% board, so less distance to reach for your mouse. It uses **QMK firmware**, which means it's fully programmable. You can remap any key, set up layers, customize to your heart's content. The catch is it's only programmable via **VIA**, a web-based tool. Fine for basic remapping, but no support for QMK's advanced features like combos or tap-dance.

The keycap legends are crisp and modern. Print quality is good. The plate sits on soft gaskets rather than screwing directly into the case. Softer, cushioned feel. Better sound. I like the split spacebar — two separate space keys instead of one long one. You can use one as a dedicated layer key, so SpaceFN (holding space as a modifier) works without the input lag you'd get from a software solution. I use a layer for arrow keys on HJKL and hotkeys like browser forward/back, tab switching, and workspace changes.

Connectivity: wired USB-C, Bluetooth, or a USB-A dongle. The backside has a toggle for switching between them, and the dongle lives in a small compartment on the underside. RGB is there if that's your thing. There's a separate LED indicator on the left side, handy for telling which layer or connection mode was active. Adjustable feet with two different height options.

![Hack70 Keyboard.](DSCF3224.jpg)

Interesting choice. Backspace and enter keys are 2U on a mostly-ortholinear board. Looks nice, but adds layout quirks I'll get to later.

![Close up of the backspace and enter keys.](DSCF3235.jpg)

Connectivity can be wired via USB-C, bluetooth, or USB-A receiver/dongle.

![Backside showing three options of connectivity.](DSCF3229.jpg)

![USB dongle removed from the insert.](DSCF3230.jpg)

RGB lights if that's your thing. Separate LED shine-through on the left is a nice touch.

![](DSCF3236.jpg)

![Keycaps removed showing the underglow of the RGB LEDs.](DSCF3242.jpg)

Includes adjustable feet, two different height options.

![Underside of the keyboard.](DSCF3271.jpg)

![With the low keyboard feet.](DSCF3274.jpg)

![With the higher keyboard feet.](DSCF3272.jpg)

## Switches

The Hack70 comes with Epomaker's Creamy Jade switches. Linear, factory-lubed, smooth and quiet. Typing is pleasant — soft, cushioned bottom-out that makes long sessions comfortable. The sound is a deep, rounded thock, not a sharp clack. Not the most exciting switches, but consistent and pleasant. Better than many stock switches at this price.

## Keycaps

The keycaps are **XDA profile** PBT — durable plastic that doesn't shine over time, uniform height. For an ortholinear board, the uniform height matches the grid layout. The legends are crisp and the font is modern and clean. XDA's flat, wide surface can feel a bit alien if you're coming from a sculpted profile like Cherry or OEM, but you adapt quickly.

## Build Quality

Overall the build quality is excellent, but the left spacebar is slightly lower and warped compared to the right. Doesn't affect functionality — both keys register — but it's visually noticeable. Stabilizers are otherwise fine, and the orange gasket pieces give a nice bit of color when you peek under the keycaps.

![Left spacebar is slightly deformed and lower than the right.](DSCF3250.jpg)

## Layout

Here's where the Hack70 falls apart. The backspace and enter keys are 2U wide — the space of two standard keys — on a board that's otherwise a strict grid. Looks nice, but adds layout quirks. The backtick key sits between the apostrophe and enter, so it's easy to accidentally hit tilde when you meant to press enter.

Spacebar. The real problem. Instead of sitting directly below the N key (standard ortholinear), the dual spacebars are slightly offset. You have to tuck your thumb inward to hit them, which threw off my typing for days. I kept making mistakes and couldn't figure out why until I looked down and realized my thumbs were landing in the wrong spots. It's not a purist complaint — it's a practical issue because the spacebar isn't where your thumb expects. It uses what looks like a regular shift key (1.25U) and a split spacebar (1.75U). For comparison, the Luma40's single spacebar sits right between the B and N, which feels natural. I'd have preferred two 2U spacebars under the V/B and N/M columns, which would also free up an extra key below the comma. Or just make the backspace and enter standard 1U keys and shrink the board by one column.

Everything else about the keyboard is great, but the layout is frustrating for anyone already used to ortholinear. You have to unlearn muscle memory, not just adjust. If you've never used ortholinear before, you might not notice, but if you're coming from another ortho board, prepare for an adjustment period.

![Sadly the spacebars are not aligned to the columns...](DSCF3390.jpg)

![](DSCF3580.jpg)

![](DSCF3576.jpg)

## Teardown (Attempt)

I wanted to take the Hack70 apart to see the gasket mount, but ran into a wall — literally. No visible screws on the exterior, and the enclosure is held together with plastic clips that are incredibly tight. I didn't have a prying tool thin enough to get in the seam without risking damage, so I had to stop at removing the keycaps and switches. Stabilizers are visible with the keycaps off, and the orange pieces appear to be part of the gasket mount. Switches come out easily, which is good if you want to try different ones. But getting in without specialized tools is going to be tough if something breaks.

![Keycaps removed.](DSCF3395.jpg)

![Close up of the stabilizers. Orange piece appears to be part of the gasket mount.](DSCF3397.jpg)

![Switches removed.](DSCF3457.jpg)

No screws, didn't have a tool thin enough to pry apart the enclosure, so unfortunately couldn't tear it down further.

![Close up of the keyboard enclosure.](DSCF3472.jpg)

# Split70

## Overview

The Split70 is a split row-staggered keyboard — two halves that separate, with keys in traditional staggered rows. My unit is white with blue accents, Wisteria Linear V2 switches. The left half has a volume knob and dedicated macro keys, both feel premium and are actually useful. The interface between halves is magnetic, which keeps them aligned when together but lets you separate them easily for ergonomic positioning. Row-staggered splits take up more desk space than you'd think though, especially with the inner gap between halves.

![](DSCF3294.jpg)

![](DSCF3301.jpg)

Again, backside shows all the connections (wired, Bluetooth, or dongle). The far left usb port is to connect the two halves.

![](DSCF3303.jpg)

Backside. No adjustable feet if that's your thing, but nice sturdy rubber pads to keep it still.

![Backside. No adjustable feet if that's your thing, but nice sturdy rubber pads to keep it still.](DSCF3309.jpg)

## Switches

The Wisteria Linear V2 switches are smooth and quiet — a bit lighter than the Creamy Jades, more neutral in sound. No noticeable scratchiness or inconsistency. If you're coming from a membrane or cheap mech board, these will feel like a big upgrade. Enthusiasts can happily use them without swapping.

## Keycaps

The keycaps are functional but not remarkable. The legends aren't crisp — there's a slight softness to the printing that makes them look less premium than the Hack70's. They get the job done. At this price point, it's not a dealbreaker, but it's where the cost cutting shows.

## Layout

The B key problem on row-staggered splits: many people hit B with their right index finger on a standard keyboard, but on most splits it ends up on the left half. The Split70 solves this by putting B on both sides. Saves a lot of frustration.

The right shift is a single 1U key instead of the more common 2.75U, annoying if you use right shift often. Otherwise the layout is fairly standard for a split 65%. The inner gap between halves is larger than I'd like, but that's row-staggered splits for you.

# Final Thoughts

I'm impressed with what Epomaker is delivering at these prices. The Hack70 at $89.99 USD is the best value — sounds great, feels great, fully programmable. The Luma40 and Split70 at $115.99 USD are solid too, but each has its quirks. The Luma40's keycaps are its biggest weakness, and the Split70's legends and lack of adjustable feet are minor disappointments.

Having been in the ergo mech scene for so long, I'd forgotten how nice regular mechanical keyboards can sound. The Hack70's gasket mount and sound quality would have cost you twice as much not long ago.

The spacebar design on the Hack70 leaves a stain on what would otherwise be a near-perfect board, and the enter and backspace keys on an otherwise clean ortholinear layout feel like missed opportunities. The Hack70 and Split70 have no exposed screws, which makes them much harder to repair or mod. Manufacturers do this because it looks cleaner. I like to tinker, so it's frustrating. The Luma40, at least, is straightforward to open.

New to mechanical keyboards? The Hack70 is the easy recommendation. The Luma40 is a fun niche board for the ortholinear-curious, and the Split70 is a decent entry point into split keyboards if you're not ready to commit to the deep end of custom ergo boards. None of them are perfect, but at these prices, they don't need to be.

Happy typing!
