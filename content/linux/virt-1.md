---
title: Linux Virtualization 1
date: 2026-08-12
---

A lot of disparate facts were learned today.

Virtualization is tricky. _Conceptually_, the idea is: there are some
instructions that are independent of an operating system thinking that it's
the only operating system running on the hardware, and some that are not.

## CPU

The model for KVM here is that, KVM exposes a virtual CPU (vCPU) that has state
that you can explicitly set, such as registers. A vCPU corresponds to just a
normal userspace thread on the host - you call `kvm_run` with it, and it just
runs, virtualized.

Whenever the _host kernel_ preempts the thread, (remember, this is just a normal
host userspace thread at the end of the day! running in virtualized mode in a
virtualized context, ofc), you get kicked out of the VM. (I still have no real
clue how interrupts work in the Linux Kernel, so I won't dwell too deep on this
today.)

## Page tables

Another thing you have to lie about is memory. The guest OS thinks it owns
a page table with all of the relevant accesses,

## Devices and virtio

Honestly still very shaky on MMIO, PCI, and in general just devices. Not a
hardware guy...

But virtio is very cool. Basically, the idea comes from this sequences of
ideas:

- naively, if we just had the previous two abstractions (RAM and CPU), you're
  missing the devices. The guest expects a device - _because_ the whole point
  of the KVM abstraction is to hand control back to the user on a trap, a
  first approximation is to _emulate_ the device entirely in userspace.

- A next step could be to have the user try to hook you up to the actual driver
  itself. (On thinking this through, this second step wouldn't actually make
  much sense. Emulating a device is one thing - but how would a user actually
  access the driver? You could try and interpret into a userspace interface for
  it, but that assumes enough structure from your incoming request...)

- We could skip bouncing to-from userspace, and handle IO events in the kernel
  directly. I believe this is what some KVM extensions do.

> Note: There are also things like PCI passthrough, which again, I would
> understand better if I understand actual device IO...

So working within that paradigm, we see that the idea is, "okay, we got booted
out of the VM, how can we minimize work and translations between layers".

The specific part of virtio that is cool, is that, virtio can advertise itself
as a device, to linux. Linux can detect virtio devices, and _the guest kernel
will specialize itself_ to adapt to the knowledge that it is a virtio device.
One example of an optimization you can get with this kind of ecosystem buy-in
is batching operatoins in such a way that VM exits don't happen as often.
Normally, guest code is guest code, right - you just want to be able to load
a `.iso` and call it a day. Virtio is this really cool optimization that almost
tailors the guest to the hypervisor.

The specifics are beyond me right now (because it's tied up in MMIO
semantics...), but that is really cool.

## Emulating PCI and booting firmware

This part is just knowing hardware. But it's interesting the sort of shortcuts
you can take and what the underlying object you are targeting is supposed to
be.
