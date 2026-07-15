---
name: cutit-plan-revision
description: Catches the reflex of throwing out an entire multi-step plan and regenerating it from zero the moment scope shifts slightly — most of the original plan is still valid and re-deriving it is wasted tokens. Invoke whenever new information changes a plan that's already in progress or already written down.
---

# cutit-plan-revision

When requirements shift mid-task, it's tempting to re-plan wholesale because
that feels safer than reasoning about what changed. But most scope changes
touch a minority of steps — regenerating the untouched majority just to be
thorough re-spends tokens on conclusions that were already correct.

## Protocol

- Diff the new requirement against the existing plan before touching
  anything: which steps does it invalidate, which does it leave untouched?
- Patch only the affected steps (edit, insert, remove) and leave the rest of
  the tracked plan exactly as-is — don't rewrite the whole list to renumber
  or "clean it up."
- If a completed step is now wrong, mark it for redo instead of assuming
  everything downstream must also be redone — check dependencies, don't
  default to nuking them all.
- When the scope change is additive (a new requirement on top of the old
  one), append rather than restructure.
- Only fall back to a full re-plan when the change invalidates the plan's
  premise itself, not just its steps.

## When not to cut

If the new information contradicts the plan's core assumption (wrong
target file, wrong architecture, wrong problem entirely), patching around it
produces a Frankenstein plan that's wrong in new ways — discard it and
re-plan from the corrected premise instead.
