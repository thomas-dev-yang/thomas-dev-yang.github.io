---
title: Ergodic Signals
date: 2026-08-14
---

This subject is mildly confusing because, although everything is formal, the
minimum description for a class of signals is confusing.

We should note right now that the object we are dealing with is ultimately a
measure over a set, where an element of the set is just an infinite vector
(say, $\mathbb{R}^{\mathbb{Z}}$).

However, the _description_ of said set is often so compact that it may lead you
to believe that stationary and ergodic mean something now. So, as a reminder -
_always_ remember that, no matter how simple and compact the equation is, you
should _always_ "compile" it down back to the core ontology of, an uncountable
set of infinite vectors of $\mathbb{R}^{\mathbb{Z}}$.

## Connections to group theory, and a failure of discreteness

Now, I'm not a mathematician, but this machinery is smelling a lot like group
theory.

The shift operator we introduce is, well, the operator. For all signals of the
same equivalence class (e.g. this is the orbit), they must show up with
uniform equal probability. This is the stationary property. Note that we didn't
say anything about inter-orbit probability, merely in-orbit probability.

Ergodicity is saying, that your set, _is_ the equivalence class. The canonical
"bad example" (all 1s and all 0s) fails because there are two equivalence
classes.

Except… this is not how anything works. Because we are dealing with uncountable
infinite sets, we need to employ measure theory - the intuitions I have are
just factually wrong, and not in a tiny way, but in a big way (especially the
ergodic description).

## Employing actual measure theory, and the Birkhoff-Khinchin theorem

From Wikipedia:

::: {.source-box}

**Birkhoff–Khinchin theorem.** Let $f$ be measurable,
$\mathbb{E}(|f|) < \infty$, and $T$ be a measure-preserving map. Then, with
probability 1,

$$
\lim_{n \to \infty} \frac{1}{n} \sum_{k=0}^{n-1} f(T^k x)
= \mathbb{E}(f \mid \mathcal{C})(x),
$$

where $\mathbb{E}(f \mid \mathcal{C})$ is the conditional expectation given
the $\sigma$-algebra $\mathcal{C}$ of invariant sets of $T$.

**Corollary (Pointwise Ergodic Theorem).** In particular, if $T$ is also
ergodic, then $\mathcal{C}$ is the trivial $\sigma$-algebra, and thus, with
probability 1,

$$
\lim_{n \to \infty} \frac{1}{n} \sum_{k=0}^{n-1} f(T^k x)
= \mathbb{E}(f).
$$

:::

I'm not going to lie, I still don't have a good intuition for measures, so I
can't say in good faith I'm interpreting this correctly.

However, _to me_, this reads something like, ergodicity tells you that you
don't need to worry about which orbit you're in, because there only _is_ one
orbit.

The issue is, is that this breaks. In the uncountably infinite case, orbits are
not "nice".

For a concrete example, Bernoulli sequences are ergodic sequences, and yet there
are clearly an infinite number of orbits. Take the sequences, `[01]*`, `[001]*`,
`[0001]*`, etc. and its rotations, those are finite orbits. An aperioidic
sequence has a countably infinite orbit, and there should be uncountably many
of those maximal aperiodic orbits (something something $\frac{2^n}{n} > n$)

> Note: Again, times like this are times where you will feel _really_ tempted
> to just proof bash, using the knowledge that a Bernoulli sequence has each
> index as a Bernoulli random variable. But I want to try avoiding that
> and think about the definition from first principles. You also avoid tricking
> yourself that way; e.g. just because they're "all random variables" doesn't
> avoid the fact that they "compile" down to concrete sequences, and thus there
> are real observable effects that break bad intuition. Neither ergodicity nor
> stationary means that each element is a random i.i.d. variable pulled from the
> same distribution.

We note that because $AT^{-1} = A$ works for _any_ set $A$, $A$ can be built
up from these smaller orbits. Ergodicity says that every measurable union of
whole orbits has measure 0 or 1.

I feel like this leads itself to the intuition of "one privileged set", so let
me break your brain. I will give a table of set properties that are
shift-invariant (before, we specified a base element then shifted it; here,
we describe more general properties that you can prove to yourself are shift
invariant).

| Property                                                | Measure |
| ------------------------------------------------------- | ------- |
| $x$ contains at least one 1.                            | $1$     |
| $x$ contains between two and four 1s in total.          | $0$     |
| $x$ contains at least five 1s.                          | $1$     |
| $x$ contains finitely many 1s.                          | $0$     |
| $x$ contains infinitely many 0s and infinitely many 1s. | $1$     |
| The word `00101` occurs somewhere in $x$.               | $1$     |
| Every finite binary word occurs somewhere in $x$.       | $1$     |
| $x$ is periodic.                                        | $0$     |
| $x$ is eventually constant to the right.                | $0$     |

---

Recall that ergodicity required that, for any shift-invariant property you
specify, it has either measure 0 or 1. I think we broke the naive intuition of
there somehow being some kind of "find the atom" pattern existing here (e.g.
it's not like a sigma algebra or topology).

On the other hand, we want to break out of the search for like, a "higher"
notion of shift-invariant sequences. I think, okay - you hear that all your
shift-invariant properties have measure 0 and measure 1, and the intuition
behind not wanting say, measure 0.7, is that one sample is "representative" of
the entire set. And obviously, if it had measure 0, then you wouldn't select
it, so there's nothing to "missample". So then you go around thinking that
there must be some privileged (non-vacuous) description to find.

The trick is that, a ton of properties can describe our Bernoulli sequence
well, which is what makes this _so weird_ (normally, you'd expect
properties to "compose" in a nice, hierarchical, somewhat fine-grained way).

But of course, philosophy aside, "representative of the set" means relative
to some metric - and that metric, plus the operational equation, is provided by
the Birkhoff-Khinchin theorem. The function $f$ can be pretty much any
function, and the `T` rotation operator helps $f$ 'search' arbitrary indices.

Another blog post will be dedicated to exploring the proof of said equation
and getting more intuition for the objects moving around here.
