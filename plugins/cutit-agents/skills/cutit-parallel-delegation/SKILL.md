---
name: cutit-parallel-delegation
description: Catches spawning independent sub-agents one at a time, waiting for each to finish before starting the next, when they don't depend on each other — serial spawns cost the same total tokens but add wall-clock and re-orientation overhead each time you resume. Invoke when a plan has two or more sub-tasks that don't depend on each other's output.
---

# cutit-parallel-delegation

Spawning sub-agents serially when they're independent doesn't save tokens
on its own, but it compounds the wrong way: the orchestrator re-reads its
own plan state between each spawn to decide "what's next," and any shared
setup context gets re-established per spawn instead of once. Fan-out turns
N sequential re-orientations into one.

## Protocol

- Before spawning, check whether the sub-tasks read/write disjoint targets
  and don't need each other's output — if so, they're parallel candidates.
- Issue all independent spawns in one batch/turn rather than one-per-turn;
  most agent runners support concurrent sub-agent calls in a single
  response.
- Give each parallel sub-agent the same shared context once, up front,
  rather than re-explaining it as each prior one returns.
- Reserve serial spawning for genuine pipelines, where sub-task N+1 needs
  sub-task N's actual output, not just "logically comes after" it.

## When not to cut

If the sub-tasks contend for the same file or resource, don't parallelize
just because they look independent on the surface — conflicting concurrent
edits cost far more to untangle than the serial approach would have saved.
Check for shared targets before batching.
