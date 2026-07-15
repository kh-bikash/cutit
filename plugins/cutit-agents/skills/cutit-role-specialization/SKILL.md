---
name: cutit-role-specialization
description: Catches the pattern of giving every agent in a pipeline the same broad context and letting each one re-derive facts another agent already established. Invoke when defining agent roles or system prompts in a multi-agent pipeline.
---

# cutit-role-specialization

When every agent in a pipeline gets the full picture "to be safe," each one spends tokens independently re-figuring out things a narrower, earlier-specialized agent already worked out — the same investigation paid for multiple times instead of once.

## Protocol

- Give each agent in the pipeline only the context and instructions its specific role needs, not a copy of the full task brief handed to every other agent.
- Assign one agent to establish a fact (which framework, which file layout, which constraint applies) and have every other agent consume that conclusion instead of re-deriving it.
- Write each agent's system prompt around its one job — a reviewer agent doesn't need the implementer's exploration notes, only the diff and the review criteria.
- When two agents would otherwise both need the same background fact, promote that fact to shared state or an earlier stage's output instead of duplicating the investigation in both prompts.
- Resist the instinct to make every agent "context-complete" out of caution — a narrower, well-scoped role produces a cleaner result at lower cost than a generalist role repeated N times.

## When not to cut

If an agent's role is inherently cross-cutting (a final integration or consistency check across everything the pipeline produced), it genuinely needs the broader context — don't force artificial narrowness onto a role whose job is to see the whole picture.
