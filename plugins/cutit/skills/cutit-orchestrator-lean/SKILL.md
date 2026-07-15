---
name: cutit-orchestrator-lean
description: Catches an orchestrator that delegates a sub-task but then also independently reads the same files or re-derives the same findings itself "just to be sure" — the work ends up held in two contexts instead of one. Invoke whenever you delegate a task, immediately after the sub-agent is spawned or has returned.
---

# cutit-orchestrator-lean

Delegating a task is supposed to keep its bulk out of the orchestrator's
own context. That benefit is lost if the orchestrator also reads the files
it handed off, or re-verifies conclusions the sub-agent already checked —
the same exploration now sits in two places, and the orchestrator paid for
both.

## Protocol

- Once a sub-task is delegated, don't independently open the same files
  the sub-agent is working on unless its result comes back insufficient —
  trust the digest first.
- Keep the orchestrator's own context to the delegation brief and the
  returned summary, not the intermediate work either side did to get there.
- If you need to double-check a sub-agent's conclusion, re-verify the
  specific claim narrowly (one grep, one read) rather than redoing its
  whole exploration.
- Resist "reading along" with a sub-agent's work out of curiosity while it
  runs — anything you read yourself is context you're now holding
  redundantly.

## When not to cut

If the sub-agent's result is ambiguous, contradicts known facts, or is
high-stakes enough that an error would be costly, verify it properly —
holding the check redundantly in the orchestrator's context is the right
trade when correctness is actually in doubt.
