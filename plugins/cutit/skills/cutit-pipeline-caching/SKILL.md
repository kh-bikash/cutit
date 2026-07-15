---
name: cutit-pipeline-caching
description: Catches the pattern of recomputing a pipeline stage's output on every run even when none of that stage's inputs changed since the last run. Invoke when a pipeline re-executes on repeated or incremental invocations and some stage's inputs are frequently unchanged.
---

# cutit-pipeline-caching

Re-running a stage whose inputs are identical to last time reproduces the same output at full cost — the tokens spent regenerating an unchanged result are pure waste on every incremental or repeated pipeline run.

## Protocol

- Before running a stage, check whether its declared inputs match what produced the last cached output; if they match, reuse the cached result instead of recomputing.
- Key the cache on the actual inputs that affect the stage's output (file contents/hashes, upstream stage results, parameters) — not on wall-clock time or run count, which don't reflect whether the output would differ.
- Invalidate only the cache entries whose inputs actually changed; don't flush the whole pipeline's cache because one upstream stage produced a new result.
- Store cached output somewhere retrievable across runs (a file, a keyed store) rather than only in-memory for a single session, if the pipeline is expected to re-run later.
- Make cache hits visible (a short note that a stage was skipped and why) so it's clear the pipeline didn't silently skip real work.

## When not to cut

If a stage has side effects beyond its return value (writes to an external system, sends a notification) or its output depends on something outside the declared inputs (current time, external state), don't cache it — a stale cache hit there produces a wrong result, not just a faster one.
