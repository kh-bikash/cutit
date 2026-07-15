---
name: cutit-external-state-over-recap
description: Catches re-typing a natural-language summary of the plan or progress-so-far into the conversation each turn instead of holding it in structured task tracking. Invoke on any multi-step task where the current status would otherwise need restating in prose.
---

# cutit-external-state-over-recap

A prose recap ("so far I've done X, Y, and I still need Z") gets re-read and re-written every time the plan is referenced, and it grows every turn — structured task tracking holds the same information as state you update in place, with no growing narrative to re-generate.

## Protocol

- Put multi-step plans into the structured task-tracking mechanism your environment provides (a todo list, task tool) rather than a paragraph you intend to keep updating.
- Update item status in place (mark done/in-progress) instead of writing a new prose summary of what's done so far.
- Reference tracked items by name/id when discussing progress rather than re-describing the whole plan in words.
- Reserve prose recaps for the final user-facing summary, not as a working scratchpad between steps.

## When not to cut

If the user needs a narrative explanation of progress (a status update they'll read, not the agent itself), write that prose — structured tracking is for the agent's own bookkeeping, not a replacement for communication the user actually asked for.
