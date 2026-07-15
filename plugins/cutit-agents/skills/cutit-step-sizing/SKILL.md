---
name: cutit-step-sizing
description: Catches plans whose step granularity is miscalibrated against verification cost — either so fine-grained that checking each step costs more than the step itself, or so coarse that a failure requires re-tracing a huge span to isolate. Invoke when defining the grain of steps in a multi-step plan, before executing it.
---

# cutit-step-sizing

Verification has a fixed overhead per step (re-reading state, confirming
success). Steps too small make that overhead dominate the actual work.
Steps too large make the opposite mistake: when one fails, isolating which
part of a five-file, ten-edit "step" broke means re-deriving context across
all of it instead of one narrow span.

## Protocol

- Size each step to end at a point you can verify with one cheap check (a
  test, a grep, a single file read) — not one that requires re-scanning
  everything touched so far.
- Merge steps that would each cost more to verify separately than they
  would to verify together (e.g. three one-line edits to the same file).
- Split a step the moment it touches more than one independently-failable
  unit (different files, different subsystems) — you want a failure to
  point at one place, not a whole batch.
- If a step's verification cost is unknown, default slightly smaller —
  cheap to merge two verified steps later, expensive to untangle one that
  failed opaquely.
- Reuse the plan's natural boundaries (one file, one function, one test)
  as step boundaries instead of inventing arbitrary ones.

## When not to cut

For steps with cheap, side-effect-free verification (a pure read, a
lint check), don't force artificial splitting just to hit a granularity
target — the split itself has overhead too, and here it buys nothing.
