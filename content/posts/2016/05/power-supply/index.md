+++
layout =    "single"
type =      "project"

date = "2016-05-25T17:29:58-07:00"
draft =     false

title =     "Adjustable Portable Power Supply"
image =     "powersupply.jpg"
tags =      ["electrical"]
tagline = "Providing power to the people. Or in this case, hobby projects."

aliases =   ["projects/elec/power-supply/"]
+++

__Objective:__ Build a cheap, portable, variable DC power supply.

__Motivation:__ It was finally time to get my hands on a variable power supply for my electronics projects. Previous projects mainly involved Arduino, which was able to supply 5V and 3.3V with ease. However, the need for a supply with higher voltage, current, and flexibility eventually arose, resulting in the birth of this ghetto (but functional) power supply.

__Limitations:__

+ Only DC voltages available
+ Max current is a function of input power and desired voltage (I=P/V)
+ Current limiting feature is non-existent, so must be careful to not let the genie out of circuits

![Internals of the power supply.](IMG_20160525_143029.jpg)
