---
name: cutit-negative-result-shortcut
description: Catches exhaustively checking every remaining location to "prove" a negative when the question was already answered by the first authoritative miss. Invoke when a search is being used to confirm something does NOT exist, isn't referenced, or isn't the cause.
---

# cutit-negative-result-shortcut

Questions like "is this function still called anywhere?" or "does this config key exist?" only need one authoritative negative source to answer — but an agent unsure when to stop will keep grepping directory after directory to build confidence it doesn't need.

## Protocol

- Identify the single search that would authoritatively answer the negative (a repo-wide Grep for the exact symbol, a check of the one file that would define it) and run that first.
- If that search returns zero results and covers the relevant scope (right file types, no excluded dirs), treat the question as answered — don't re-run it with slight variations hoping for a different outcome.
- Don't chase the negative into unrelated locations "just in case" (docs, tests, comments) unless the question specifically depends on those being checked too.
- State the negative result plus the scope of the search that established it, so the answer is checkable without redoing the search.

## When not to cut

If the negative determines something high-stakes (safe to delete, safe to assume no callers before a breaking change) and the search scope might miss dynamic references (string-built calls, reflection, config-driven wiring), broaden the check before trusting the miss — a false negative here causes real breakage.
