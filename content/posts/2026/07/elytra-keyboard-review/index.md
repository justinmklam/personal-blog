---
title: Elytra Keyboard Review
date: 2026-07-11T10:09:33-07:00
tagline: A premium split keyboard for the masses?
image: DSCF3323.jpg
image_source:
image_source_text:
tags:
  - keyboards
  - review
draft: true
updated:
layout: single
type: blog
aliases:
---

> Disclaimer: ElmKeys sent this keyboard to me for review free of charge.
As always, all opinions are my own.

The ElmKeys Elytra is a split ergonomic keyboard for people who want the
ergonomic benefits of a split layout without completely retraining years
of muscle memory. Unlike many enthusiast ergonomic boards that adopt
aggressive column-staggered layouts, the Elytra keeps a familiar
row-staggered layout, making the transition much less intimidating.

After using it as my daily keyboard for a few weeks, that's exactly
where I think it succeeds. It's exceptionally well built, comfortable to
type on, quiet enough for an office, and portable enough to throw into a
backpack. It isn't cheap, but it's clearly designed as a premium
productivity tool rather than another keyboard built around chasing the
deepest "thock."

## Design and build

The aluminum case feels incredibly solid. There's essentially no case
flex, and the machining is excellent throughout. The included keycaps
have crisp legends, softly radiused edges, and a comfortable profile
that stayed pleasant even during longer typing sessions.

![](DSCF3310.jpg)

One of my favourite design details is the magnetic bridge joining the two
halves. Three hidden magnets snap the keyboard together with surprising
force, making it feel like a single unit when transporting it while also
ensuring the two halves always return to the same position on your desk.

I initially thought the center bridge looked a little larger than
necessary, but the extra space accommodates the status LEDs, and a small
gap between the halves is more comfortable ergonomically anyway.

![Discrete status LEDs at the bottom.](DSCF3334.jpg)

![Top side of the keyboard.](DSCF3339.jpg)

The included wooden wrist rests are also well made. The keyboard is
already quite low profile, so not everyone will need them, but I
appreciated the extra support during longer work sessions.

![Solid, natural wooden wrist rests.](DSCF3348.jpg)

A tenting kit is available as an option. I generally prefer typing flat
so I didn't test it, but I like that the wrist rests tilt together with
the keyboard.

## Typing experience

My review unit came with the 40 gf CloudShell White linear switches.
They're fully POM, extremely light, and nearly silent without feeling
mushy. I ended up preferring them over Kailh's 35 gf Ambient Silent
Twilight Choc V1 switches, especially for office use.

Combined with the comfortable keycaps, typing on the Elytra is simply
enjoyable. This isn't a keyboard built to maximize sound; it's built to
disappear into your workflow.

![Close up of the keycap profiles.](DSCF3550.jpg)

Wireless latency was also a complete non-issue. I even played a few
rounds of Clone Hero on it without noticing any problems.

## Layout and everyday use

The familiar row-staggered layout is the keyboard's biggest selling
point. You get most of the ergonomic benefit of a split keyboard without
committing to relearning a completely different layout.

There are still a few adjustments. The arrow cluster is a little
unconventional, there's no dedicated Page Up or Page Down, and I found
myself using the left spacebar as my layer key instead of my usual Caps
Lock remap. Fortunately, dual spacebars make this feel very natural.

The only real compromise is connectivity. The right half always
communicates wirelessly rather than supporting a fully wired mode. In
practice this wasn't much of an issue since it's the peripheral side of
the keyboard, and battery life is measured in months rather than weeks.

The carrying case is another highlight. Everything fits snugly, making
it easy to toss into a backpack for travel.

![Elytra in its carrying case.](DSCF3366.jpg)

![Carrying case all zipped up.](DSCF3372.jpg)

![Included accessories.](DSCF3375.jpg)

## Internals

Disassembly was a little more involved than I expected, largely because
of the short battery cable. It isn't difficult, but it requires more
care than many other keyboards I've opened.

One small tip if you ever take yours apart: if the power switch falls
out during reassembly, pay close attention to its orientation. It has a
tiny stepped feature that only fits one way. I discovered this the hard
way after wondering why the switch suddenly felt jammed.

![Keycaps removed.](DSCF3480.jpg)

![Top half of the case removed.](DSCF3484.jpg)

![Close up of the magnets.](DSCF3491.jpg)

![Using tweezers to remove the battery cable.](DSCF3522.jpg)

![Battery removed, the cable is much too short!](DSCF3508.jpg)

![Left half fully disassembled.](DSCF3509.jpg)

![Underside of the PCB.](DSCF3513.jpg)

Microcontroller appears to be a [Minewsemi MS51SF1](https://store.minewsemi.com/product/bluetooth-modules-nrf52833-ms51sf1/) Bluetooth LE module, which is the first I've come across one. Very tiny! Seems like it was just released in Shenzhen in 2024, so fairly new. Based on the nRF52833 SoC and a 32-bit ARM CortexTM M4F CPU, 512kB Flash, and 128kB RAM, making it more than capable of running all the features needed for keyboard firmware. 

![](DSCF3516.jpg)

One note for reassembling: if the power switch falls out of the case like it did for me, be aware of its orientation! It has a very small stepped feature which only fits in one way, otherwise it'll feel like a tight fit and the switch will feel stuck after the case is all closed up (spoken from experience). 

![](DSCF3547.jpg)
# Firmware
One of the more interesting aspects of the Elytra is its firmware. Rather than using QMK or ZMK, ElmKeys chose RMK, a newer Rust-based keyboard firmware.

That choice fits the philosophy behind the keyboard itself. ElmKeys describes the Elytra as an ergonomic keyboard for people who don't want a steep transition from a standard layout, and RMK similarly combines ideas from both QMK and ZMK. You get robust wireless support while still supporting Vial for live keymap editing.

One exciting thing about this board is that it uses [RMK](https://rmk.rs/), an alternative to the popular [QMK](https://qmk.fm/) and [ZMK](https://zmk.dev/) keyboard firmware frameworks. It's exciting because:
-  QMK: Most popular, but only supports wired. [Vial](https://get.vial.today/) is a fork of QMK that supports live keymap updating like [VIA](https://www.caniusevia.com/) does, but has a better experience and supports things like combos.
- ZMK: Supports wired and wireless, built from the ground up with Bluetooth and low power optimizations in mind. Live remapping is very limited (at the time of writing) with ZMK Studio, most changes need to be done by compiling and reflashing.

RMK bridges the best features of QMK and ZMK together: first-class wireless support while also supporting live remapping with Vial!

Also as a developer, getting set up locally with the RMK toolchain is significantly easier than getting toolchains set up for QMK or ZMK, since RMK is written in Rust and uses cargo as the package manager and build tool.

# Layout

Pretty basic layout for a split row staggered keyboard. No right shift key. Fn/layer key is on the far right (above the right arrow). On a regular keyboard I have [capslock remapped as my layer key](/posts/2025/11/remapping-standard-keyboard/), but here I'd use the left space bar for it instead, which is a very nice feature of having dual space bars.

![Main layer.](vial0.png)

![Secondary layer.](vial1.png)

Chordal Hold and Flow Tap were added to Vial last July in [0.7.4](https://get.vial.today/changelog/release-0.7.4.html) and was a pretty big deal since it made home row mods much more usable. It's nice to see it included here, which shows that RMK is staying up to date with major features.
![Tap-Hold settings.](vial-settings-taphold.png)
# Closing Thoughts

The Elytra isn't trying to reinvent the keyboard. Instead, it focuses on making the move to an ergonomic split layout as painless as possible while delivering excellent build quality, quiet switches, and practical firmware.

It's certainly priced like a premium keyboard, but if you spend eight hours a day at your desk, it's not unreasonable to invest in one of the devices you use the most.

If you're already comfortable with aggressive ergonomic layouts, there are plenty of alternatives worth considering. But if you've been curious about split keyboards and don't want to relearn how to type, the Elytra is an easy recommendation. After a few weeks of daily use, I'd happily buy one myself if I were looking for an ergonomic upgrade that still feels familiar.

If you decide to pick one up, you can use my [referral link](https://elimkeys.com/?ref=ngemobbm) or coupon code `GLEEFULMOLE` for 3% off!

Happy typing!