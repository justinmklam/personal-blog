+++
date = "2018-01-12T09:42:57-08:00"
draft = false
image = "verilux-comparison.PNG"
layout = "single"
tagline = "Shining the light of truth on a $70 bulb."
tags = ["physics"]
title = "Measuring the Spectral Characteristics of a Light Therapy Lamp"
type = "blog"

+++

**Disclaimer:** _Light therapy is one method of easing seasonal affective disorder (SAD); some people swear by it whereas others remain unaffected. This blog post does not intend to refute the effectiveness of light therapy, but rather to dig deeper into the technology behind these light therapy lamps to better educate fellow consumers._

Ah, the winter blues of Vancouver, BC. While some days bring bluebird skies and [fresh pow](https://media1.tenor.com/images/25e5bfdf6e824bfa330964b5e0e48855/tenor.gif?itemid=5287297) for skiing, other days are downright gloomy. Spending this past Christmas in Singapore meant warm, sunny, and +25°C weather, which is quite atypical of how most Canadians spend their winters.

However, coming back to the overcast, bone-chilling, gray, and wet Vancouver winter was a climate shock my body had yet to feel before. A week or so of jetlag-ridden sleep cycles and my circadian rhythm was back to normal, but I couldn't scratch the itch of yearning for sun and truly despising this city's gloomy winter weather.

Thanks to Amazon Prime's same/one day shipping, a solution to this problem was less than 24 hours away. Introducing my new light therapy lamp!

<!-- ![Verilux's compact light therapy lamp and its advertised benefits.](lamp benefits.png) -->

![Verilux HappyLight Compact Light Therapy Lamp with the UV filter/diffuser installed.](IMG_20180104_192702.jpg)

![Ultraviolet difuser/filter removed from the lamp. Wait a minute, is that just a CFL bulb?](IMG_20180103_193302.jpg)

# The Suspicions

But wait just one moment; upon unboxing the lamp, I noticed something familiar. The light source behind the box looked strangely similar to a standard CFL bulb... Had I just been duped into spending $70 for a plain old light bulb in a fancy plastic enclosure?

![Left: $14.99 Verilux Full Spectrum Bulb. Right: $1.50 Standard CFL bulb.](bulb comparison.png)

Fortunately for me, I work at [MistyWest](https://mistywest.com/) and we have a fancy spectrometer that will allow me to confirm/deny my suspicions. It's used to measure the spectral power density at each wavelength of light (or in layman terms, it measures the intensity of each specific colour of light). The two main questions I was curious to answer:

1. Are the spectral characteristics of this bulb any different than a regular CFL bulb?
2. Is the filter/diffuser actually made of a special UV-blocking material?

But before we get into the details of spectral characteristics, let's shed _a bit of light_ on the different lighting methods and how they came to be. (Stay with me; it's worth it.)

# The Research

## Illumination Nation

### Overview of Light Sources
Different sources of light can have significantly different spectral characteristics. The figure below shows how six different light sources vary greatly at each wavelength.

{{<img caption="Typical spectral characteristics and corresponding colours of various lighting." src="spectral_responses2.png" link="http://housecraft.ca/eco-friendly-lighting-colour-rendering-index-and-colour-temperature/" link-text="HouseCraft" >}}

+ **Daylight**
    + Rounded peak around 450 nm
    + Broad spectrum light intensity
    + 5000 - 6500K
+ **Incandenscent**
    + Increases from 400 nm to 700 - 800 nm
    + Burning of tungsten filament inside a vacuum bulb produces a very warm glow (in addition to a great amount of heat!)
    + 2400 K
+ **Fluorescent**
    + Distinct peaks around 420 nm, 490 nm, 550 nm, and 610 nm
    + Peaks are due to the fluorescence of excited phosphor within the glass tube
    + 2700 - 6500 K

{{<img caption="Electricity ionizes the mercury and argon gas, producing UV light which hits the phosphor coating and finally fluoresces white." src="image-cfl.png" link="https://www.naturalblaze.com/wp-content/uploads/2017/10/image-cfl.png" link-text="Natural Blaze" >}}

+ **Halogen**
    + Rounded peak around 600 nm
    + Also burns a tungsten filament, but the gas is at a higher pressure for brighter illumination (basically a more advanced incandescent bulb)
    + 2800 - 3400K
+ **Cool White LED**
    + Sharp peak around 450 nm, rounded peak around 550 nm
    + Gallium nitride on a sapphire substrate produces blue (first peak), and a phosphor coating produces yellow light through fluorescence (second peak)
    + 3500 - 4100 K
+ **Warm White LED**
    + Shallow peak around 450nm, large peak around 550 nm
    + Combining different phosphors change the fluorescent characteristics of the emitted light
    + 2700 K

<!-- ![. [Source: Serendip Bryn Mawr]](incandescentbulb.jpg) -->

{{<img caption="When an electron flows from anode to cathode across the band gap, it falls into a lower energy level and releases energy in the form of a photon (light)." src="LED-explanation0.jpg" link="http://www.lumenelectronicjewelry.com/2014/04/how-does-an-led-work-anyway/" link-text="Lumen Electronic Jewelry" >}}

### A Walk Down Memory Lane

Now, slapping some dates to the evolution of lighting technologies (thanks [Wikipedia](https://en.wikipedia.org/wiki/Timeline_of_lighting_technology#20th_century)) gives us a pretty good understanding of how this all played out:

+ *1904* - Alexander Just and Franjo Hanaman invent the tungsten filament for **incandescent** lightbulbs.
+ *1926* - Edmund Germer patents the modern **fluorescent** lamp.
+ *1927* - Oleg Losev creates the first **LED** (light-emitting diode).
+ *1953* - Elmer Fridrich invents the **halogen** light bulb.
+ *1962* - Nick Holonyak Jr. develops the first practical visible-spectrum (**red**) light-emitting diode.
+ *1981* - Philips sells their first **Compact Fluorescent** Energy Saving Lamps, with integrated conventional ballast.
+ *1995* - Shuji Nakamura at Nichia labs invents the first practical **blue** and with additional phosphor, white LED, starting an LED boom.

Through this brief overview of light sources, we can see how the different illumination methods developed from sending current through a tiny strand of wire making it glow bright, to using fluorescence as an energy efficient way to produce light (and also at different colour temperatures).

### So What?
The takeaway through this stroll through history lane is this: even before taking the spectral measurement of this bulb, we already know that the likelihood of this light therapy bulb being different is quite low. The History of Light(TM) paints a clear path of what's both economically and physically possible in creating a light source, so this mystical light therapy bulb is almost certainly just your everyday compact fluorescent bulb (with a GU10 base).

{{<img caption="Let's mix and match different bases and shapes and label it as a proprietary bulb! The marketing team will love it." src="bulb types.jpg" link="http://www.tomic-arms.com/track-lighting-bulb-types/good-track-lighting-bulb-types-77-on-track-lighting-with-ceiling-fan-with-track-lighting-bulb-types/" link-text="Tomic Arms" >}}

But since we're already here, let's measure the data anyway! It's not everyday we get to learn about the physics we're surrounded by, especially when it involves expensive ~~toys~~ instruments.

## Let's Get To It: Playing with the Spectrometer

With our [Ocean Optics visible light spectrometer](https://oceanoptics.com/product/sts-vis-rad/) placed about 10 cm in front of the light therapy lamp and set with a 10 ms integration time, we can capture the spectral characteristics of the bulb. To recap, the two things we're interested in are the following:

1. Are the spectral characteristics of this bulb any different than a regular CFL bulb?
2. Is the filter/diffuser actually made of a special UV-blocking material?

### To CFL or To Not CFL? That is the Question

Looking at the figure below, the trace in blue is the response with the frosted plastic in front of the bulb (ie. the lamp fully assembled). Surprise, surprise: the distinct peaks suggest that it is in fact a compact fluorescent bulb.

![Spectral responses with and without the UV diffuser/filter.](Verilux-Comparison.png)

However, a typical fluorescent bulb has sharp peaks and a flat baseline. What's up with the rounded peak around 450 nm?

{{<img caption="Standard fluorescent tube." src="spectral_responses_fluorescent.png" link="http://housecraft.ca/eco-friendly-lighting-colour-rendering-index-and-colour-temperature/" link-text="HouseCraft">}}

Digging a bit deeper, it appears that the additional peak is due to the different colour temperature. Based on the spectral data collected by [Advanced Aquarist](http://www.advancedaquarist.com/2010/8/aafeature) shown below, the rounded peak is likely from an additional/different phosphor inside the tube. This creates additional fluorescence to shift the visible colour temperature towards a more daylight-esque tone (by adding more blue content). On the other hand, the soft white bulb shows a flat spectral base, as expected from our previous graphs.

{{<img caption="Spectral response of a daylight CFL bulb, 6500K (left) and soft white, 2700K (right)." src="cfl_comparison.jpg" link="http://www.advancedaquarist.com/2010/8/aafeature" link-text="Advanced Aquarist" >}}

**The takeaway:** CFL bulbs have similar spectral characteristics to daylight in terms of how our eyes interpret it. This particular light therapy lamp uses a standard 6500K CFL bulb, so you're kind of paying for the marketing hype.

### True or Alternative Fact: UV Blocking Filter

So now that we have our first question answered, let's get on with the second. The frosted filter/diffuser that comes with this lamp is advertised to ensure it is a UV-free light source. Is this an actual optical filter that transmits light beyond the UV wavelengths (> 400 nm), or does it just a piece of plastic?

Let's look closely at the spectral characteristics. Zooming in to the 350 - 400 nm region and changing the y-axis to a log scale (to better visualize the data), we see that the peak around 365 nm is indeed attenuated by a factor of ~10. However, looking back at the original figure (above), we see that the entire spectral response is attenuated.

![Detailed look at the UV exposure on a logarithmic scale.](Verilux Comparison - UV.png)

To put a number to this, we can numerically integrate the spectral power density at each wavelength and sum up the values to calculate irradiance (in units mW/cm<sup>2</sup>). Over the entire measured spectrum of 350 - 800 nm, we see that the diffuser reduces the total brightness by ~48%. So instead of removing just the UV wavelengths, they diffused the entire spectrum until the UV exposure is low enough to meet the "no UV exposure" threshold.

![Comparison of total irradiance with and without the diffuser.](chart.png)

Integrating the UV region between 350 - 400 nm shows that there's still a bit of UV light that gets through. However, it's of insignificant amount compared to the UV exposure from other sources (ie. sun, TV, computer screen, etc.) that they can say that there's "effectively no UV radiation" from this lamp.

![Comparison of irradiance in the UV range, with and without the diffuser.](chart-(1).png)

**The takeaway:** UV is removed by attenuating the entire spectral response of the CFL bulb until the UV light is removed (for practical purposes). Yes, the frosted diffuser also makes the lamp more user friendly (as staring into a bare bulb is rather jarring), but now you know that you can simply replace it with another diffuse material should you ever lose that part.

# The Light at the End of the Tunnel

I hope this journey through light and its spectral characteristics was both entertaining and educational. With any luck, you may have learned a thing or two (and gained an appreciation) about all the different light sources surrounding you everyday.

Although you can build your own light therapy lamp for a fraction of its retail purchasing cost, that may not be a viable (or convenient) option for everyone. Additionally, light therapy is apparently more dependent on the brightness output rather than the actual wavelengths; as long as it's bright and white(-ish) then it should work for light therapy!

Whatever you choose to do with this information is up to you, so light up your own path to mitigating your SAD-ness :)

<br>

***Acknowledgements:*** *Thanks to [MistyWest](https://mistywest.com/) for letting me use their spectrometer to measure this data!*
