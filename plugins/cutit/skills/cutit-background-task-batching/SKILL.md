---
name: cutit-background-task-batching
description: Catches polling a long-running background task every few seconds "to stay on top of it" — invoke whenever you've just started a background process or agent and are deciding when to check it next.
---

# cutit-background-task-batching

Checking a background build, test run, or agent every few seconds produces a burst of near-identical status calls that mostly say "still running" — each one costs a round trip and, if narrated, a line of output for no new information. The habit comes from treating monitoring like active waiting instead of like an event you'll be notified about.

## Protocol

- Prefer a mechanism that notifies on completion over manual polling whenever one is available — start the task and continue other work instead of checking in a loop.
- If polling is genuinely necessary, batch checks at an interval matched to the task's expected duration (a two-minute build doesn't need a check every ten seconds), not the shortest interval the tool allows.
- Never chain sleep-then-check in a loop to simulate waiting — that's the exact pattern that racks up redundant status calls.
- When you do check, ask for just enough to know if it finished or needs attention (exit code, last log line), not the full log, unless it did finish or fail.

## When not to cut

If the task is expected to finish in the time it takes to read its output once, or you need to react the instant a specific condition appears mid-run (a streaming build error you must catch immediately), a single well-timed wait is correct — don't stretch the interval so far that you miss the moment that mattered.
