---
name: cutit-stale-context-pruning
description: Catches letting an outdated version of something (a file since re-read, a plan since revised) linger in context alongside its replacement — invoke whenever a piece of context gets superseded by a fresher read or decision.
---

# cutit-stale-context-pruning

When a file is re-read after an edit, or a plan is revised after new information, the old version doesn't disappear from the transcript — it sits next to the new one, and a careless later step can reason from the stale copy instead of the current one. Beyond the correctness risk, both copies cost tokens on every turn when only one is ever true anymore.

## Protocol

- When you re-read a file you've edited or that changed, treat the earlier read as void — reason only from the new content, and don't refer back to line numbers or contents from the old version.
- When a plan or decision is revised, state the revision clearly and stop treating the earlier version as active, rather than letting both versions coexist as ambiguous inputs.
- If the environment doesn't automatically remove superseded content, explicitly flag it as stale ("ignore the earlier read of this file, use the current one") so future reasoning isn't misled by it.
- Prefer re-deriving from the current source of truth over patching together an answer from a mix of old and new context.
- Periodically ask whether anything currently being relied on is actually a stale snapshot of something that has since changed — this is especially likely after edits, external tool state changes, or multi-turn plan revisions.

## When not to cut

If you need to explain what changed (a diff, a "before vs. after" comparison for the user), keep both versions available for that specific purpose — pruning is about not reasoning from stale state, not about erasing the record of what changed when that record is the actual output requested.
