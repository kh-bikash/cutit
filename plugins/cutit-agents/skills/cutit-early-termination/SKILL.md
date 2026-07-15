---
name: cutit-early-termination
description: Catches running the remainder of a fixed plan on autopilot after the actual goal has already been satisfied by an earlier step — the leftover steps produce no additional value but still cost tokens. Invoke after any step in a multi-step plan, to check whether the original goal is already met.
---

# cutit-early-termination

A plan is a means to a goal, not the goal itself. If step 3 of a 6-step
plan already produces the outcome the user wanted (the bug's already fixed,
the file already exists, the test already passes), running steps 4 through
6 anyway is just executing a checklist for its own sake.

## Protocol

- After each step, re-check the original ask against current state, not
  just against the plan — "is this satisfied now?" is a different question
  from "did I complete the next listed step?"
- If the goal is met early, stop and report that, explicitly naming which
  remaining steps you're skipping and why — don't silently truncate without
  saying so.
- Watch especially for plans built around a suspected bug or gap that turns
  out not to exist (a fix already applied, a feature already present) —
  the remaining "implement it" steps become moot the moment that's found.
- Distinguish "step done" from "goal done": a verification step you planned
  to run last can sometimes be checked cheaply right after an earlier step,
  short-circuiting the steps in between.

## When not to cut

If the remaining steps include verification that the early "success" is
real and not coincidental (e.g. a test passing by accident, a partial fix
that only covers one code path), don't skip that verification — confirming
the goal is genuinely met is part of meeting it, not overhead on top of it.
