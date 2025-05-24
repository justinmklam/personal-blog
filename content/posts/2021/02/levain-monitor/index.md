+++
aliases = []
date = 2021-02-22T16:36:18Z
image = "levain-monitor-combined.png"
layout = "single"
tagline = "Taking the guess work out of baking with wild yeast."
tags = ["3d-printing", "design", "electrical", "programming", "embedded"]
title = "Precision Sourdough: A Smart Lid for Your Starter"
type = "project"
math = true

+++
A few years ago, I had the idea to [track my sourdough starter using computer vision]({{< ref "/posts/2018/06/sourdough-starter-monitor" >}}). It was neat to monitor it this way, but it was fairly impractical to do for each feeding since it required setting up a camera, downloading the images, and doing some manual image cropping before running it through my analysis script. The analysis was also only done after the fact, and what I really wanted was something that could tell me when the starter was ready to be used (or fed), or, if I missed the window of opportunity, how long ago it peaked.

Last year, I came across [this Reddit thread](https://www.reddit.com/r/Sourdough/comments/duhqmd/i_built_a_device_that_tracks_the_development_of/) and [Christine Sunu's sourd.io project](https://www.twilio.com/blog/sourd-io-is-a-fitness-tracker-for-your-sourdough-starter), where they both had distance sensors inside the lid to measure the height of the starter. I thought it was genius, and had to make one for myself! However, in addition to the live monitoring, I wanted to log the data for further analysis, so I also decided to make it internet-connected as a way to get the data off the device (since saving to an SD card would add hardware costs, as well as being less "sexy" in today's world of everything having wifi connectivity).

Interested in making your own? All the design files and code can be found on [GitHub](https://github.com/justinmklam/iot-sourdough-starter-monitor)!

![Three modes of operation: Max rise and time, graph, stats for nerds.](jar.gif)
![Selecting, viewing, and downloading data for a given feeding session.](webapp.gif)

_Aside: In honesty, this project took longer than I originally expected, and I had spouts of project fatigue where I had zero motivation to work on this anymore. Eventually, a third (or maybe fourth, I lost count) wave of inspiration came to me, and I managed to finish the last remaining bits of this project. I'm glad I did though, because this turned out to be one of the more nifty gadgets I put together. I'm telling you this because people are often talking about side projects and hustles (especially software engineers), and I want to say that it's ok to focus on your mental well-being and_ [_just be a potato sometimes_](https://www.youtube.com/watch?v=9-XkF1so5rI)_._

# The Development

If you're only interested in the resulting data that came out of this, you can skip to [the end](#the-analysis) where I visualize the growth, temperature, and humidity from a few weeks of worth of feedings. Otherwise, read on to learn about the development of this high specialized, mildly esoteric kitchen gadget!

## Hardware

### Electronics

With the idea in mind, I bought the components off Digikey and AliExpress and hooked them up on a breadboard. The parts I used for this project:

* NodeMCU ESP8266
* VL6180X Time of flight distance sensor
* DHT22 Temperature and humidity sensor
* SSD1306 128x32 OLED display

I wrote some code to test that all components worked correctly, then went on to design a PCB to make it easier to integrate into the form factor of a jar lid.

![Breadboard prototype with off-the-shelf modules.](IMG_1513.jpg)

I've made PCBs using protoboards before (in my [sous vide controller]({{< ref "/posts/2017/05/sous-vide-controller#the-controller" >}})), but it was extremely time consuming. Since I surpassed the learning curve of designing boards in KiCad, now I'd rather wait a few weeks for the boards to show up from overseas, especially since it's so cheap ($2 for 5 boards, plus $14 shipping).

![PCB layout and schematic.](kicad.png)
![Top of the PCB with the display (left), bottom with the distance and temperature/humidity sensors (right).](pcb.png)

At this point, I was eager to try it out, so I cut a hole in a plastic yogurt lid and taped the assembled PCB on.

![It ain't pretty, but it works.](IMG_1618.jpg)

It worked well enough to test out the initial workflow, and I realized that I needed few crucial things to make the measurements actually useful:

* The height of the jar
* The starting height of the starter
* The height the starter has grown

With a bit of algebra and math, these values were now measured by the distance sensor, mounted at the bottom of the lid.

![Algebra? More like alge-bread!](diagram.jpeg)

Some definitions:

$$ d_1 = distance \\ to \\ jar $$
$$ d_2 = distance \\ to \\ starting \\ height $$
$$ d_3 = distance \\ to \\ current \\ height $$

$$ h_1 = starting \\ height $$
$$ h_2 = current \\ height $$

And the governing equations:

$$ h_1 = d_1 - d_2 $$
$$ h_2 = d_2 - d_3 $$
$$ h_{rise percent} = h_2 / h_1 = (d_2 - d_3) / (d_1 - d_2) $$

Resulting in our formula for calculating the rise percentage of the starter!

### Enclosure

I designed the enclosure in Fusion 360 and printed it on my [Monoprice Mini 3D Printer]({{< ref "/posts/2017/03/mp-select-mini" >}}).

![3D printed enclosure, designed in Fusion 360.](fusion 360.png)

I wasn't the proudest of this design, since I had to resort to using hot glue to attach the PCB to the enclosure, mainly because I forgot to leave enough hole clearance on the PCB . Ideally, the PCB would drop into the top half and assemble from the back (instead of the bottom half, as designed), but unfortunately I didn't have this forethought. I was designing the PCB to have a minimal footprint to keep costs low, instead of making it easy to integrate with!

Since I didn't want to solder the modules directly on to the PCB, I used female headers to keep them removable. However, this gave the assembly quite a bit of height, which resulted in the button needing some type of extension. I didn't want to make another Digikey order specifically for this button, so I decided to be resourceful and glued a machine screw to the button to make up for the missing height.

![Yes, that's a machine screw hot glued on to a switch...](IMG_4185.jpg)

Anyway, it assembled together without issues, and the only mistake you can see from the outside is the screw head (or let's just say I wanted to go for an intentional steampunk look)!

![An active, healthy starter being carefully monitored.](jar2.jpg)

## Firmware

I wanted to use a task-based architecture, since having everything in a single state machine can become convoluted and difficult to debug. With multitasking, the processor is only executing a single task at any given time, but it switches between each task rapidly to give the illusion of concurrency. I've used FreeRTOS in other projects, but wanted something more lightweight since I didn't need all the bells and whistles that it provides.

{{<img caption="Multitasking vs concurrency" link="https://www.freertos.org/implementation/a00004.html" link-text="FreeRTOS" src="TaskExecution.gif" >}}

I eventually came across [TaskScheduler](https://github.com/arkhipenko/TaskScheduler), a cooperative multitasking framework, which checked all the boxes I needed.

{{<img caption="A lightweight implementation of cooperative multitasking by TaskScheduler." link="https://github.com/arkhipenko/TaskScheduler" link-text="GitHub" src="TaskScheduler_html.png" >}}

The code was divided up into the following tasks/files:

* **measurements.cpp** - Read the sensors and make the measurements available for other tasks
* **userinput.cpp** - Handle the button presses from user input (short press, long press, double click)
* **display.cpp** - Display information to the user
* **iot.cpp** - Send the measured data to the cloud

The benefit of this architecture is that each file is less than 200 lines of code, and the clear separation of concerns made it easy to develop and debug.

![The display shows how much it peaked, and how much time elapsed since it peaked.](jar1.jpg)

With the architecture in place, the firmware itself was fairly straightforward. The only "fancy" thing I needed to do was save the jar height to EEPROM so that it would be saved between sessions, even if it's powered off. Interestingly, the ESP8266 doesn't actually have genuine EEPROM memory, so it's [emulated by using a section of flash memory](https://www.arduino.cc/reference/en/libraries/esp_eeprom/).

## Cloud Connectivity

One of the more time consuming parts of this project was actually getting AWS set up on the ESP8266. I encountered many library compatibility issues, which I should have expected since this chip was released 6 years ago (at the time of development)! If I didn't have an ESP8266 in my box of parts that I wanted to use, I would have used the newer ESP32, which (hopefully) would have presented fewer issues.

If you're looking to do the same, let me save you some headache! You can check out the template I made on [GitHub](https://github.com/justinmklam/aws-iot-esp266-demo) to get set up.

Once I got it publishing messages over MQTT to AWS, I set up the cloud infrastructure to receive and save the data. The data flow was:

1. Device sends the data in a message over MQTT
2. On a message receive event, an [AWS Lambda](https://aws.amazon.com/lambda/) function is triggered to parse the data from the message and passes it to a [Kinesis Firehose](https://aws.amazon.com/kinesis/data-firehose/) delivery stream
3. Kinesis Firehose receives the data and saves it [Amazon S3](https://aws.amazon.com/s3/)

{{<img caption="AWS architecture for basic IoT applications." link="https://dzone.com/articles/design-practices-aws-iot-solutions-volansys" link-text="DZone" src="aws-iot.png" >}}

I initially was going to use [Amazon QuickSight](https://aws.amazon.com/quicksight/) to visualize the data, but there were limitations with the refresh rate that were a deal breaker for me. Instead, I bit the bullet and created a custom dashboard using [Flask](https://flask.palletsprojects.com/) and HTML/CSS/Javascript, which queries data from S3 using [Amazon Athena](https://aws.amazon.com/athena/). I was too lazy to figure out how to host the dashboard on AWS for free, so I opted to use [Heroku](https://www.heroku.com/) (as I've done previously for my [recipe converter web app](https://github.com/justinmklam/recipe-converter)).

With cloud connectivity and dashboard complete, the sourdough monitor was now ready to be used!

# The Analysis

The main purpose of the monitor was to help with my timing of when to use the starter. Since the data was being collected anyway, I figured I might as well do some analysis to see if there was anything significant.

## Overview

After using the monitor for a few weeks, I had enough data to play with. The two main things I was curious about were:

1. Whether the peak height changes over time (i.e. through repeated feedings)
2. If it still grew as much if the starter was kept in the fridge and hadn't been fed for a few days

Doing a quick kernel density plot to get a feel for the data, we see some clustering but no obvious trends.

![Kernel density plot to show the distribution and clustering of data. No clear correlations are present...](kde-plot.png)

The graph below shows the consistency of my feedings:

* 5 subsequent feedings, starting on Jan 21
* 3 subsequent feedings on Jan 30, Feb 3, and Feb 17
* 2 subsequent feedings on Feb 12

_Note: The horizontal axis is a bit off since some days had multiple feedings, the graph assumes each feeding is a separate day._

![Feeding schedule over the past few weeks.](max-rise-over-time.png)

The graph below shows no correlation between how long it took for the peak rise to occur. It also didn't seem to matter if the starter was kept in the fridge for a few days, which is great news (and maybe not news to those who know their starter well)!

![No statistical significance between the most relevant metrics.](regression.png)

## In Detail

Looking at the time series data, we see the progression of the rise height from the first to last feeding. Some observations:

* Peak rise height increased from \~100% to \~200% by the 6th subsequent feeding
* Slope of rise height was constant, even with the first feeding out of the fridge
* Peak rise height is achieved by \~5 hours, and sustains at this height for \~3-5 hours

_Note: I used a temperature controlled proofing box, which is why the temperature and humidity are constant throughout the majority of the fermentation. The temperature was set to 24°C for most days, but interestingly the recorded temperature was typically around 30°C. More testing is required to see which sensor is correct..._

<!-- ![TEXT](combined.png) -->

![Rise height, temperature, and humidity over time.](feeding.png)

![Pair plot of the time series. Not much to show, except that temperature and humidity are correlated (as expected).](pairplot.png)

The rest of the feeding data can be found in the combined figure below. There are a few interesting things that occurred, but further experimentation would be required to draw any conclusions:

* **Jan 30**: All feedings were relatively similar, even the first one after being in the fridge for 5 days
* **Feb 3-5**: The second feeding had a steeper slope; I think I adjusted the feeding ratio for this one from 1:2:2 to 1:3:3, but I can't quite remember (or perhaps my wife was the one who fed it this time?). Also interesting that the temperature for the third feeding was not as consistent. Perhaps the proofing box wasn't turned on?
* **Feb 12**: Second feeding peaked 100% more than the first feeding. I think the feeding ratio was changed. The first feeding's humidity was also really weird in this one.
* **Feb 17-18**: First feeding took longer to peak than the subsequent two, which contradicts my observations from Jan 30...

![Visualization of the rest of the feeding data, for those interested.](all-combined.png)

So basically, what the data is telling me is that there are many other variables at play, and I'll need to record a few other metrics in order for the measured data to be actionable, such as:

* Feed ratio
* Start and end temperature of the starter (using a probe thermometer)
* Optional: Water hardness

Other experiments that I'd like to nerd out on:

* Compare feed ratios and/or flour blends
* Compare growth performance with and without a temperature controlled environment (i.e. proofing box)
* Ideal location if you don't have a proofing box (i.e. Oven with light on? Microwave with warm water?)

# Conclusion

So after all this, the takeaway might actually be that timing the starter isn't all that important, since it stays active at its peak for at least a few hours. And if you maintain a somewhat regular feeding schedule and have a relatively stable environment, then you can probably get a good feel for how long it takes your starter to grow (or you can set up a timelapse with your smartphone camera to see how it's doing).

This was still a fun way to nerd out with baking, since engineers like metrics, and there's a lot to measure with sourdough bread. Although this gadget might seem superfluous to some, I enjoyed the precision and confidence it gave me in taking out the guesswork of how my starter is doing. There's two types of bakers in the world: those who go by feel, and those have a 0.01 g resolution kitchen scale. Guess which one I am 😏

![A darn nice crumb, if I do say so myself!](bread.jpg)

Hope you found this enlightening, and if you have any other ideas on what experiments to try out, leave a comment below! If you like my content, please consider [buying me a coffee](https://www.buymeacoffee.com/justinmklam)!

Happy baking!
