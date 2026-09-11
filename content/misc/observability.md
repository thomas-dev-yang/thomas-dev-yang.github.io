---
title: Observability
date: 2026-09-10
---

Finally worked through some observability exercises; used OpenTelemtry to
help bootstrap understanding of _some_ modern workflows.

Distributed tracing is powerful, it helps if your protocol (HTTP) supports
a trace and a canonical way to append to it and consume it.

It's even more necessary to make this stuff as "opaque" as possible because
in a "real" system, your microservices will be replicated on the cloud, or the
cloud will provide storage (such as append only log) natively to you. So
finding the right boundary for telemetry and observability is really important
since you won't have access to idk, debugging something in gdb.

Well, the opentelemtry demo is mainly a classic web service that is very
"functional", in the sense that requests can be understood independently as
distinct state machines.

Something like a live editing app, all the way down to some super low latency
trading system, would have varying degrees of coupling with possibly more
in-house tooling needed. Or not - part of good software engineering is good
reuse!

---

One aspect of software engineering I don't appreciate enough is debugging and
reproducibility - what are we actually building, holistically, as a system.

I think there's at least three memes that come to the top of my head:

- Someone like Dijkstra, who can prove correctness about programs. This is how
  I thought I would end up liking software engineering (as I came from
  competitive programming).
  - This sort of fits into design space - design space cuts things out by
    construction (e.g. constraints).
- The engineer who can just "get a nice system to work". I do really like
  having this feeling too, but given the massive scale of these things, it's
  kind of hard to just "have" this work as something to optimize for. I don't
  know how to quite describe it. Like it's not really an actionable philosophy
  to work towards - maybe it is though, idk.

I think I'm leaning towards the type of engineer who can build systems in such
a way that it's painlessly easy to iterate and improve on the system. Research
is hard, theory-laden (and as a direct consequence, snapshots with best-effort
context are the only thing that survives; until you have an organizing paradigm,
but then if something breaks that paradigm you have to break out of that
"premature optimization" that compressed/projectde along that framework's axis).
And this kind of work directly starts tying into concerns like design decisions
and stuff as well.

I like doing this for several hours at a time - that's why I did competitive
programming. Trying to navigate the ambiguous space for weeks, months, years -
if you don't have a stable concept in mind to anchor against, it just all
becomes noise.

I do think there's something here. I don't know. "Neutral" tooling (there is
never such a thing, but first approximation) helps enable new capabilities
and ways of thinking. I've constantly been using AI for the last few years
(can we believe it's been a few years???) to try and upgrade my thinking, but
I think on these next few projects that I have, the key leverage will be a
good personalized research workflow.

There are some "mundane" things like how to do packaging on arbitrary systems
properly, or dev tooling. There are less mundane things like how to make
observability and testing work cleanly. And then comes, how to make
obesrvations about the system coherent - are they snapshots in time? How do you
not lose work? How does it inform future action?

I didn't try to make anything here focus on the _truthfulness_ of the claims.
I hate the word "truth". There are so many ways to both weasel in and out of
that space that it's just not a helpful global term to optimize for. Rather,
extend the capabilities of the system.

> Note: Coming back to the word "observation" and "obesrvation farming", I now
> realize that "observation" is heavily stateful, not stateless. And not just
> because "it was on my certain state of mind on a Tuesday afternoon in the
> student center" - that's what Descartes would have said. Nor will I claim
> that it must sit inside some grand historical narrative that unifies all
> possible relations between all entities. But merely the observation that
> theory ladenness is not a solvable problem.

Basically, the easier you make the system to work with, the better
intrinsically it is. It has the benefit that it's pleasurable to work with -
you could make some optimization argument about how a "simple but easy system"
will necessairly lead to more evolution than a complicated but rigid system,
but I don't know.
