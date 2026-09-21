---
title: Tailscale
date: 2026-09-20
---

## Compiling the Mesh Network

From what I understand, Tailscale is basically saying that the internet is a
complete garbagehole, but it can compile down a p2p network for you and send the
configurations to your remote machines. The goal is to get your two machines to
communicate in a p2p network in whatever cursed network hack is necessary
(though the high level simplification is, classic STUN + NAT hole punching, same
trick that UDP p2p games do, with DERP relay as a fallback, which is just a...
relay, from what I understand).

It also provides a networking model on top of that, which is probably
interesting for network engineers because they already have internalized all of
the "bullshit" underneath - it also is a key differentiator of tailscale, since
it _is_ the higher level language to compile down _to_ the "bullshit".

I'm not sure how much of the "bullshit" I want to learn. It's super valuable in
that it's something that _needs_ to get done, and I agree that Tailscale
genuinely enables a new capability - p2p wireguard mesh network that just works
because of a thin control plane is a new _genuine enablement tool_. But given
that I have limited time to study, I'm not sure how good it is.

It's adding more to the toolbox of "systems-based workloads", though - I think
raw testing garbage network configurations is an interesting problem.

### Kubernetes

An interesting thing I didn't know (because I don't do anything related to cloud
software engineering) is that Kubernetes has its own ontology and network
similar to tailscale to make networking not a pain. It's not anywhere similar to
a Wireguard VPN mesh network with a separate control plane, but the idea of
abstracting out a cancer network layer is still there.

Tailscale also writes custom integrations with Kubernetes because of the custom
semantics. So, adapters and wrappers and translators for everything :)

### apenwarr

Interesting dude and interesting writing. Some blogs I read:

- [The New Internet](https://tailscale.com/blog/new-internet)
- [Systems Design](https://apenwarr.ca/log/20201227-systems-design-explains-the-world-volume-1)
- [Book Recs](https://apenwarr.ca/log/20180724-books-that-explain-parts-of-how-the-world-really-works)

If nothing else, this is someone I would not have found by just aggregating
hackernews blogs.

### WireGuard

WireGuard is interesting - the observation is that all you _really_ need for a
VPN is just an encrypyted UDP tunnel using normal public/private key paring is
kind of unintuitive but also pretty smart at the same time. I'm not sure about
the history behind OpenVPN, but I'd imagine the issue was trying to do too much
at once (again, not sure _what_). WireGuard is just doing exactly one thing
well.

#### zx2c4

Another cracked legend. This is an insane quote I found on reddit:

> In some ways, writing the Windows port was extremely challenging, because
> there is so much more work and nearly endless complexity on the Microsoft
> platform. We had to write a brand new kernel driver for tun interfaces --
> Wintun -- because OpenVPN's tap6-windows driver is garbage (they've since
> switched to using our Wintun! great cross pollination). And in order to
> integrate deeply with the mostly undocumented Windows networking stack and
> NDIS, I had to reverse engineer massive swaths of the operating system to find
> private APIs and unusual behavior. (Getting this information directly from
> Microsoft would have required me signing an NDA, which obviously is a
> non-starter for a FOSS project.) On top of that, the Go runtime was in sore
> need of Windows work, so I had to add a lot to that. Plus, the security model
> has lots and lots of gotchas, so designing around those was a big challenge,
> so much so that I found it necessary to put together a public attack surface
> document, just to sort of keep it all straight. It was just a monumental
> effort.
>
> But on the other hand, once I got rolling writing Windows code, I became
> thoroughly hooked, like finding a delicious box of cookies from childhood.
> It's layers and layers of complexity, and so many competing ideas and
> modalities all put into adjacent and overlapping libraries, with functionality
> duplicated and contradictory all over the place, and a million ways that
> different Microsoft binaries do different things, and highly complex state
> machines with multiple interlocking moving parts, and endless abstractions
> upon abstractions, and separations upon separations combined with layering
> violation upon layering violation, and a supremely interesting kernel
> design... It is a vast archaeology of computing. And I kind of love it, for
> all of its ugly glory. Reverse engineering it and integrating ever more deeply
> with the platform is great fun.
>
> So, in spite of its difficulties, I really did enjoy doing the Windows port.
> And I'm looking forward to some of the enhancements we have planned there too.

This is the type of work that would make me rip my hair out. Trying to be a
protocol lawyer over existing prior implementations is one of the highest
leverage things you can do as someone in software, but if I couldn't create a
clean abstraction from it, I would feel annoyed. Maybe it's a bit of arrogance.

- Dealing with a lot of crap -> Inventing the WireGuard or Tailscale abstraction
  = Good
- Dealing with a lot of Microsoft accidentals -> Improve a specific capability
  on a new platform = Bad

even though both are valuable pieces of work. This guy can handle both the
abstraction creation _and_ the abstraction holding. He is both Prometheus _and_
Atlas.

Also,
[found another neat book through him!](https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html)
