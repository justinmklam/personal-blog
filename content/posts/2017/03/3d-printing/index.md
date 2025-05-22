+++
date = "2017-03-23T19:38:27-07:00"
draft = false
image = "mp select mini user group.jpg"
layout = "single"
title = "Resources for 3D Printing with the MP Select Mini"
tagline = "A collection of information to reduce the initial headaches with 3D printing."
type = "blog"
tags = ["3d printing"]
+++

What's better than an inexpensive 3D printer? Free sources of information! The items below are a resource list for 3D printing with the Monoprice Select Mini, all thanks to a lively community of users around the interwebz.

# General Info
* Product Page:
    * [Monoprice Select Mini V1](https://www.monoprice.com/product?p_id=15365)
* Official User Manual:
    * [MP Select Mini User Manual](15365_Manual_170509.pdf)
* Reddit:
    * [/r/MPSelectMiniOwners](https://www.reddit.com/r/MPSelectMiniOwners/)
* Facebook Group:
    * [MP Mini User Group](https://www.facebook.com/groups/1717306548519045/)
* Unofficial Wiki:
    * [MP Select Mini Wiki](http://mpselectmini.com/start)
* Community Knowledge Base:
    * [Google Doc](https://docs.google.com/document/d/1HJaLIcUD4oiIUYu6In7Bxf7WxAOiT3n48RvOe5pvSHk/edit)

# Materials and Accessories
* Tested PLA Brands:
    * [Hatchbox](https://www.amazon.ca/s/ref=bl_dp_s_web_3006902011?ie=UTF8&node=3006902011&field-brandtextbin=HATCHBOX)
    * [AMZ3D](https://www.amazon.ca/s/ref=bl_dp_s_web_667823011?ie=UTF8&node=667823011&field-brandtextbin=AMZ3D)
* Alternative Bed Surface:
    * [PEI Sheet](https://www.amazon.ca/gp/product/B0013HKZTA/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1), see RepRap Wiki for [details](http://reprap.org/wiki/PEI_build_surface)

# Initial Set Up
* CAD Modeling Software (free for hobbyists and enthusiasts):
    * [Autodesk Fusion 360](https://www.autodesk.com/products/fusion-360/overview)
* Slicing Software:
    * [Ultimaker Cura](https://ultimaker.com/en/products/cura-software)
* Onboard WiFi for wireless printing:
    * [Connecting to WiFi through G-code](http://mpselectmini.com/wifi/g-code_file)
* Using Raspberry Pi and Octoprint for wireless printing:
    * [OctoPi](http://octoprint.org/download/)

# Machine Settings

## General

The machine settings below are based off the ones in the official user manual. However, the start and end gcode was taken from the community-driven Google Doc (see above) and slightly modified to include an initial nozzle wipe/primer and to remove the delay in turning the fans off.

![Machine settings for MP Select Mini.](machine-settings.PNG)

For the lazy, you can simply copy and paste the code boxes below (ignore the End Gcode in the image above).

```ini
;; Start Gcode
G28 ;Home
G1 Z0.2 F1200 ; raise nozzle
G92 E0 ; reset extrusion distance
G1 X10
G1 Y100 E12 F600 ; purge nozzle & wipe
G92 E0 ; reset extrusion distance
```

```ini
;; End Gcode
M104 S0 ; turn off hotend heater
M140 S0 ; turn off bed heater
G91 ; Switch to use Relative Coordinates
G1 E-2 F300 ; retract the filament a bit before lifting the nozzle to release some of the pressure
G1 Z1 ; raise Z 1mm from current position
G1 E-2 F300 ; retract filament even more
G90 ; Switch back to using Absolute Coordinates
G1 X20 ; move X axis close to tower but hopefully far enough to keep the fan from rattling
G1 Y115 ; move bed forward for easier part removal
M84 ; disable motors
G4 S600 ; keep fan running for 600 seconds to cool hotend and allow the fan to be turned off
M107 ; turn off fan
```

## OctoPrint

To connect OctoPrint through Cura, go to "Settings > Printer > Manage Printers", select your printer from the list, then click the "Connect OctoPrint" button on the right side of the menu.

![Setting up OctoPrint through Cura.](octopi settings.png)

This way, you can send gcode files directly from Cura to Octoprint with a click of a button!

# Print Settings

 When fiddling with layer heights, it's recommended to use the optimal values below:

* 0.04375 (results may vary)*
* 0.0875
* 0.13125
* 0.175
* 0.21875
* 0.2625
* 0.30625

Numbers courtesy of Michael O'Brien on [Hackaday](https://hackaday.io/project/12696-monoprice-select-mini-electro-mechanical-upgrades). Explanation:

> So that motor [Z-Axis] is a 7.5°, 48 step motor as I just listed. Since the motor is attached to a M4 rod, which has a 0.7 mm thread pitch, then in one revolution makes the Z-Axis travel up or down 0.7 mm. Since it took 48 steps to turn that rev, each step is 0.0014583... mm. To avoid rounding errors, you can use multiple of 3 of this number, which is a nice and pretty 0.04375 mm. That is a nice and handy number that effectively represents the layer heights that mathematically work the best for layer heights for this printer.

The settings below should serve as a decent starting point in dialing in your own print settings for PLA.

![PLA material settings.](pla-settings.png)

# Design Guidelines
Want parts to fit together? 0.25mm is usually works well.
![For mating parts, a general guideline of 0.25mm is sufficient.](tolerance.png)

# Troubleshooting
## Hole Features on First Layer Not Adhering
Make the following setting modifications, in descending order of preference (I try to avoid using rafts to reduce print time and material waste).

+ Slow down print speed to ~10mm/s
+ Increase build plate temperature and/or use external adhesion methods (ie. glue/hairspray)
+ Increase initial layer height such that more material sticks to the bed
+ Disable fans for initial layer
+ Use raft

## Stringy Parts
+ Fiddle with retraction distance and speed (start with 4.5mm and 40mm/s)

_Last edited: February 10, 2018_
