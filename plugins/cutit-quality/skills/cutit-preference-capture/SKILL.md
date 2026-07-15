---
name: cutit-preference-capture
description: Catches re-asking or re-deriving a preference the user already stated once (formatting style, tone, preferred tool, naming convention), instead of writing it to memory/config and reusing it silently in future turns and sessions. Invoke the moment a user states a durable preference, not just when you need it again.
---

# cutit-preference-capture

A preference stated once and never persisted gets re-asked next session, or worse, silently re-guessed differently each time — both cost tokens (a repeated question, or a wrong guess that needs correcting) that a single write to durable memory/config would have avoided permanently.

## Protocol

- When a user states a preference that will plausibly recur (formatting, tone, default flags, which tool to prefer, naming conventions), write it to the project's persistent memory/config file immediately, not just to working context for this turn.
- Phrase the captured preference as a standing rule, not a one-off note — so a future session reads it as "always do X," not "did X once because they asked."
- Before asking the user something they may have already told you, check the persistence file first — re-asking a captured preference is the exact waste this pattern exists to prevent.
- Keep captured preferences scoped to where they apply (project-level vs. global) so they don't leak into contexts the user didn't intend.
- Don't capture one-off, task-specific instructions as if they were durable preferences — that pollutes future sessions with rules that no longer apply.

## When not to cut

If it's unclear whether a stated preference is a durable rule or a one-time exception ("for this file, use tabs"), ask or infer conservatively rather than persisting it globally — an over-captured preference silently misapplied later is harder to notice than a question asked again.
