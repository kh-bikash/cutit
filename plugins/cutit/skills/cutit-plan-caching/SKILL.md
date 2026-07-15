---
name: cutit-plan-caching
description: Catches re-deriving a plan from first principles for a task shape you've already solved this session (or that the project defines a known recipe for) — the plan structure is reusable even when the specifics differ. Invoke when starting a task that matches a pattern you (or the project) have already planned before.
---

# cutit-plan-caching

Re-planning "add a new API endpoint" or "add a migration" from scratch each
time re-derives the same step skeleton every time: find the pattern, write
the piece, wire it in, test it. If that skeleton was already worked out
earlier this session, or the project already documents it, deriving it
again is redundant reasoning, not diligence.

## Protocol

- Before decomposing a recurring task type, check whether this session
  already produced a plan for the same shape, or whether the project has a
  documented recipe (a skill, a CONTRIBUTING doc, a template file) — reuse
  its step skeleton instead of re-deriving one.
- Keep the reusable part abstract (the sequence of step *kinds*) and only
  fill in the task-specific specifics (which file, which name) each time.
- When you do derive a plan for a task type likely to recur, note the
  skeleton somewhere you can find it again (task tracker entry, or ask
  whether it's worth a project skill) rather than letting it evaporate.
- Validate the cached skeleton still fits before running with it — a
  changed codebase can invalidate a template step or two; patch those,
  don't re-derive the whole thing.

## When not to cut

If this instance of the task differs from the cached case in a way that
touches its core steps (different architecture, different constraints),
don't force-fit the old skeleton — treat it as a new plan and let the
mismatch be the trigger for cutit-plan-revision instead.
