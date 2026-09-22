---
title: Agentic MicroVMs
date: 2026-09-22
---

This is actually a super interesting topic.

The core loop I'm seeing (at least as of literally just 09/22/2026) is a task
execution framework that describes meta-level objects called Tasks (it can be
injected by agents, users, pulled from Jira boards, etc), and then launches
self-contained harnesses within VM's to get the task done.

Of course, the granularity can shift; some people want VM's for _every tool
call_ (which makes no sense to me, tool calls can be so arbitrary that you're
just going to be doing plumbing all the time it feels).

I'm aware of some companies trying to compete in the higher-level layer - really
trying to make "task execution" formal (because you can compile anything to
"task execution"), auditable, trying to make specs "translate down" in a sane
way to code, etc.

I want to focus on the microVM aspect though. Not `gVisor` or containers. Just
VM's. I've never actually worked with something like Firecracker, but I would
like to do that. Just hack around and see what I can do. Certainly less
expensive than LLM inference. I'm not sure about the business use case, but
learning how people optimize VM's for performance would be a good challenge.
