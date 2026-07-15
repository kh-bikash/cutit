---
name: cutit-relevance-filtering
description: Catches carrying the full accumulated history into a step when only a fraction of it bears on that step — invoke before referencing "everything so far" to decide the next action.
---

# cutit-relevance-filtering

An agent that reasons over the entire transcript at every step re-processes information that has nothing to do with the current step, "just in case" it turns out relevant. Most of a long session's history is irrelevant to any single next action; carrying it all forward costs tokens on every turn for insurance that's rarely cashed in.

## Protocol

- Before acting on a step, identify which pieces of prior context actually bear on it (the relevant file, the relevant earlier decision) and reason from those, not the full transcript.
- When summarizing status or handing off to the next step, include only the facts that step needs, not a comprehensive recap of everything discussed so far.
- Treat "just in case it's relevant later" as a reason to note something briefly, not a reason to keep it in full detail indefinitely.
- If a piece of context turns out irrelevant to several steps in a row, treat that as a signal to stop carrying it forward at all rather than continuing to re-evaluate it each time.
- Separate "what happened" from "what matters now" — the former can be long, the latter should be short and is what should drive the next action.

## When not to cut

If it's unclear yet which parts of history will matter (early in an ambiguous investigation, before the shape of the problem is known), keep more context live rather than filtering aggressively — under-filtering costs tokens, but over-filtering risks silently dropping the one detail that mattered.
