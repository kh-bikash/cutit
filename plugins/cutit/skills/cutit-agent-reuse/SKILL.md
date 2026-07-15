---
name: cutit-agent-reuse
description: Catches spawning a brand-new sub-agent for follow-up work when an earlier one you already spawned is still idle and holds the exact context needed — a fresh spawn re-derives everything the idle one already knows. Invoke when a follow-up task relates to a sub-agent you spawned earlier in the same session.
---

# cutit-agent-reuse

An agent that already explored a module, read the relevant files, and
formed conclusions has that context loaded for free on a follow-up. Spawning
a new one instead throws that away and pays full price to rebuild it —
the same reads, the same file discovery, the same orientation.

## Protocol

- Before spawning, check whether a prior sub-agent (by ID or name) already
  did related work this session and could be resumed with the follow-up
  instead of replaced.
- Resume via a direct message to that agent rather than a fresh spawn call
  — it carries its full prior context forward automatically.
- Frame the follow-up as an incremental ask ("also check X," "now apply
  that finding to Y") rather than re-stating the original task, since the
  agent already has the original framing.
- If the follow-up is unrelated to what the idle agent was doing, don't
  force reuse just to save a spawn — an agent loaded with irrelevant prior
  context isn't actually cheaper for a disjoint task.

## When not to cut

If the idle agent's prior context is stale (the codebase changed since it
ran, or its conclusions were already superseded), don't resume it blindly —
a fresh agent free of outdated assumptions is worth the re-derivation cost
here.
