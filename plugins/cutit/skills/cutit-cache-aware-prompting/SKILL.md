---
name: cutit-cache-aware-prompting
description: Catches prompt structures that invalidate the provider's prefix cache on every call — invoke when assembling a prompt template that mixes stable instructions with per-call variables, especially in a loop that calls the same model repeatedly.
---

# cutit-cache-aware-prompting

Prompt caching only helps if the cached prefix is byte-identical across calls; a single per-call variable (a timestamp, a user id, a reordered field) placed early in the prompt breaks the match and forces a full-price re-read of everything after it. Loops that call the same model dozens of times pay this tax repeatedly if the volatile part isn't isolated to the tail.

## Protocol

- Order prompt sections stable-to-volatile: system instructions, fixed tool definitions, and static reference material first; per-call user input, retrieved context, and timestamps last.
- Never interleave a volatile field (current date, request id) into the middle of an otherwise-stable block — it splits the cache in two instead of leaving one long stable prefix.
- If a field changes rarely (a config value, a feature flag), treat it as stable and place it in the cached prefix rather than the volatile tail, even if it's technically variable.
- When the stable prefix must change (an instruction update), expect a one-time cache miss and batch other stable edits into that same change rather than trickling in small edits that each invalidate the cache again.
- For multi-turn tool loops, keep tool definitions and system prompt fixed across the whole conversation; don't regenerate or reorder them per turn even if the content is logically identical.

## When not to cut

If the task only makes one or two calls total, restructuring for cache hits saves nothing — the cache never gets reused, so don't spend effort reordering a one-shot prompt for a cache benefit that never materializes.
