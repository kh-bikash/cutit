---
name: cutit-rolling-summary
description: Catches keeping a long session's full turn-by-turn history live when a maintained running summary would carry the same load-bearing facts — invoke once a session has accumulated many resolved turns.
---

# cutit-rolling-summary

A long session's transcript grows linearly with turn count, but the facts that actually still matter (decisions made, state reached, open questions) grow much more slowly. Keeping the entire turn-by-turn record live pays for the whole history on every future turn, when a periodically updated summary of "where things stand" carries the same operative information at a fraction of the size.

## Protocol

- Maintain a running summary of decisions, current state, and open items, updated as the session progresses rather than reconstructed from scratch at the end.
- When a batch of turns reaches a natural checkpoint (a subtask finishes, a milestone is hit), fold that batch into the summary and treat its blow-by-blow detail as no longer needed on its own.
- Keep the summary itself short and current — update it in place rather than appending a new summary on top of the old one each time.
- Distinguish in the summary between resolved facts (keep) and still-open questions (keep, flagged as open) so nothing pending gets silently dropped.
- Fall back to the full transcript only when the summary itself is ambiguous about something the current step needs — that's a signal the summary needs a fix, not a reason to abandon it.

## When not to cut

If the session is being audited or replayed for exact reasoning (e.g. the user wants to see why a specific earlier decision was made, verbatim), the full transcript is the source of truth and a summary is a lossy stand-in — keep the detail rather than summarizing it away.
