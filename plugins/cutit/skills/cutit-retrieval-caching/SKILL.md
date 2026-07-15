---
name: cutit-retrieval-caching
description: Catches re-running retrieval for a query the session already answered, or one close enough in meaning to reuse — invoke before issuing a retrieval call inside a loop that has run similar queries earlier in the same session.
---

# cutit-retrieval-caching

Multi-step agentic tasks frequently re-derive the same lookup: a plan-then-verify loop retrieves the same doc twice, or a multi-hop reasoning chain re-asks a sub-question it already resolved two steps earlier. Each repeat pays full retrieval and re-reading cost for information already sitting in context or in a cheap cache.

## Protocol

- Before issuing a retrieval call, check whether this session already retrieved the same or a near-duplicate query (same key entities, same intent) and reuse that result instead of re-fetching.
- Key the cache on normalized query intent, not exact string match — "auth flow" and "how does authentication work" should hit the same cache entry.
- Keep cached results scoped to the session/task; don't reuse a cache entry across unrelated tasks where the underlying data may have changed.
- For sub-agents or parallel branches that each need the same lookup, retrieve once and pass the result down rather than letting each branch retrieve independently.
- Invalidate a cache entry explicitly when the task performs a write that could change the answer (an edit to the file just retrieved) — a stale hit is worse than a repeated fetch.

## When not to cut

If the underlying source is known to be volatile within the task's timeframe (live data, a file another step just modified, search results that can shift), re-fetch rather than trust the cache — a stale answer used with confidence is worse than the tokens saved.
