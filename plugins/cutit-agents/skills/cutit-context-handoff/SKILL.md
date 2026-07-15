---
name: cutit-context-handoff
description: Catches pasting the full parent transcript (or an entire file/log) into a sub-agent's prompt "so it has everything," when the sub-task only needs a fraction of it — the rest is pure re-processing cost paid by a model that has to read it before doing anything. Invoke when writing the prompt or briefing for a spawned sub-agent.
---

# cutit-context-handoff

A sub-agent starts with nothing, which tempts an orchestrator to over-share
out of caution — dump the whole conversation, the whole file, the whole
error log. But the sub-agent has to read all of that before it can start
working; every irrelevant paragraph is tokens spent on comprehension that
produces no progress on the task.

## Protocol

- Write the handoff as a self-contained brief: the goal, the specific
  files/paths/line numbers relevant to it, and what's already been ruled
  out — not a transcript dump.
- Name exact paths and symbols instead of describing "the file we were just
  looking at" — precision substitutes for volume.
- Include prior findings as conclusions ("the bug is in X's retry logic,
  not the timeout"), not as the raw exploration that led to them.
- If a large artifact (log, diff, file) is genuinely needed, point the
  sub-agent at it (a path it can read itself) rather than inlining it in
  the prompt — let it read only the part it needs.
- Cut background that doesn't change what the sub-agent should do; a
  sub-agent doesn't need the history of a decision, just the decision.

## When not to cut

If the sub-task requires judgment that depends on nuance in the prior
discussion (why an approach was rejected, a constraint the user stated
offhand), include that nuance explicitly — summarizing it away can cause
the sub-agent to redo already-rejected work, which costs far more than the
extra context would have.
