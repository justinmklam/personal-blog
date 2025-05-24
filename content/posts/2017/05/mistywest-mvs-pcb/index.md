+++
layout =    "single"
type =      "project"

date =      2017-05-09T11:30:56-07:00
draft =     false

title =     "Battery Power Protection and Regulation PCB"
image =     "IMG_20170524_162252.jpg"
tags =      ["electrical"]
tagline =   "Design of a power management board in Altium."

aliases =   ["/projects/elec/mistywest-mvs"]
+++

__Objective:__

+ Design a custom PCB to protect and regulate a 14.8V LiPo battery for use with an autonomous RC car

__Features:__

+ 12V undervoltage and 10A overcurrent protection
+ 8.4V, 7.4V, and 5V regulated outputs

__Main Components:__

+ [LT6109](https://www.digikey.ca/product-detail/en/linear-technology/LT6109AHMS-2-PBF/LT6109AHMS-2-PBF-ND/3844948) High Side Current Sense Amplifier
+ [RT8288AZSP](https://www.digikey.ca/product-detail/en/richtek-usa-inc/RT8288AZSP/1028-1148-1-ND/3078151) Synchronous Step-Down Converter

__Skills:__

+ Reading and understanding datasheets
+ Schematic capture and PCB layout in Altium Designer
+ Board bring-up
+ Hardware debugging

__Achievement Unlocked:__

+ A mechanical engineer doing electrical engineering

__Acknowledgements:__

This project was completed under [MistyWest](https://mistywest.com/) with the guidance of Dave MacLeod, Div Gill, and Ryan Walker.

![Completed PCB in all its glory, like a newly erected city skyline.](IMG_20170524_162252.jpg)
![Schematic capture of the designed circuit.](Altium schematic.jpg)
![PCB layout of top overlay (right) and bottom overlay (left).](Altium front-back.jpg)
![3D render of PCB in Altium Designer.](Altium capture.png)
![Boards ordered and received from OSH Park.](IMG_20170519_154141-2.jpg)
![Stencil cut out and prepped for applying the solder paste.](IMG_20170523_164839.jpg)
![Solder paste applied and components placed.](IMG_20170523_165130-2.jpg)
![PCB cooking in the reflow oven.](IMG_20170523_174939.jpg)
![After much debugging, the board finally works! Red LED indicates protection circuit is active; Green LED indicates each regulated output is active. Multimeter shown is connected to the 8.4V output.](IMG_20170525_123943.jpg)
