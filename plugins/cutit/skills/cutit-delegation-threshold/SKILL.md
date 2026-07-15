---
name: cutit-delegation-threshold
description: Catches indecision about whether to spawn a sub-agent, resolved by gut feel instead of a concrete rule — leading to either delegating trivial work (paying cold-start cost for nothing) or doing sprawling exploration inline (flooding your own context). Invoke at the moment of deciding whether a sub-task should be delegated.
---

# cutit-delegation-threshold

Delegation has a fixed cost: a fresh agent re-derives context you already
hold. That cost is worth paying only when the sub-task's own cost —
exploration breadth, context pollution, parallelizability — exceeds it.
Without a concrete threshold, agents either delegate reflexively or never
delegate at all, both of which burn more tokens than a rule would.

## Protocol

- Delegate when at least one is true: the sub-task needs open-ended,
  multi-file exploration you don't need to keep in your own context
  afterward; it's independent enough to run in parallel with other work;
  or it would pull in enough raw material (logs, search results) to flood
  your context with detail you won't reuse.
- Don't delegate when the context the sub-task needs is already loaded in
  your own session — re-deriving it in a fresh agent is strictly more
  expensive than just doing the work.
- Don't delegate single-tool-call lookups (one grep, one file read) — the
  round-trip overhead of spawning exceeds the task.
- When borderline, weigh it by size: a sub-task under a few tool calls
  rarely clears the threshold; one requiring a dozen exploratory reads
  usually does.

## When not to cut

If the sub-task is small but the outcome is high-stakes and benefits from a
fresh, unbiased read (e.g. an independent review), delegate anyway — the
threshold above is about token cost, not about every situation where a
second perspective is genuinely more valuable than saving a spawn.
