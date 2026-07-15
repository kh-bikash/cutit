---
name: cutit-spawn-avoidance
description: Catches the default instinct to reach for a sub-agent whenever a task looks even slightly involved, when the calling agent already has every tool and every piece of context needed to just do it directly. Invoke as the first check the instant you consider spawning any agent.
---

# cutit-spawn-avoidance

Spawning feels like delegation of effort, but when the context is already
loaded and the tools are already available, it's really just an added
round trip: a fresh agent has to re-orient before it can do anything the
calling agent couldn't already do itself, one message sooner.

## Protocol

- Ask one question before spawning: "do I already have the context and
  tool access to finish this myself?" If yes, do it inline.
- Treat "this task has several steps" as insufficient justification on its
  own — multi-step and requires-a-sub-agent are not the same thing.
- Reserve spawning for tasks that are genuinely open-ended (unknown scope
  of exploration), parallelizable, or would otherwise flood your own
  context with material you don't need to retain.
- If you catch yourself spawning to "stay organized" rather than for a
  token or capability reason, that's the tell to just do the work directly
  instead.

## When not to cut

If the task requires a different tool surface than you have (a specialized
agent type with access you lack), or truly independent judgment (an
adversarial second opinion), spawn anyway — avoidance is a default bias
against reflexive delegation, not a ban on delegation when it's the only
way to get the capability or independence needed.
