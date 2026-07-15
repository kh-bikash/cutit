---
name: cutit-artifact-reuse
description: Catches regenerating an entire document, artifact, or file from scratch when the user asked for a small, localized tweak to one already produced. Invoke whenever a follow-up request modifies something already generated rather than asking for something new.
---

# cutit-artifact-reuse

Rewriting a whole artifact to change one color, one paragraph, or one line re-spends the tokens of everything that didn't need to change. This shows up constantly in iterative artifact/document workflows where each round of feedback is small but the response regenerates the full thing anyway.

## Protocol

- For a requested tweak, identify the minimal span that needs to change and edit just that span in the existing file, rather than rewriting the whole artifact from a blank draft.
- Use a diff-based edit (not a full overwrite) whenever the tool supports it, so only the changed region is actually sent/rewritten.
- Re-render or republish using the same file/identity so the update lands as a revision, not a new, disconnected copy the user now has two of.
- If the requested change is large enough to touch most of the artifact anyway (a full restyle, a structural rewrite), a full regeneration is legitimately cheaper than a series of patches — recognize that threshold instead of forcing tiny edits past the point they help.
- Confirm the untouched parts still render correctly after a targeted edit — a small textual change can occasionally break surrounding structure (unclosed tags, mismatched braces).

## When not to cut

If the requested tweak is ambiguous about scope ("make it better," "clean this up") or plausibly implies a broader change than stated, ask or treat it as broader — a narrow patch that misses the user's actual intent costs more in back-and-forth than a slightly larger edit would have.
