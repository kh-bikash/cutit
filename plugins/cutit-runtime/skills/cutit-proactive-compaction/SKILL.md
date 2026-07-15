---
name: cutit-proactive-compaction
description: Catches leaving a fully resolved sub-thread (a debugging detour, a completed subtask) sitting in full detail in context instead of summarizing it once it's done — invoke right after any sub-thread reaches a conclusion.
---

# cutit-proactive-compaction

Once a sub-thread is resolved — a bug is fixed and verified, a question is answered, a file's investigation is complete — the exploratory steps that got there (failed attempts, intermediate reads, back-and-forth reasoning) no longer need to stay live. Left alone, they sit until an automatic compaction eventually forces them out anyway, at a time you don't control and possibly losing detail you did still need.

## Protocol

- The moment a sub-thread concludes, replace its blow-by-blow steps with a short summary of the outcome (what was tried, what worked, the final state) rather than letting the raw trace linger.
- Do this per-subtask as you go, not as one big pass at the end — compacting incrementally means each summary is written while the detail is fresh and correctly captured.
- Keep the summary action-oriented: what changed and where, not a narrated retelling of the exploration.
- Drop failed intermediate attempts entirely once superseded by a working approach — their only value was reaching the resolution, which the summary now records.
- Preserve exact identifiers that later steps will reference (file paths, function names, error codes) in the summary even while dropping the surrounding narrative.

## When not to cut

If the sub-thread's resolution is provisional (a fix that hasn't been tested yet, an answer pending confirmation), don't compact it away — keep the detail live until it's actually verified, since you may need to backtrack into exactly what was tried.
