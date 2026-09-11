---
title: Off DFT Bins
date: 2026-09-11
---

I finally have a somewhat satisfactory intuition for what frequencies off of
the DFT bins mean?

I used to think they meant either nothing, or they were some perverse
projection that really should be expressed as the privileged linearly
independent basis vectors.

The thing that really bothered me is that numpy will show these "wide spikes"
in your graph by zero-padding your DFT, and then we will claim that we got
a "finer grained resolution" of the frequency domain.

There are two ways to add samples:

- Hold your absolute time constant, but increase the sample rate. This is fine,
  I understand this technique - and actually, this _can_ be used (do not
  reccomend) in OFDM to raw dog the buckets - if the sender has $N$ samples per
  symbol but reciever has $M > N$ samples per symbol, you can just straight
  layer the buckets on top of each other. The first $N$ DFT bins in each convolution
  are identical (no noise ofc). It's worth checking your intuition with
  Nyquist on this one - it makes sense because the nyquist limit is increased,
  so you're able to see more frequency components (even if they don't matter).
  The DFT bins are the exact same exponentials - you can verify this in the math.

- Hold your sample rate constant, but just append samples. Here, I used to be
  very bothered (still am) with this formulation because it seems like your
  frequency now depends on _how_ you choose to extend the signal and therefore
  your assumptions about the signal. So I just chose to ignore this - but if
  you look at D(T)FT padding, they're doing exactly this and claiming they're
  getting higher resolution "into the frequency domain". I don't know - maybe
  there's a formal equation for how things "spread", but I'm haven't seen it
  yet.

Taking a step back from the second paradigm, it might help if we look at the
_continuous time Fourier Transform_. We know that any two distinct frequencies
are orthogonal, and therefore have dot product 0.

We're not going to jump to the periodic fourier transform - We're going to just
try projecting `1 Hz` and `1.01 Hz` over time, and "incrementally" build the
dot product for a sin wave with `1 Hz`.

(note - this is still discrete time but finely _time sampled_ and projected
directly - the approximation still holds for the math I'm about to show :P)

```{=html}
<iframe src="widget.html" title="Accumulated sine-wave dot products"
  width="100%" height="360" style="border: 0; display: block; margin: 2rem 0;"></iframe>
```

I guess the point is that, as you extend these kinds of things to infinity,

The point of the periodic condition in both the "periodic fourier transforms"
$\mathbb{R}/(2\pi\mathbb{Z}) \to \mathbb{Z}$ and the DFT $\mathbb{Z}_n \to \mathbb{Z}_n$, is that at these bases, you know that
the frequencies will cancel out to zero because you know something about the
period. The "off bin frequencies" _intuitively_ should be 'noise' but they will
wiggle up and down and cycle up and down. Well, all frequencies do this when
projected, but the point is the DFT bases give a nice stopping point.

(Well, there's deeper math than that, that constrains the construction, but that's
one way to look at it).
