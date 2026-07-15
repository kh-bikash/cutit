---
name: cutit-backend
description: Catches backend-specific token waste — unbounded query results, full schema/log dumps, verbose stack traces past the first project frame, whole request/response bodies pulled in to check one field. Invoke when working on an API, database, server logs, or a migration.
---

# cutit-backend

Backend debugging defaults to pulling in more than the question needs: a
full table dump to check one row's shape, a whole log tail to find one
error, every migration in history to understand the current schema. The
targeted version of each of these answers the same question for a
fraction of the tokens.

## Protocol

- Query with a row limit and a narrow column list by default; widen only once you know you need more rows or columns than that.
- `EXPLAIN`/dry-run a query before its result re-enters context when the question is about performance, and read the plan, not a full raw result set.
- Grep application/server logs by request id, trace id, or error signature instead of tailing the whole log file.
- Read a migration as a diff against the prior schema state, not the whole schema or migration history.
- Cap a stack trace to the first project-owned frame; pull framework/library frames in only if that frame doesn't explain the failure.
- Diff an API/schema contract's changed fields instead of re-reading the full spec after every change.

## When not to cut

A race condition, an N+1 query, or a cross-service failure often isn't visible from one narrow log line or a single query — once a narrow read fails to explain the symptom, widen to the full request trace or the actual query sequence rather than narrowing further on a hunch.
