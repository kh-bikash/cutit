---
name: cutit-diff-only-output
description: Catches printing an entire file or object's before-and-after state to show an edit — invoke whenever you're about to report a change and could show just the delta instead.
---

# cutit-diff-only-output

Pasting a whole file (or a whole JSON blob, config, or record) twice — once for "before," once for "after" — to communicate a one-line change makes the unchanged 95% the majority of the output. It happens because a full dump feels safer or more complete than trusting the reader to infer what stayed the same.

## Protocol

- Report changes as a diff or a small "changed: X -> Y" list, not as two full copies of the artifact.
- When using an edit tool, let its own diff output stand as the record of the change instead of also re-printing the full file afterward.
- For structured data (config, JSON, table rows), name only the fields/rows that changed and their new values — reference the rest as "unchanged" rather than reproducing it.
- If several small edits land in one file, batch them into a single diff-style summary rather than one full-file dump per edit.

## When not to cut

If the user asked to see the whole file, or the change touches so much of the file that a diff would be harder to read than the full result (a near-total rewrite), show the full state instead — a diff that's 90% of the file isn't saving anything and may obscure what actually changed.
