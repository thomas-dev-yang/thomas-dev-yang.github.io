---
title: Virtualization Context
date: 2026-09-20
---

## The business case for virtualization

The concept of virtualization is not specific to say, Intel VT-x instructions.

Virtualization generally implies some level of homogeny in whatever domain
you're in - "pets vs cattle" is the common cloud meme. Of course, you could work
extremely hard to make this abstraction when it's _not_ the case, but that's the
main goal of virtualization.

In the "olden days" it was to multiplex resources.

For an OS it's to provide stable abstractions for developers to work with (e.g.
the process model).

For a programming language, it's a way to decouple from the underlying
architecture (JVM, Python VM, variety of functional programming languages).

### QEMU

QEMU is our big "modern" VMM. The problem that QEMU solves is arbitrary
emulation of whatever garbage you throw at it. It's great for that, but it's not
the _only_ type of virtualization out there.

### The Cloud

The cloud is interesting, because it _started_ as just a way to spin up an box
that you didn't own; very convenient. People started designing distributed
systems on it, but the convenience factor is mainly that you don't have to
manage your own hardware; software is still annoying (sysadmin hell is annoying
even for a couple of machines).

But as soon as you start selling the idea of elastic compute and automatically
scaling systems, you create a new _type_ of abstraction; a new capacity.

One interesting thing I learned was the Andromeda network at Google. Basically,
instead of talking directly to an Ethernet cable, or even a paravirtualized
network, you talk to this abstract network through just what seems like normal
hardware interfaces.

And of course, this brings up concerns like multi-tenancy and such so there's
the security model aspect of virtualization.

The cloud can make optimizations that QEMU doesn't because you own all of the
"base images" and hardware; and because you're a hyperscaler, you get rewarded
for centralizing and building these kinds of solutions.

### Agentic sandboxes

There's already Firecracker MicroVMs (from lambda etc.), but I'm seeing more and
more these "agentic VMs" that just want to spin up _specifically_ a virtual
machine for an agent to fuck around in, as fast as possible. And of course, if
you're selling yourself as a cloud, you can now choose to centralize said
semantics and do optimizations - there's also plenty of local VM spinup
solutions nowadays too.

---

## An aside on epistemological bootstrapping

In general, I've had an issue with technical stuff for a long time where I just
want to "focus on the technicals" without the _why_ - very academic perspective.

And when I say it like that, it sounds like "nothing matters except the
business". Well, the point is that business models such as some kind of
centralized software infrastructure incentivize distributions of inputs and
constraints that matter.

"Constrain things by construction" is one of my favorite memes, but creating an
elegant framework that doesn't have external coherence is an issue. And again,
you can interpret this as, "This has no use in the real world", but again,
framing it like this inspires a certain approach to science that has so far not
been beneficial. Drawing these divisions or even some kind of iterative feedback
loop that still draws divisions, is not helpful.

---

### Actual directions to take

So the main thing to learn from this, that wasn't immediately obvious to me
about VM's before, is that for these clouds/neoclouds, the requirement for scale
leads to certain decisions being made. And the use cases for these VM's are way
different than what you might hear when you hear about traditional virtual
machines (QEMU)

> Note: And again you can wrap this in a slogan like "well 1% saved at a
> neocloud is millions of dollars!" But the actual _type_ of abstraction you're
> building necessitates certain design decisions

Well, that sucks for me. Again, right now I'm stuck in a catch 22 - no
experience in systems, want to work in systems. _But_, the field is actually a
bit friendlier than LLM inference (I think) because single-machine VM
performance should be testable; of course, you don't get the centralizing
semantics of trying to manage a bunch of VM's at once, but it's better than
nothing and better than reading textbooks.
