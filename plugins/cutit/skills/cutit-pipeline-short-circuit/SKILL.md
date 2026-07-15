---
name: cutit-pipeline-short-circuit
description: Catches the pattern of running every downstream stage of a pipeline even when an early stage's own check already fully answers the request. Invoke when designing pipeline control flow, or when a stage's output would make the remaining stages' work moot.
---

# cutit-pipeline-short-circuit

Running a full pipeline to completion when an early stage already has the answer (a cache hit, a trivial case, a check that already fails or already passes) spends every downstream stage's tokens on stages whose output can't change the outcome.

## Protocol

- Give early stages a way to signal "done, no further stages needed" rather than always passing through to the next stage unconditionally.
- Check for the conditions that make the rest of the pipeline redundant as early as possible: input already matches a known answer, a validation stage already fails hard, a trivial-case check already covers the request.
- When a stage short-circuits, return its result directly instead of running remaining stages "for completeness" on an outcome that's already settled.
- Design the short-circuit condition narrowly enough that it only fires when downstream stages genuinely add nothing — a vague "looks done" heuristic that skips real work is a correctness risk, not a saving.
- Log or flag when a short-circuit fires so it's visible that stages were skipped, rather than silently diverging from the normal pipeline shape.

## When not to cut

If downstream stages perform independent checks the early stage can't see (a security review after a functional pass, a distinct validation concern), don't let an early pass stand in for them — short-circuit only when the remaining stages would truly be re-checking the same thing the early stage already settled.
