---
name: cutit-memory-scoping
description: Catches pulling an entire memory store into context when a query only needs the entries relevant to this turn — invoke whenever a memory/notes/preferences system is queried.
---

# cutit-memory-scoping

A persistent memory store (user preferences, project notes, prior session summaries) tends to grow over a project's lifetime, and dumping all of it into every turn that touches memory costs more with each accumulated entry, most of which have nothing to do with the current request. A scoped lookup returns the handful of entries the current turn actually needs.

## Protocol

- Query memory with a filter tied to the current turn's topic (a tag, a keyword, a namespace) rather than fetching the full store and filtering in-context.
- When the memory backend supports similarity or keyword search, use it instead of listing everything and reading through for relevance.
- If a memory system only supports full dumps, apply a hard cap (most recent N entries, or entries matching an obvious keyword) rather than reading the entire history back in.
- Re-scope on each new topic within a session — don't keep an earlier topic's memory slice loaded once the conversation moves on to something unrelated.
- Write new memory entries narrowly scoped and well-tagged at creation time, since retrieval scoping is only as good as the structure the entries were saved with.

## When not to cut

If the task is explicitly about auditing or reconciling the memory store itself (deduplicating notes, checking for contradictions), a full read is the actual task — scoping down would just hide the inconsistencies you're there to find.
