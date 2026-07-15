---
name: cutit-context-budget-tracking
description: Catches running a long task without any awareness of remaining context headroom, so a hard limit forces an abrupt mid-task truncation — invoke periodically during any long-running or many-turn task.
---

# cutit-context-budget-tracking

Long agentic sessions accumulate tool results, file reads, and turn history until a context window fills up; if that happens mid-task without warning, the harness truncates or drops content unpredictably, sometimes losing the exact information the task still needs. Watching the trend instead of hitting the wall lets you choose what to compact, rather than having it chosen for you.

## Protocol

- Periodically check how much of the context budget has been consumed relative to the task's expected remaining length, not just at the very end.
- When usage crosses a rough threshold (e.g. roughly two-thirds full) with meaningful work still ahead, treat that as the trigger to start summarizing or offloading rather than continuing to accumulate.
- Prefer compacting the oldest, already-resolved parts of the session first — they're the least likely to still be needed verbatim.
- Note explicitly (to yourself, in a scratch file, or in a plan) what's still load-bearing before compacting, so you don't summarize away information a later step depends on.
- Treat budget tracking as a background check, not a task in itself — don't interrupt actual work to narrate remaining budget unless it's genuinely close to forcing a cut.

## When not to cut

If the task is short enough that it will finish well within budget, don't spend turns monitoring or pre-emptively compacting — that's overhead with no payoff. Also, if truncation would drop information needed to verify correctness (an error message, a diff under review), make sure that specific piece survives compaction even if older, unrelated material doesn't.
