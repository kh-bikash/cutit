---
name: cutit-working-set-minimization
description: Catches keeping files, variables, or state live in context long after the step that needed them has passed — invoke when moving on to a new step within a multi-step task.
---

# cutit-working-set-minimization

Each file opened, value inspected, or intermediate result kept "on the desk" stays in context for every subsequent turn until something removes it, even after the step that needed it is done. A task that touches ten files over ten steps doesn't need all ten live at step ten — it needs whichever one or two the current step actually operates on.

## Protocol

- Before moving to a new step, consider whether the previous step's open files or inspected values are still needed going forward; if not, treat them as closed rather than carrying them along by default.
- Re-open a file when a later step actually needs it again rather than keeping every previously touched file resident the whole session.
- Keep the active working set to what the current step reads or writes, not the union of everything touched so far.
- When switching focus between unrelated parts of a codebase, treat that as a natural point to drop the previous area's working set entirely.
- Track "what am I actively working on right now" as a short, explicit list rather than letting it grow implicitly as an ever-larger set of things once opened.

## When not to cut

If a later step needs to cross-reference two files together (comparing an interface to its implementation, checking a change against its test), keep both live for that comparison rather than minimizing down to one — the point is dropping what's unused, not fragmenting a task that genuinely needs several things in view at once.
