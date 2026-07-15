---
name: cutit-state-diffing
description: Catches rewriting an entire tracked state document (plan, todo list, progress file) from scratch each time one item changes, instead of patching just the change. Invoke whenever tracked state needs an update and the mechanism supports partial edits.
---

# cutit-state-diffing

Regenerating a whole state file to flip one item's status re-sends every unchanged line along with the one that actually moved — the cost scales with total state size instead of with the size of the actual change.

## Protocol

- Use an in-place update (a todo tool's status change, a diff-based Edit) for the one item that changed rather than regenerating the full list or document.
- When the tracking mechanism only supports full replacement, keep the replacement as close to the previous version as possible — change only what's different, don't reformat or reorder unrelated entries while you're in there.
- Batch genuinely simultaneous changes into one update rather than one rewrite per item when several items change at once.
- Verify the diff you're sending only touches the intended item before applying it — a diff that accidentally reverts unrelated state costs more than the rewrite would have.

## When not to cut

If the state has drifted or gotten inconsistent (items out of order, stale entries that no longer apply), a full rewrite to clean it up is worth the one-time cost — don't keep patching around a structure that's become wrong just to avoid a rewrite.
