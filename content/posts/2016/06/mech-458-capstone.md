+++
layout =    "single"
type =      "blog"

date = "2016-06-02T12:57:32-07:00"
draft =     false

title = "MECH 458: Capstone 3D Optical Well Imager"
tagline = "Integrating computer vision with automated pipeline inspection."
image =     "/imgs/capstone/System-evaluation_2.png"
tags =      ["design", "school"]

aliases =   ["/projects/mech/mech-458-capstone/"]
+++

# Introduction

__Objective__: Develop an optical scanning system to be used for generating 3D models of well liners and casings with sub-millimeter accuracy.</p>

__How__: As a team of five mechatronic and mechanical engineering students, we designed and constructed an alpha prototype of the optical 3D well imager.</span></p>

# Project Details
##  Requirements and Specifications
### Optical

<ol>
 	<li>Device must have a tolerance on distance measurement of 1 mm</li>
 	<li>Device must have a camera circumferential resolution of 1.42°</li>
 	<li>Device must have a 3D scan circumferential resolution of 1.42°</li>
 	<li>Device must have an axial resolution of 1 mm</li>
</ol>

### Mechanical
<ol>
 	<li>Device must be submersible</li>
 	<li>Device must fit in a 3.5” ID pipe</li>
 	<li>Device must have a minimum operating velocity of 10 mm/s</li>
 	<li>Device must be operable using the existing test apparatus</li>
</ol>

## Design Overview

<p style="text-align: justify;">The final design of the prototype includes a camera module, laser module, and two conical mirrors. The basic functionality of the device is shown in the figure below. A red laser ring is generated by the laser module which is reflected by 90° on to the surface of the well casing. The camera’s vision is then reflected by 150° to capture the projected laser ring.</p>

{{<img caption="Simplified diagram of scanning functionality."
src="/imgs/capstone/System-overview.png" >}}

### Combine Modules

{{<img caption="Overview of the optical imaging device."
src="/imgs/capstone/Annotated-Combined-Modules_2-1.png" >}}

### Camera Module

{{<img caption="Diagram of the camera module."
src="/imgs/capstone/Camera-Module.png" >}}

### Laser Module

{{<img caption="Diagram of the laser module."
src="/imgs/capstone/Laser-Module.png" >}}

## System Evaluation

<p style="text-align: justify;">Our prototype was successful in recreating a 3D model of the pipe internals during unsubmerged operation, as shown through the figures below. However, we were unable to test the device in submerged conditions due to time constraints of the project.</p>

### Preliminary Testing and Calibration

{{<img caption="Setup of the calibration grid with a green laser ring (left); Captured image (right)"
src="/imgs/capstone/System-evaluation_5.png" >}}

### Device Integration

{{<img caption="Our device installed with the DarkVision lab equipment (left); Close up of the laser ring inside the well liner (right)." src="/imgs/capstone/System-evaluation_2.png" >}}

## Post-Processing and Analysis

<p style="text-align: justify;">Four different exposure times and traversing speeds were tested to determine which camera parameters would generate adequate images for post-processing and analysis. From our tests, we determined that the imaging parameters resulting in an effective frame rate of 0.13 fps at a forward jog speed of 7 mm/s showed the most promising image slices of the well liner. To increase the slice resolution of the scan, the frame rate was increased to 1.3 fps which yielded visually poorer images, but our processing algorithms were still able to generate a 3D model of the well liner. A hue saturation value filter was used to detect the outer edge of the raw image.</p>

{{<img caption="Captured laser ring by the camera through the conical mirror (left); Processed image (right)" src="/imgs/capstone/System-evaluation_3.png" >}}

{{<img caption="Generated 3D model from the image slices." src="/imgs/capstone/System-evaluation_4-1.jpg">}}