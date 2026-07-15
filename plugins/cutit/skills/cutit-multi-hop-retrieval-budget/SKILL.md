---
name: cutit-multi-hop-retrieval-budget
description: Catches unbounded chaining in multi-hop retrieval loops — invoke when a retrieval step's output is about to trigger another retrieval step ("follow this reference," "look up what X depends on") without a hop cap.
---

# cutit-multi-hop-retrieval-budget

Multi-hop retrieval (follow a reference, then follow what that reference cites, then what that cites) can chain indefinitely on graphs with dense cross-links, and each hop's cost compounds — not just the fetch, but re-reading everything gathered so far to decide the next hop. An uncapped loop pays for hops that add little marginal information.

## Protocol

- Set a low default hop cap (often 1-2) for the loop and only raise it when the low cap demonstrably fails to answer the query.
- Escalate hop count incrementally on retry, not straight to "unlimited" or a large number — try cap+1 before jumping to an open-ended chain.
- At each hop, check whether the accumulated context already answers the question before issuing the next fetch — the loop should have an early-exit condition, not just a max-hop ceiling.
- Prefer breadth-limiting per hop (fewer branches followed at each level) over depth-limiting alone — a hop cap doesn't help if each hop fans out to dozens of candidates.
- When a hop's result is a near-duplicate of information already gathered, stop expanding that branch rather than continuing to chase it to the cap.

## When not to cut

If the query is inherently transitive (tracing a dependency chain to its root, verifying a claim through a chain of citations) and a low hop cap would return an incomplete or misleading answer, raise the cap up front for that query class rather than forcing a retry loop to discover the cap was wrong.
