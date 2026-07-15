---
name: cutit-lazy-tool-loading
description: Catches the habit of resolving a deferred tool's full schema the moment it's mentioned, instead of at call time — invoke when a tool listing shows names-only entries you don't need yet.
---

# cutit-lazy-tool-loading

In environments with deferred/on-demand tool schemas, every schema you pull in stays resident for the rest of the session, paid on every subsequent turn. Fetching schemas for tools you're merely considering — rather than about to invoke — inflates every future turn for no benefit.

## Protocol

- Resolve a tool's schema only in the turn where you're about to call it, not when you first notice it exists or decide it "might be useful."
- When several deferred tools might apply, resolve the one you're most confident about first; skip resolving the rest until you actually need a fallback.
- Batch schema resolution with the call itself where the interface allows it, rather than doing a resolve-then-wait-then-call round trip.
- Don't pre-resolve "for the rest of the task" — if the task has five steps and only step three needs a given tool, wait until step three.
- If a tool turns out irrelevant after inspecting its schema, don't resolve neighboring tools "while you're at it" — resolve the next one only when the next step needs it.

## When not to cut

If you're about to make several calls to the same tool across a tight loop, resolve it once up front rather than re-checking each iteration — the resolution cost is the same either way, so batching it saves nothing and delaying it only adds latency. Also resolve early when the task is explicitly about tool discovery (e.g. "what tools do I have for X") rather than tool use.
