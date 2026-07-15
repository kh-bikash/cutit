---
name: cutit-subagent-scoping
description: Catches handing a sub-agent an open-ended brief ("look into the auth system," "improve this module") that invites it to explore far beyond what's needed, instead of a closed task with a defined boundary and stopping condition. Invoke when writing the task description for a sub-agent you've decided to delegate to.
---

# cutit-subagent-scoping

An open-ended brief has no natural edge, so a sub-agent given one tends to
keep reading related files, following tangents, and second-guessing scope —
exactly the unbounded exploration delegation was supposed to contain, just
relocated one level down instead of eliminated.

## Protocol

- State the sub-agent's deliverable as a closed question ("does function X
  have a race condition on field Y") rather than an open one ("review
  function X") — closed questions have a natural stopping point.
- Name the exact files, functions, or directories in scope, and say
  explicitly that adjacent areas are out of scope unless the task can't be
  answered without them.
- Give an explicit output shape and length cap so the sub-agent optimizes
  for a fixed deliverable, not for maximal thoroughness.
- If the task is genuinely open-ended by nature (a broad audit), scope the
  breadth explicitly ("check these five files, not the whole repo") rather
  than leaving breadth for the sub-agent to decide.

## When not to cut

If the task's whole purpose is an open-ended investigation (find where a
regression was introduced, with no known suspects), a closed scope would
bias the sub-agent toward the wrong place — leave the exploration genuinely
open there, and rely on a length/turn cap instead of a scope cap to bound
cost.
