---
name: cutit-task-decomposition
description: Catches the pattern of starting execution on a shallow plan, hitting a wrong assumption mid-task, and re-planning from scratch — each false start re-reads context you already paid for once. Invoke when breaking a non-trivial multi-step task into steps before executing any of them.
---

# cutit-task-decomposition

A plan that's too shallow looks cheap to produce but isn't: the first wrong
assumption forces a re-plan, and a re-plan re-reads most of what the first
pass already read. Three false starts at low upfront cost each end up
pricier than one plan built with enough investigation to survive contact
with the codebase.

## Protocol

- Before listing steps, spend a small, fixed amount of investigation
  confirming the load-bearing assumptions (file exists, API shape, which
  module owns the behavior) — cheap now, expensive to discover wrong later.
- Decompose to the level where each step has one clear success condition,
  not to the level of narrating every keystroke.
- Name the steps most likely to invalidate the rest of the plan (schema
  lookups, ambiguous requirements, unverified file locations) and do those
  first, even out of the plan's natural order.
- Write the plan down once (task tracker, not scratch prose) so revisiting
  it later is a lookup, not a re-derivation.
- If a step's outcome is uncertain, say so in the plan explicitly rather
  than discovering the uncertainty mid-execution — an acknowledged risk is
  cheaper than a surprise.

## When not to cut

If the task is small enough that a wrong first step costs less to redo than
the extra planning would cost to prevent, skip the upfront investigation and
just do it — planning depth should scale with the cost of being wrong, not
be applied uniformly.
