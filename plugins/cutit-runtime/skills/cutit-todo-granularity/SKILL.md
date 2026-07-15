---
name: cutit-todo-granularity
description: Catches creating a tracked todo item for every trivial one-line action, where the overhead of adding, updating, and re-reading the item costs more tokens than the step itself. Invoke when building or expanding a task list for a multi-step job.
---

# cutit-todo-granularity

Task tracking earns its keep by making multi-step work resumable and visible, but each item costs a write to create, a write to mark done, and space in every subsequent read of the list — for a step that's one trivial edit, that overhead can exceed the value of tracking it at all.

## Protocol

- Size todo items at the level a person would actually want status on — "update the auth middleware," not "add import statement" then "add function" then "add export" as three separate items.
- Group trivially small, closely related actions into a single tracked item rather than one item per line changed.
- Reserve separate items for steps that are independently checkable, risky, or long-running — where knowing "this one specifically is done" has real value.
- If a list is accumulating items that get marked done within the same turn they were added, that's the signal the granularity is too fine — merge going forward.

## When not to cut

If the user or the task needs visibility into fine-grained progress (a long migration with many independent files, a checklist the user will review step by step), keep the finer granularity — the tracking overhead is the point, not a cost to avoid.
