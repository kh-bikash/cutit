---
name: cutit-selective-recall
description: Catches a memory or history query returning the entire store when only the matching slice answers the question — invoke whenever querying any persistent history, log, or memory backend.
---

# cutit-selective-recall

A history or memory query that comes back as "everything on file" forces the agent to re-read and re-filter the whole store in-context to find the part that actually answers the current question. A query built to return just the matching slice does that filtering once, at the source, instead of every time downstream.

## Protocol

- Query with the most specific filter the backend supports (a date range, a keyword, a tag, an entity ID) rather than requesting the full history and narrowing afterward.
- If the first specific query returns nothing, widen incrementally (broaden the date range, drop one filter) rather than jumping straight to an unfiltered dump.
- When a backend only offers coarse retrieval (e.g. "last N entries"), pick the smallest N that plausibly covers the question, then widen only if it misses.
- Ask for a ranked or scored result set when available, and stop at the top few matches instead of reading through a long unranked list yourself.
- Treat "the store is small anyway" as the one case where filtering doesn't matter — for anything past a handful of entries, filter at the source.

## When not to cut

If the question is about the history itself — patterns across many entries, a trend over time, whether something ever happened — a slice can't answer it; query broadly enough to cover the full relevant range, and say so if that's larger than a typical scoped query.
