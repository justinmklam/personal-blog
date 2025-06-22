---
title: Using Baby Oil in Disc Brakes?
date: 2025-06-21T21:37:18-07:00
tagline:
image:
tags:
draft: true
layout: single
type: blog
aliases:
math: true
---

The disc brakes on my gravel bike were feeling spongy, so I was looking up tutorials on how to bleed disc brakes at home. A few videos later, I came across Seth's video about his 1 year review of using baby oil instead of mineral oil, and to my (and likely many of his viewers') surprise, it seemed to hold up and was still going strong. His video was proof that it worked, but I couldn't shake the feeling of wondering *why* it did... I mean, baby oil??

<!--more-->

{{< vid src="https://www.youtube.com/embed/63VIuPiX3CA" caption="Seth from Berm Peaks." >}}

I decided to do a bit of digging to curb my curiosity.

# Background

## Why it seemed to work?

Baby oil is _mostly_ mineral oil. The base ingredient is typically a highly refined petroleum-derived mineral oil, similar in appearance and viscosity to Shimano’s proprietary brake fluid.

That means:

- It can _transmit hydraulic pressure_ reasonably well.
- It won’t absorb water like DOT fluid (which Shimano doesn’t use anyway).
- It won’t boil instantly under normal riding conditions.
## Why it's probably a bad idea

- Baby oil contains additives like perfumes and moisturizers
- Baby oil most likely has a lower boiling temperature
## Why do it in the first place?

Looking at the prices below, baby oil does seem attractive for the wallet. However, we're talking dollars relative to the thousands that a bike typically costs these days. Maybe not worth the risk of crashing, but YMMV.

| Item                       | Cost (CAD) | Qty    | Normalized      |
| -------------------------- | ---------- | ------ | --------------- |
| Baby Oil                   | $9.99      | 200 mL | $5.00 / 100 mL  |
| Baby Oil (Bulk)            | $32.99     | 1L     | $3.29 / 100 mL  |
| Shimano Mineral Oil        | $12.95     | 100 mL | $12.95 / 100 mL |
| Shimano Mineral Oil (Bulk) | $57.99     | 1L     | $5.79 / 100 mL  |

# Physics

## Bulk Modulus

Hydraulic systems rely on fluids that don’t compress. The **bulk modulus** KKK tells us how stiff a fluid is under pressure:

$$ K=−V \frac{dV}{dP}​ $$

where:

- \(V\) is volume
- \(\frac{dP}{dV}\) is the change in pressure per change in volume

Typical values:

- Shimano Mineral Oil: ~1.5–1.8 GPa
- Cosmetic Mineral Oil: ~1.3–1.5 GPa

➡️ **Impact**: Baby oil may lead to a slightly mushier lever feel. Not disastrous, but not ideal.

## Boiling Point

**Heat from braking** is governed by:

$$ Q=mcΔT $$

Where:

- \(Q\) = thermal energy
- \(m\) = mass of fluid
- \(c\) = specific heat capacity
- \(\Delta T\) = temperature rise

Long descents = lots of heat = risk of boiling.

Estimated dry boiling points:

- Shimano Mineral Oil: ~260°C
- Baby Oil: ~160–200°C (depending on brand and additives)

➡️ **Impact**: Once the fluid boils, it forms gas bubbles — and since gas _is_ compressible, your brakes suddenly stop working. Not ideal on a steep trail.

## Viscosity Across Temperatures

The oil needs to flow well — not too thick in the cold, not too thin when hot.

Viscosity matters for how **quickly pistons return**, **lever feel**, and **modulation**.
-  **Kinematic viscosity** ν\nuν affects how fast pressure equalizes in the brake line:

$$ ν = \frac{\mu}{\rho}​ $$

Where:
- \(\mu\) = dynamic viscosity
- \(\rho\) = density

| Temp  | Shimano Oil | Baby Oil   |
| ----- | ----------- | ---------- |
| 0°C   | ~50 cSt     | 60–70 cSt  |
| 20°C  | ~25 cSt     | 30–40 cSt  |
| 100°C | ~10 cSt     | Wide range |

➡️ **Impact**: Baby oil thickens more at low temps and thins more at high temps, which can affect braking consistency.

## Seal Compatibility

Brake fluid must not degrade the rubber seals inside your master cylinder and calipers.

- Shimano oil is **formulated to be compatible** with EPDM and nitrile rubber seals.
- Baby oil contains **perfumes and moisturizers** (e.g., limonene, lanolin, aloe) that can **soften or swell rubber** over time.

➡️ **Impact**: Degraded seals may not fail right away, but they can lead to leaks, inconsistent braking, or catastrophic seal failure months later.

Seth looked under a microscope and they saw no differences, so might be ok.
