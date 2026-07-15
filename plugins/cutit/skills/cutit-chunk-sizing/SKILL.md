---
name: cutit-chunk-sizing
description: Catches the reflex of retrieving maximal chunk sizes "to be safe" — invoke when configuring or calling a retrieval/chunking step and picking how much surrounding text to pull per hit.
---

# cutit-chunk-sizing

Retrieval pipelines default to generous chunk sizes (full sections, whole pages, large sliding windows) on the theory that more context can't hurt. It can: every chunk that enters the prompt is paid for whether or not the answer lives in it, and oversized chunks also dilute the signal a reranker or the model has to work with.

## Protocol

- Size chunks to the smallest unit that contains a complete, self-sufficient thought for the corpus (a paragraph, a function, a config block) — not an arbitrary token count picked once and never revisited.
- If a query needs surrounding context to disambiguate a chunk, add a small fixed-size overlap or neighbor window rather than doubling the base chunk size for every query.
- Prefer many small chunks with a higher top-k over few large chunks with a low top-k — the small-chunk version lets a reranker discard misses without paying for their surrounding filler.
- When the same corpus serves multiple query types, don't size chunks for the most context-hungry query type by default — size for the common case and let deep-dive queries request more via a follow-up hop.
- Measure: if truncated chunks are producing wrong answers, grow the chunk size for that source type specifically, rather than growing globally.

## When not to cut

If the corpus is naturally atomic at a larger grain (a chunk boundary that splits a table, a proof, or a multi-step procedure mid-way produces a chunk that's individually meaningless), size to the natural unit even if it's large — a correct oversized chunk beats two cheap ones that each answer half the question.
