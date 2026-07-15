---
name: cutit-diff-verification
description: Catches the reflex of re-reading an entire file to confirm an edit landed correctly when the diff itself already shows everything that changed. Invoke right after an edit, before deciding whether to re-read the file to check it.
---

# cutit-diff-verification

After an edit, re-reading the whole file to eyeball correctness re-spends tokens on every unchanged line — the tool that made the edit already reports exactly what changed, and that's the only part that could be wrong.

## Protocol

- Trust the edit tool's own confirmation (old_string/new_string match, applied hunk) as evidence the mechanical part of the edit succeeded — it already errors loudly if the match failed.
- Verify correctness against the diff: does the new text do what was intended, does it fit the surrounding lines shown in the change context, not the file end to end.
- If you need to see how the edit sits in context, read a small window around the change (offset/limit near the edited lines) rather than the full file.
- Only re-read the whole file when the diff alone can't answer the question — e.g. checking whether the edit broke an invariant that spans distant parts of the file.
- Chain multiple edits to the same file without re-reading between them — each edit tool call already reflects the current file state.

## When not to cut

If the edit could have second-order effects the diff doesn't show (reordering that changes execution order, a change to a shared helper whose other call sites matter, indentation-sensitive languages), read enough surrounding code to confirm those effects — don't let "the diff looked right" stand in for checking what the diff doesn't show.
