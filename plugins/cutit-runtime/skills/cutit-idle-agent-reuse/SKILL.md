---
name: cutit-idle-agent-reuse
description: Catches spawning a brand-new sub-agent for a follow-up task when a recently completed or paused agent already holds the relevant context — invoke before any Agent call, to check for a resumable prior agent first.
---

# cutit-idle-agent-reuse

A fresh agent call starts cold: it has to be told everything again and often re-explores the same files or re-derives the same findings a previous agent already produced. When a follow-up question is a continuation of work an existing agent just did, spawning new pays for that re-derivation twice — once already sunk, once again from scratch.

## Protocol

- Before spawning an agent, check whether a recently completed or backgrounded agent already covers this ground — if so, resume it (message it directly) instead of starting fresh.
- Treat "related follow-up" broadly: a deeper dive on the same file, a fix for a bug that agent just found, or a next phase of the same investigation all qualify for resumption over respawning.
- When resuming, give only the new instruction — don't re-supply context the agent already holds from its own history.
- If it's genuinely unclear whether a prior agent's context still applies (its findings may be stale, or the task has diverged significantly), spawning fresh is cheaper than a resume that has to be re-explained anyway.

## When not to cut

If the follow-up is unrelated to what the prior agent worked on, or needs a different tool scope/isolation (e.g. a worktree the old agent didn't have), reuse would force it to discard irrelevant baggage or work in the wrong environment — spawn fresh instead.
