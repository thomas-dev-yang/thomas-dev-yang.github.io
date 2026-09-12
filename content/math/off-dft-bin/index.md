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
try projecting `1 Hz` and `1.5 Hz` over time, and "incrementally" build the
dot product for a sin wave with `1 Hz`. Furthermore, we're going to constantly
normalize the sum so that the max sum is 1

```{=html}
<iframe src="widget.html" title="Sine-wave projection across 0–10 Hz"
  width="100%" height="380" style="border: 0; display: block; margin: 2rem 0;"></iframe>
```

I guess the point is that, as you extend these kinds of things to infinity, you
want _some_ kind of intuitive definition for what "orthogonal" is. But given the
nature of the exponentials, things are technically "not orthogonal" for
a finite duration (at the wrong boundary) because that specific frequency
component keeps wobbling between two bounded constnat values. And you want to
encode that intuition somehow. I'm sure advanced math can encode that intuition
just fine, but in terms of the _valid transforms_, we can avoid this problem
"by construction" by just picking the DFT bases as the privileged ones for
finite supports.

The point of the periodic condition in both the "periodic fourier transforms"
$\mathbb{R}/(2\pi\mathbb{Z}) \to \mathbb{Z}$ and the DFT $\mathbb{Z}_n \to
\mathbb{Z}_n$, is that at these bases, you know that the frequencies will
cancel out to zero because you know something about the period.

(I _do_ know from the algebra side - both abstract and linear - there are plenty
of reasons to show that the DFT bases are the "correct" bases by construction.
That's cool, but I'd imagine the analysis proofs used in the `CTFT` are where
the real meat behind my intuitions are. How do you intuitively say a function
is orthogonal and "goes to zero" at infinity, even when you have no such
guarantee on most finite support intervals?)

(Note: Maybe I'm overthinking it and it's just limits and forget.)
