---
name: cutit-handoff-summarization
description: Catches the pattern of forwarding a raw transcript between agents or pipeline stages instead of a compressed summary of what the receiving side actually needs. Invoke at every agent-to-agent or stage-to-stage handoff before deciding what to pass along.
---

# cutit-handoff-summarization

A raw transcript carries every dead end, retry, and clarifying exchange that got the sending agent to its answer — none of which the receiving agent needs to redo its job. Forwarding it wholesale makes the receiver pay context-processing cost for work it will never use.

## Protocol

- At each handoff, write a short summary of the outcome and the decisions that matter downstream — not a replay of how the sending agent got there.
- Include only facts the next stage needs to act (final result, key constraints discovered, open questions) — drop exploratory reasoning, failed attempts, and tool-call noise.
- Keep the summary in a stable, predictable shape (result, caveats, next-step pointer) so the receiving agent can parse it without re-deriving structure from prose.
- If the receiving agent asks a question the summary doesn't answer, add that one fact to the summary going forward rather than reverting to full-transcript handoffs.
- Prefer a structured artifact (a short state object, a few labeled fields) over a narrative recap when the downstream consumer is another agent rather than a human.

## When not to cut

If the receiving agent's task is to audit or debug how the prior agent reached its answer (not just use the answer), it needs the real transcript, not a summary of it — summarizing away the reasoning defeats the point when the reasoning itself is what's being reviewed.
