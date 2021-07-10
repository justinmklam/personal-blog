+++
date = "2016-11-15T23:02:43-07:00"
draft = false
image = "/imgs/blog-imgs/tired-of-cables/0-bQFzgpiEsQUziwJN.jpg"
layout = "single"
title = "Tired of Cables in VR? We Are Too."
tagline = "When VR gives you lemons, you make a lemonade-making robot."
type = "blog"
tags = ["work", "writing"]
+++

_Originally posted on [Medium](https://medium.com/mistywest/tired-of-cables-in-virtual-reality-we-are-too-efeab5606bf0) under [MistyWest](https://mistywest.com/)._

Virtual reality pushes the envelope of bleeding edge technology, allowing us to explore and experience worlds beyond our mortal imaginations. It gives us immersion in another dimension, providing an unprecedented medium for communication and story telling. If a picture is worth a thousand words, then virtual reality must be worth millions. Except there’s one thing keeping it grounded to reality: cables.

Since the first virtual reality headset that was hacked together in 2011, immersive head-mounted displays have progressed far and quickly. Oculus Rift, HTC Vive, and PSVR are some of the main contenders of virtual reality hardware, and between them lie stark differences in performance and usability. However, cables are the common denominator in these high performance virtual reality headsets. They are tethered to a host computer to provide the computationally intensive processing power required for high-fidelity content. Although mobile solutions are available such as Microsoft’s HoloLens, Samsung VR, Google Daydream, and even Google Cardboard, wired headsets will continue to be the vanguard of high performance virtual reality.

Or so we thought.

But before we begin, let’s backtrack to a mere two months ago. We found ourselves growing tired of worrying about tripping over cables while using the HTC Vive in room-scale experiences. This was (and still is) a common problem: our eyes tell us we have freedom of movement, but our hardware reminds us we don’t. Wouldn’t it be great if there was a way to break free from cables and improve the immersivity of virtual reality?

Humans are hackers at heart and always strive to make things better. As a team of curious and hungry engineers, our answer was yes.

We wanted a solution to increase and maintain presence in virtual reality; having to worry about tripping over the cable takes away from it. Some would argue that subconsciously stepping over the cable is a minor problem that one gets used to. However, despite its small inconvenience, it’s an inconvenience nonetheless which detracts from the otherwise immersive VR experience. Solutions do exist: at event demos, people hire cable sherpas to hold the wires behind the user and follow them around. Unfortunately, not everyone has access to their own personal sherpa.

We have the ability to be transported to completely different worlds, yet we are tethered by cables that have existed longer than we can remember. We shouldn’t stop innovation for VR at just the headset; the entire experience needs to be unique and immersive.

If this is such a common problem, what have people done to manage these notorious cables?

A handful of HTC Vive owners have mounted retractable identification badge fobs or dog leashes to the ceiling to create an overhead holding point of the cable. However, certain player movements will result in tension between the mounting point and the headset. We tried this ourselves, and we found the cable tugging more distracting than having to step over the cable.

{{<img caption="Free standing cable boom. [SteelSeries Tech Blog]" src="/imgs/blog-imgs/tired-of-cables/0-ybwUNzKuP1JnIQ6u.jpg" >}}
{{<img caption="Ceiling mounted dog leashes. [YouTube]" src="/imgs/blog-imgs/tired-of-cables/1-hyLaVWqAzYS2YvWKKrLy7g.png" >}}

What we needed was a way to mimic a cable sherpa, following our every movement to prevent tension in the cable and entanglement around our legs. Whether we were moving forward, backward, left, right, or turning around, we wanted a way to roam freely as if virtual reality was already wireless.

Cue the engineers.

Combining our expertise in rapid prototyping, software development, and the strong desire to make things better, we had ourselves a solution: the autonomous robotic gantry.

{{<img caption="Achievement unlocked: Freedom of movement with wired VR." src="/imgs/blog-imgs/tired-of-cables/1-L0-0M3ktUiBQcZHqOwzkyA.gif" >}}

The autonomous robotic gantry is an overhead cable management system which allows the user to roam freely within the play area. Using aluminum extrusions and laser cut acrylic parts as the base materials, we designed and constructed a lightweight, planar motion system driven by two stepper motors through a a CoreXY timing belt configuration. Minimizing the number of moving components and weight was the key in optimizing acceleration and speed. By using off the shelf components and laser cut parts, we were able to design, build, and assemble the gantry in a short two weeks. Thanks to OpenVR, we were able to use the positional data to control and automate the overhead gantry. No muss, no fuss, no more tripping over cables.

{{<img caption="Cable-free gameplay of Space Pirate Trainer." src="/imgs/blog-imgs/tired-of-cables/1-xU58k_ZTrzgGpbr4mWfN_w.gif" >}}

Over-engineered? Maybe. Overkill? We think not. This was an exercise not in cost-effectiveness for the average user, but to explore how we can integrate existing technology with bleeding edge products in order to improve its efficacy and functionality. As the world has become a community of hackers, we don’t have to rest on our laurels and wait for companies to come up with solutions to our problems. The resources are available to us to come up with these solutions ourselves.

{{<vid caption="Full demo video of the robotic gantry." src="https://www.youtube.com/embed/zULBxDJVaHs" >}}

Fast forward to present day. Just last week, HTC announced a kit for wireless virtual reality. That’s right: the devs behind the HTC Vive have already been working on a consumer ready solution to cables. We didn’t anticipated this wireless movement for another 5–10 years since latency and frame rate is still an issue with current wired headsets. However, despite the rapid research and development to unlock the potential of true freedom of movement, wireless performance will always be succeeded by wired headsets.

Is our robotic gantry dead on arrival? It was a fun, quick project to work on and we believe it still holds value. Potentially not as a product, but as an exercise to explore how we can use existing technology to improve upon new ones. In any event, we are excited to see the progression of wireless headsets and will continue to watch the rapid changes in industry that are happening before our very eyes.

Virtual reality is still a nascent industry with large room for growth, and solutions for wired, wireless, and mobile media will continue to fill the stage. As new products emerge, older ones may fall. Regardless of what happens in the realm of virtual reality, we don’t want to just sit back and watch it happen. As mentioned before, we are all hackers at heart and continually strive to make things better. Whether it be virtual reality in wired, wireless, or mobile form, we are all capable of taking part in the forward progression of technology and will constantly seek opportunities to improve its performance and usability.
