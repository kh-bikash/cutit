---
name: cutit-memory-write-discipline
description: Catches writing everything learned during a task into persistent memory, including facts trivially re-derivable from the code or logs already in the repo. Invoke before any write to a persistent memory/notes file.
---

# cutit-memory-write-discipline

Persistent memory gets read back in full on future sessions, so every line written to it is a recurring cost, not a one-time one — writing re-derivable facts (a function's signature, a file's current contents) bloats every future read for information a quick Grep would regenerate anyway.

## Protocol

- Before writing to memory, ask whether the fact could be re-derived by reading the code, config, or logs in under one tool call — if so, skip writing it.
- Write only what's genuinely durable and non-derivable: decisions made and why, constraints from outside the codebase (user preferences, external system quirks), dead ends already ruled out.
- Prefer a pointer (file path + what to check) over a copied value when the underlying source might change — a stale copied fact is worse than no note.
- Keep entries short and factual; a memory file is a lookup table, not a running journal of everything that happened.

## When not to cut

If the fact came from expensive, hard-to-repeat investigation (a flaky bug's root cause, a result from an external service that changes rarely), write it down even though it's technically re-derivable — re-deriving it would cost more than the memory write does.
