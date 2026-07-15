---
name: cutit-pipeline-stage-isolation
description: Catches the pattern of forwarding a pipeline's entire upstream history into each new stage when that stage only needs the immediately prior output. Invoke when designing or wiring a multi-stage agent pipeline where later stages receive more than the previous stage's result.
---

# cutit-pipeline-stage-isolation

Passing full upstream history into every stage means each stage re-pays the token cost of every earlier stage's exploration, reasoning, and false starts — costs that stage has no use for once the prior stage has already distilled them into a result.

## Protocol

- Define each stage's input as the prior stage's output only, not the full transcript of how that output was produced.
- If a later stage genuinely needs something from further back (an original user constraint, a fixed spec), pass that one fact forward explicitly rather than the whole history it came from.
- Design stage boundaries around clean handoffs — a stage's job is to produce output the next stage can consume without needing the "how," not to narrate its own process for downstream benefit.
- Resist adding "just in case" context to a stage's input; if the next stage turns out to need something missing, add that one fact, don't default to forwarding everything preemptively.
- Keep each stage's prompt/instructions scoped to only what that stage does — don't let pipeline-wide context accumulate in every stage's system prompt.

## When not to cut

If a downstream stage's correctness genuinely depends on decisions made several stages back (why an approach was rejected, a constraint discovered mid-pipeline), that decision needs to travel forward explicitly — losing it to strict isolation trades a real correctness risk for a token saving that isn't worth it.
