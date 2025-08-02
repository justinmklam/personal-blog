---
title: Handwiring a 36-Key Sculpted Keyboard
date: 2025-08-02T14:35:20-07:00
tagline: 
image: skeletyl.jpg
tags:
  - keyboards
draft: true
layout: single
type: project
aliases:
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

<!--more-->
# Bill of Materials

My friend from [Ember Prototypes](https://www.emberprototypes.com/) was kind enough to print the case for me, but if you don't have access to a 3D printer yourself or a friend who does, many local libraries have them and are very affordable. Otherwise, places like JLCPCB offer printing for not too much. 

Total cost for my build was **~$70 CAD**. Aside from the case, all parts were sourced from Amazon and Aliexpress.

If you're looking to build one yourself, based on the parts I found it can range from **$45-100 CAD**. Getting the build to be <$40 would likely be possible if you hunt a bit harder for better deals and cheaper switches and/or keycaps. Alternatively, 3D printing your own keycaps is an option to further reduce costs.

For my build, I chose the same TTC Frozen Silent v2 switches that I used on my [Corne keyboard](/posts/2025/05/corne-keyboard).

| Part                           | Quantity | Cost (in CAD) |
| ------------------------------ | -------- | ------------- |
| 3D printed case (top + bottom) | 2        | $0-15         |
| M4 heat-set threaded inserts   | 12       | $2            |
| M4 5mm fasteners               | 12       | $3            |
| 1N4148 diodes (through hole)   | 36       | $1            |
| TRRS connectors                | 2        | $3            |
| RP2040 Zero dev board          | 2        | $12           |
| TRS cable                      | 1        | $4            |
| MX switches                    | 36       | $5-30         |
| MX-compatible keycaps          | 36       | $15-30        |

# The Build

## Schematic
[insert wiring diagram]

## Assembling the Hardware

![Test fitting the switches and a few keycaps to get a sense of how the sculpted profile feels.](IMG_4286.jpg)

![Using a soldering iron to install the heatset inserts.](IMG_4271.jpg)


![Coiling the diode leg to make it easier to attach to the switch pin.](IMG_4275.jpg)

![Diodes placed, marking the wire locations to splice.](IMG_4318.jpg)

![Using basic wire cutters and an x-acto knife to expose the wire.](stripping-wires.jpg)

![Rows and columns all connected!](IMG_4303.jpg)

![Close up of how I wired the thumb cluster keys.](IMG_4304.jpg)

![RP2040-Zero all wired up.](mcu-wiring.jpg)


![Build complete!](IMG_4334.jpg)

![Securing components with "structural" hot glue.](IMG_4371.jpg)

![Right half shows the bottom plate with rubber feet installed.](IMG_4372.jpg)

## Compiling QMK

# The Finished Keyboard

![Ready for typing!](IMG_4611.jpg)