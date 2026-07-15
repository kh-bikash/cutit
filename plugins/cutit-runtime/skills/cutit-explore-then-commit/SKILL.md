---
name: cutit-explore-then-commit
description: Catches open-ended exploratory search that keeps going round after round looking for a "better" candidate instead of committing once a good-enough one turns up. Invoke when a search for a target (file, config, existing helper) has run more than two rounds without a clear miss.
---

# cutit-explore-then-commit

Exploratory search with no cap tends to keep spawning "one more grep" in case a marginally better match exists somewhere else — each extra round costs a full tool call and result set for a decision that rarely changes the outcome.

## Protocol

- Set an explicit round budget before starting (2-3 search rounds is typical) and track which round you're on.
- After each round, ask: does the best candidate so far actually satisfy the task? If yes, stop and use it — don't keep searching for a theoretically better one.
- Only spend a round past the budget if every candidate so far has a concrete, named disqualifier (wrong signature, wrong module, stale) — "might be something better" is not a disqualifier.
- When the budget runs out with a merely adequate candidate, take it and note the assumption rather than continuing to search silently.

## When not to cut

If every candidate found so far actively fails the requirement (wrong behavior, wrong scope, deprecated), committing anyway just relocates the bug — keep widening until you have at least one candidate that actually works, then stop.
