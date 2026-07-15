---
name: cutit-consensus-minimalism
description: Catches the pattern of having cross-checking agents each re-derive a full independent solution when comparing compressed verdicts would settle agreement just as reliably. Invoke when multiple agents verify or vote on the same output and full re-derivation isn't what the comparison actually needs.
---

# cutit-consensus-minimalism

When several agents check the same output, having each one produce and exchange a full re-derivation multiplies the original cost by the number of checkers — most of that expansion is redundant once a compressed verdict (pass/fail plus the reason) would let the comparison happen just as reliably.

## Protocol

- Have each checking agent produce a compressed verdict — agree/disagree, a confidence level, a one-line reason — rather than a full independent write-up of its reasoning.
- Compare verdicts, not the full reasoning behind them, to decide consensus; only pull the full reasoning for a specific checker if its verdict disagrees with the others.
- When checkers disagree, escalate by requesting the fuller reasoning only from the disagreeing side, not by re-running every checker at full depth.
- Standardize the verdict format across checkers so comparison is mechanical (a table, a small structured object) instead of requiring another pass to reconcile prose.
- Cap the number of independent checkers to what the decision actually warrants — three short verdicts settle most agreement questions as well as five would.

## When not to cut

If checkers disagree, or the decision is high-stakes enough that a wrong consensus is costly (a security sign-off, a irreversible migration), pull the full reasoning behind each verdict before deciding — a compressed verdict is a summary of confidence, not a substitute for it when confidence is what's actually in question.
