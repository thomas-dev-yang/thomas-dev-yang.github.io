---
title: Modality
date: 2026-08-16
---

OK I think I now have a better understanding of modality and why it's an
interesting problem.

I had this model of descriptivism pegged as Rorty's representationalism, e.g.
"Why do we need to keep finding some privileged language to represent things".
It's a bit different than that.

Imagine we had some kind of model of the world. I want to point to, that object
X. Descriptivism is, _never_ allowing some privileged "access" point to say,
"hey, it really _is_ that object in the world". Instead, maximally uncharitably,
you have to keep picking out qualities of the world and refer to it via
predicates. It's unsatisfying.

Reformulated in programming terms, imagine you had a database. Intuitively,
the object in a row is "really there", but your access to that object might
be through some insanely complicated predicate. But why confuse that access
to said object, with the object itself?

(Of course, these analogies presuppose structure that people would deny, so
don't take it too literally).

But here, we start talking about objects "in it of themselves". This seems like
an obviously correct intuition, but then, given the L's that the a priori has
taken over the centuries, it feels wrong. Quine pushes back on this - despite
being _representationalist_ (according to Rorty, in privileging science, though
it gets more nuanced than this), he's staunchly not on the whole Kripke train.

## Building up to modality

So, without any modality, the puzzle remains:

- Descriptivism seems wrong, because "properties that satisfy an object" aren't
  equivalent to the object.
- But if you start talking about how the "object really is", oh boy, centuries
  of philosophy are going to start biting you in the ass. That kind of talk
  is _never_ good. It doesn't line up with everyday intuitions. And scientists
  certainly wouldn't try to keep this descriptive veil here. No - electrons
  really _do_ exist (apologies, Cartwright, Hoefer, and real physicists, for
  this laughably simplistic description)

The ways for people to buy into your "ehh this thing is a mushy abstract mess"
is to either do something with it, or constrain it.

If you put counterfactual reasoning over what the "object really is", supposedly
that constrains thought space in a useful enough way to do stuff with it. I
wouldn't know, I'm not familiar enough with this field.

I don't know if there are frameworks out there that start with this exact
problem and solve it in another way _besides_ modality, but it appears that
modality has cached out sufficiently powerful results that it's a staple now.

## Modality and the causal-historical theory of reference

From the way I see it, nobody would believe the causal-historical theory of
reference (or at least, treat it as non-vacuously useful) if not for Kripke's
modality on top of it and actually cashing out by showing usefulness. I mean,
when you read it, it just seems kind of true, but not really interesting. Maybe
I'm underselling it though.

Importantly, this means that other forms of modality (Carnap, Leibnizian) are
"wrong" in the sense that they don't anchor to this interesting problem to
solve. Well, I'm not a Leibniz scholar, and I'm barely a Carnap enthusiast
(I need to read Michael Friedman…), but Carnap kind of like, didn't do
anything. I mean, okay, like Popper, by formalizing his intuitions, he revealed
problems with them (two dogmas, and descriptivism).

Well, that's a bit of post-hoc reasoning. Maybe I could sit here and try to
really retrofit L-languages back onto rigid designators, but I'm no
philosopher. At a first pass, Carnap is weird because he varies all function
predicates for his modality. While you could encode designators
semantically (this function means, "This chair at time t is blue"), you don't
really care about the designators, like, at all.

> Note: I am _not_ saying that a function predicate can refer to an object. But
> if you want two predicates that say, "This chair is red", and, "This chair is
> blue" in Carnap's logic, you cannot. Without significant modifications that
> he probably doesn't want, you cannot support "The 'This chair' is the same in
> both predicates"; that must be inferred from say, _meaning postulates_ (ah,
> those lovely terms).

And this is what I mean by "bad architecture" (as all problem solvers know).
Your way of looking at the problem can make something hard or easy. C
