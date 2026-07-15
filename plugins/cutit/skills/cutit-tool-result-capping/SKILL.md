---
name: cutit-tool-result-capping
description: Catches calling a tool with no limit/page size set, letting it return everything it can find — invoke before any search, list, or query call that supports a bound parameter.
---

# cutit-tool-result-capping

Tools that support pagination or a result cap usually default to "return as much as possible" when you don't specify otherwise, and an agent that doesn't set a limit gets exactly that — a wall of matches or rows, most of which are never referenced again in the conversation. Widening after seeing too little costs one extra call; reading an unbounded dump costs the whole thing every time it stays in context.

## Protocol

- Set an explicit small limit (a `head_limit`, a `page_size`, a `top_n`) on every call to a tool capable of returning an open-ended result set, even when the interface would let you omit it.
- Start with the smallest limit that could plausibly answer the question, and only re-run with a larger one if the first pass comes back empty or ambiguous.
- Prefer a count/summary response mode over a full-rows mode when you first need to know "how many," not "which ones."
- When a tool returns a "more results available" marker, don't reflexively fetch the rest — fetch more only if the current page didn't contain what you needed.
- Cap by relevance, not just by count: a tight glob/filter that returns 5 relevant rows beats a loose one capped at 5 that includes near-misses.

## When not to cut

If the task requires an exhaustive answer (counting all occurrences, verifying nothing matches a pattern, auditing every row), a capped call gives a wrong or unverifiable answer — remove the cap, or page through deliberately until you've covered the full set, and say so.
