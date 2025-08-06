---
title: Handwiring a 36-Key Sculpted Keyboard
date: 2025-08-02T14:35:20-07:00
tagline: Diving off the deep end of ergonomic keyboards by building my own.
image: DSCF1858.jpg
tags:
  - keyboards
draft: false
layout: single
type: project
aliases:
---
As I continued the descent into my split ergonomic keyboard addiction, I decided to dive off the deep end and handwire a 36-key split, sculpted keyboard.

My [Corne](/posts/2025/05/corne-keyboard) was a good intro keyboard, but I eventually determined it had more keys than [I actually needed](/posts/2025/07/36-key-layout). I also grew intrigued towards keyboards with better ergonomics - more stagger and splay to improve alignment with ring and pinky fingers, as well as keyboards with sculpted, organic surfaces to better follow my hand’s natural shape. 

<!--more-->

Other keyboards like the [Charybdis](https://github.com/Bastardkb/Charybdis) seemed to be quite popular, but I was searching for something smaller and less bulky looking. I also didn’t want to design my own using [Cosmos](https://ryanis.cool/cosmos/) just yet, since I knew it’d take a few iterations to get right and be difficult without my own 3D printer.

The [Skeletyl](https://github.com/Bastardkb/Skeletyl) spoke to me on an intimate level, and although it lacked an integrated pointing device like a trackpoint, it checked enough boxes that I became sold on that form factor.

Since I had never used a keyboard like this before, I was hesitant to put too much money into it. Prebuilt options and kits were going for >$300 CAD, which was more than I was willing to empty my wallet with for something that may or may not work long term for me. Although I could have sourced the PCBs and parts myself, this was a great opportunity to get my extremities wet with handwiring since it would keep costs low, as well as being suited well for a complex-shaped board like this one. 

With the decision made, I began my journey.

![The completed Skeletyl in its natural habitat.](DSCF1925.jpg)

![Close up of the left half. The sparkle pattern comes through quite well!](DSCF1888.jpg)

![Backside of the keyboard showing the USB-C and TRS ports.](DSCF1900.jpg)
# The Build

## Bill of Materials

My friend from [Ember Prototypes](https://www.emberprototypes.com/) was kind enough to print the case for me, but if you don't have access to a 3D printer yourself or a friend who does, many local libraries have them and are very affordable. Otherwise, places like JLCPCB offer printing for not too much. 

Total cost for my build was **~$70 CAD**, where $45 of it was from the keycaps and (relatively expensive) switches. Aside from the case, all parts were sourced from Amazon and Aliexpress.

If you're looking to build one yourself, based on the parts I found it can range from **$45-100 CAD**. Getting the build to be <$40 would likely be possible if you hunt a bit harder for better deals, especially since switches and keycaps make up for a large portion of the overall cost. Alternatively, 3D printing your own keycaps is an option to further save some money.

For my build, I chose the same TTC Frozen Silent v2 switches that I used on my [Corne keyboard](/posts/2025/05/corne-keyboard), and I bought blank PBT in the XDA profile. I tried Cherry/OEM profile, but I wasn’t a fan of feel or look of the sharp corners.

| Part                           | Quantity | Cost (in CAD) |
| ------------------------------ | -------- | ------------- |
| 3D printed case (top + bottom) | 2        | $0-15         |
| M4 heat-set threaded inserts   | 12       | $2            |
| M4 5mm fasteners               | 12       | $3            |
| 1N4148 diodes (through hole)   | 36       | $1            |
| TRS/TRRS connectors            | 2        | $3            |
| RP2040 Zero dev board          | 2        | $12           |
| TRS cable                      | 1        | $4            |
| MX switches                    | 36       | $5-30         |
| MX-compatible keycaps          | 36       | $15-30        |

## Schematic

The wiring followed a basic row/column matrix, where the diodes were connected along the rows, and the remaining switch legs were wired directly together in columns.

On the MCU, the pins required were:
- Switch matrix, 4 rows x 5 columns = 9 GPIO pins
- TRS connector (soft serial) = 1 GPIO pin, VCC, GND

![RP2040 Pinout.](rp2040.png "Waveshare|https://www.waveshare.com/rp2040-zero.htm")

It didn't really matter which pins I used for the cols/rows, but these are the ones I chose which were then mapped to the QMK like so (full config [below](#qmk)):

```json
	...
    "matrix_pins": {
        "cols": ["GP4", "GP5", "GP6", "GP7", "GP8"],
        "rows": ["GP9", "GP10", "GP11", "GP12"]
    },
    "split": {
		...
        "soft_serial_pin": "GP1",
        "matrix_pins": {
            "right": {
                "cols": ["GP8", "GP7", "GP6", "GP5", "GP4"],
                "rows": ["GP9", "GP10", "GP11", "GP12"]
            }
        }
    },
	...
```
## Assembling the Hardware
Pictures below show the build process. The case was printed on a [Bambu Lab P1S](https://ca.store.bambulab.com/products/p1s) in the [Onyx Black PLA Sparkle](https://ca.store.bambulab.com/products/pla-sparkle?id=43809130152176).

![Test fitting the switches and a few keycaps to get a sense of how the sculpted profile feels.](IMG_4286.jpg)

![Using a soldering iron to install the heatset inserts.](IMG_4271.jpg)


![Coiling the diode leg to make it easier to attach to the switch pin.](IMG_4275.jpg)

![Diodes placed, marking the wire locations to splice.](IMG_4318.jpg)

For splicing the wire, this turned out to be easier to do than expected. Joe Scotto’s way is to use bare copper wire and heat shrink the intersections, but I don’t think it’s actually that much faster since it still takes time to cut, place, and heat the heat shrink.

![Using basic wire cutters and an x-acto knife to expose the wire.](stripping-wires.jpg)

![Rows and columns all connected!](IMG_4303.jpg)

One weird aspect of sculpted keyboards is how the thumb clusters are on a different plane than the rest of the keys. The wiring ended up looking a little funny, but I wanted to hide it reasonably well to prevent them peeking through the exposed sections of the case. 

![Close up of how I wired the thumb cluster keys.](IMG_4304.jpg)

With the matrix all done, all that was left was to wire each row and column to the MCU. I chose to solder these blue wires at the ends of each row and column to keep things looking tidy. The MCU was oriented upside down so the reset buttons would still be easily accessible when fully assembled.

For the TRS connector, I initially bought ones on breakout boards, but it turned out to be way too bulky so I had to desolder it. Was a bit of a pain, but it worked out in the end.

![RP2040-Zero all wired up.](mcu-wiring.jpg)

Doing everything again for the other half, and it was complete!

![Build complete!](IMG_4334.jpg)

I initially thought to design a nice 3D printed bracket to hold the MCU and TRS connector, but I was impatient and opted for the hacky way of just using hot glue since I was likely only going to be building this once.

Surprisingly, the glue was sturdy enough to hold the components in place even when plugging/unplugging the cables from them.

![Securing components with "structural" hot glue.](IMG_4371.jpg)


## Compiling the Firmware

### QMK

I followed the [QMK tutorial](https://docs.qmk.fm/newbs) and forked the repo, ran the new keyboard command, and then updated the config. With the RP2040, the bootloader and processor needed to just be RP2040 instead of the dev board, which was one of the default options.

It took a while to figure out what the correct configuration was for the layout, but I eventually got it done with a bit of help from ChatGPT.

```c
#pragma once

/* RP2040- and hardware-specific config */
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET // Activates the double-tap behavior
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET_TIMEOUT 500U
#define PICO_XOSC_STARTUP_DELAY_MULTIPLIER 64

#define SERIAL_PIO_USE_PIO1
```

In `rules.mk`:
```
SERIAL_DRIVER = vendor
```

And the `keyboard.json`:
```json
{
    "manufacturer": "Justin Lam",
    "keyboard_name": "skeletyl",
    "maintainer": "Justin Lam",
    "bootloader": "rp2040",
    "processor": "RP2040",
    "diode_direction": "COL2ROW",
    "features": {
        "bootmagic": false,
        "extrakey": false,
        "mousekey": true,
        "nkro": false
    },
    "matrix_pins": {
        "cols": ["GP4", "GP5", "GP6", "GP7", "GP8"],
        "rows": ["GP9", "GP10", "GP11", "GP12"]
    },
    "split": {
        "enabled": true,
        "main": "right",
        "soft_serial_pin": "GP1",
        "transport": { "protocol": "serial" },
        "matrix_pins": {
            "right": {
                "cols": ["GP8", "GP7", "GP6", "GP5", "GP4"],
                "rows": ["GP9", "GP10", "GP11", "GP12"]
            }
        }
    },
    "url": "...",
    "usb": {
        "device_version": "1.0.0",
        "pid": "0x0254",
        "vid": "0xFEED"
    },
    "layouts": {
        "LAYOUT_split_3x5_3": {
            "layout": [
                {"matrix": [0, 0], "x": 0, "y": 0.25},
                {"matrix": [0, 1], "x": 1, "y": 0.125},
                {"matrix": [0, 2], "x": 2, "y": 0},
                {"matrix": [0, 3], "x": 3, "y": 0.125},
                {"matrix": [0, 4], "x": 4, "y": 0.25},
                {"matrix": [4, 0], "x": 7, "y": 0.25},
                {"matrix": [4, 1], "x": 8, "y": 0.125},
                {"matrix": [4, 2], "x": 9, "y": 0},
                {"matrix": [4, 3], "x": 10, "y": 0.125},
                {"matrix": [4, 4], "x": 11, "y": 0.25},
                {"matrix": [1, 0], "x": 0, "y": 1.25},
                {"matrix": [1, 1], "x": 1, "y": 1.125},
                {"matrix": [1, 2], "x": 2, "y": 1},
                {"matrix": [1, 3], "x": 3, "y": 1.125},
                {"matrix": [1, 4], "x": 4, "y": 1.25},
                {"matrix": [5, 0], "x": 7, "y": 1.25},
                {"matrix": [5, 1], "x": 8, "y": 1.125},
                {"matrix": [5, 2], "x": 9, "y": 1},
                {"matrix": [5, 3], "x": 10, "y": 1.125},
                {"matrix": [5, 4], "x": 11, "y": 1.25},
                {"matrix": [2, 0], "x": 0, "y": 2.25},
                {"matrix": [2, 1], "x": 1, "y": 2.125},
                {"matrix": [2, 2], "x": 2, "y": 2},
                {"matrix": [2, 3], "x": 3, "y": 2.125},
                {"matrix": [2, 4], "x": 4, "y": 2.25},
                {"matrix": [6, 0], "x": 7, "y": 2.25},
                {"matrix": [6, 1], "x": 8, "y": 2.125},
                {"matrix": [6, 2], "x": 9, "y": 2},
                {"matrix": [6, 3], "x": 10, "y": 2.125},
                {"matrix": [6, 4], "x": 11, "y": 2.25},
                {"matrix": [3, 2], "x": 2.5, "y": 3.25},
                {"matrix": [3, 3], "x": 3.5, "y": 3.5},
                {"matrix": [3, 4], "x": 4.5, "y": 3.75},
                {"matrix": [7, 0], "x": 6.5, "y": 3.75},
                {"matrix": [7, 1], "x": 7.5, "y": 3.5},
                {"matrix": [7, 2], "x": 8.5, "y": 3.25}
            ]
        }
    }
}
```
### Vial?

My previous keyboard came with [Vial](https://get.vial.today/), and it was immensely helpful to be able to play around with different key layouts and tweaks without having to compile and flash for every small change. Since I had my 36 key layout dialled in (or so I thought, more on that later), I thought that having a relatively stable layout in QMK would be sufficient.

And then I actually went through the process of compiling/flashing firmware, and I immediately wanted vial back!

The main reason was because the process to make changes on a split keyboard are:
1. Update configuration
2. Run command to compile firmware
3. Unplug USB cable from keyboard
4. Unplug TRS cable from both halves
5. With one half, turn upside down and press reset on the MCU to enter bootloader mode
6. Plug USB cable back in
7. Open file explorer, move firmware file to bootloader
8. Unplug USB cable to exit bootloader mode
9. Repeat step 5-8 for other half (may not be necessary depending on type of change)
10. Plug TRS cable back in to both halves
11. Plug USB cable back in to keyboard
12. Test updated configuration
13. Repeat from step 1 as needed

Compared to the process with vial:
1. Open vial.rocks in web browser
2. Update configuration
3. Test updated configuration
4. Repeat from step 2 as needed

Way easier and faster right? Especially when fiddling with timing or mouse key configurations, it’s just a much better development cycle since vial enables immediate changes.

### Yes, Vial

Anyway, setting up Vial was relatively straightforward. It involved creating a new config from the QMK one (following the porting guide [here](https://get.vial.today/docs/porting-to-via.html), and adding an extra config file that describes the visual representation of the keyboard. This config maps what you see in the UI to the keys in QMK.

It was mildly annoying since I initially forked the QMK repo, and Vial requires forking their repo instead, so I just had to copy files into the Vial repo to continue from there.

All files listed below are saved under `keymaps/vial`.

In `config.h`: 
```c
#pragma once

#define VIAL_KEYBOARD_UID {0x11, 0x6B, 0x9E, 0x21, 0xCB, 0x6C, 0xB7, 0x37}

#define VIAL_UNLOCK_COMBO_ROWS { 0, 2 }
#define VIAL_UNLOCK_COMBO_COLS { 0, 4 }
```

In `keymaps/vial/rules.mk`:
```
VIA_ENABLE = yes
VIAL_ENABLE = yes
```

And `vial.json`:
```json
{
    "name": "skeletyl",
    "vendorId": "0xFEED",
    "productId": "0x0254",
    "matrix": {
        "rows": 8,
        "cols": 5
    },
    "layouts": {
        "keymap": [
            [ "0,0", "0,1", "0,2", "0,3", "0,4", { "x": 2 }, "4,0", "4,1", "4,2", "4,3", "4,4" ],
            [ "1,0", "1,1", "1,2", "1,3", "1,4", { "x": 2 }, "5,0", "5,1", "5,2", "5,3", "5,4" ],
            [ "2,0", "2,1", "2,2", "2,3", "2,4", { "x": 2 }, "6,0", "6,1", "6,2", "6,3", "6,4" ],
            [ { "x": 2.5 }, "3,2", "3,3", "3,4", { "x": 1 }, "7,0", "7,1", "7,2" ]
        ]
    }
}
```

After flashing, my keyboard then showed up under [vial.rocks](https://vial.rocks)!

![Vial web user interface.](vial.png)
# Layout Tweaks
I thought that my 36 key layout would be fine, but it was not. Since the thumb cluster was wider, the farthest thumb no longer felt as comfortable or easy to hit, especially for combos like `CMD+T`. Then I went into bottom row mods, which helped.

Another thing I noticed was how my hands wanted to rest in home row, whereas in a flat keyboard, I found it to matter less where the resting position was since it could just move laterally to correct without issue.

# Final Thoughts

One interesting thing about sculpted keyboards is that if the rubber feet are a bit dusty, the keyboard would have a tendency to shift while typing. This is not an issue with flat keyboards since the direction of force is vertically down, whereas here, the force vectors are also horizontal. This can be mitigated by making sure the rubber feet are clean and have good grip, or adding small weights to the case (e.g. with motorcycle wheel balancing weights).

Hitting the inner column keys with the forefinger is also a little awkward since it feels like there's more distance for the finger to travel while avoiding hitting the tallest thumb cluster key. But the ring and pinky fingers feel very comfortable!

The thumb clusters could also be a little lower and close together, since the outer key is hard to reach for my (somewhat) smaller hands.
