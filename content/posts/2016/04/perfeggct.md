+++
layout =    "single"
type =      "blog"

date = "2016-04-22T22:38:31-07:00"
draft =     false


title = "MECH 423: Mechatronics Product Design"
tagline = "Over-engineering the soft-boiled egg with the ultimate kitchen gadget, PerfEGGct™."
image =     "/imgs/perfeggct/IMG_0407.JPG"
tags =      ["design", "electrical", "school"]

aliases =   ["/projects/mecha/perfeggct/"]
+++

__Background:__ When a hard boiled egg is spun on a table, it rotates freely since the inside is completely solid. With a raw egg, the liquid yolk sloshes around and resists rotation. By using math and physics, we can analyze the rotational oscillation of an egg and determine the yolk consistency.

> "If it's worth doing, it's worth overdoing." - Jaime Hyneman

__Objective:__ Design and build a device to determine how cooked a boiled egg is using non-invasive techniques.

__Motivation:__ As part of our final year engineering course, we were tasked to create a mechatronics device of our choosing. This project was heavily inspired by [Matthias Wandel](https://www.youtube.com/channel/UCckETVOT59aYw80B36aP9vw) and his [boiled egg hardness tester](https://www.youtube.com/watch?v=Cw9w1CZkTr0).

__Functional Requirements:__

+ Measure egg mass from strain gauge
+ Measure oscillation from accelerometer
+ Control LCD screen
+ Mechanical design and fabrication
+ Integration and user interaction study
+ C# interface
+ MATLAB data analysis

__Limitations:__ This prototype was developed in 3 weeks during school and has approximately 80% repeatability.

__Partner:__ [Justin Liang](http://justin-liang.com)

{{< vid caption="Sixty second demo video of the device in action." src="https://www.youtube.com/embed/54d9iQcqX7Q" >}}

{{< img caption="CAD model of electronics inside the enclosure (transparency shown for clarity)"
src="/imgs/perfeggct/CAD_4.png" >}}

{{< img caption="PCB diagram."
src="/imgs/perfeggct/Fritzing%20diagram.jpg" >}}

{{< img caption="PCB assembled."
src="/imgs/perfeggct/DSC03408.JPG" >}}

{{< img caption="Dry fitting of components inside handle enclosure."
src="/imgs/perfeggct/DSC03430.JPG" >}}

{{< img caption="Annotated diagram of the final device."
src="/imgs/perfeggct/IMG_0461_annotated.jpg" >}}

{{< img caption="Example data from five egg-jiggling trials."
src="/imgs/perfeggct/Raw signals.png" >}}

{{< img caption="The PerfEggct stored in its natural habitat."
src="/imgs/perfeggct/storage_1.png" >}}

{{< img caption="Kitchen gadgets aren't complete without a fancy photoshoot!"
src="/imgs/perfeggct/IMG_0407.JPG" >}}

{{< img caption="Truly perf-egg-ct."
src="/imgs/perfeggct/IMG_0424.JPG" >}}

Interested in reading more about this project? Head over to [Instructables](http://www.instructables.com/id/PerfEGGct-Engineering-the-Perfect-Soft-Boiled-Egg/) for more details! And if you're *really* interested, feel free to read our glorious 35-page final report [here](/files/MECH 423 Final Project Report.pdf).
