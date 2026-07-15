---
name: cutit-session-resumability
description: Catches losing enough state that a long task must restart from scratch after an interruption — invoke at the start of any multi-phase task and after each phase completes, to checkpoint the minimum needed to resume.
---

# cutit-session-resumability

A long task interrupted partway through — a crash, a context limit, a session handoff — costs nothing extra if the completed phases were checkpointed, but costs a full re-derivation of everything done so far if they weren't. Agents that keep progress only in conversational context lose it the moment that context is gone, forcing a cold restart that re-reads and re-reasons through work already finished.

## Protocol

- At each phase boundary, write down the durable facts needed to resume: what's done, what the next step is, and any decision that would otherwise require re-deriving (chosen approach, files touched, blockers found).
- Use a structured task tracker or a small state file for this, not a narrative log — resuming should mean reading a few fields, not re-reading a transcript.
- Checkpoint before risky or long-running steps specifically, since those are the ones most likely to be interrupted mid-way.
- On resume, read the checkpoint first and trust it — don't re-verify already-completed phases "just in case" unless the checkpoint itself looks stale or contradicted by current state.

## When not to cut

If the task is short enough to finish in one pass, or the checkpoint itself would cost more tokens to write and maintain than the task could ever lose by restarting, skip checkpointing — the insurance isn't worth the premium for small tasks.
