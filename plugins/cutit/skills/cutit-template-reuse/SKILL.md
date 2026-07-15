---
name: cutit-template-reuse
description: Catches reformatting or regenerating a fixed prompt template's boilerplate on every call instead of reusing its cached prefix verbatim — invoke when a loop calls the same prompt template repeatedly with only small parts changing.
---

# cutit-template-reuse

When a template is rebuilt from scratch each call — re-serializing the same tool definitions, re-writing the same instructions with minor formatting differences (extra whitespace, reordered keys) — it looks identical to a human but isn't byte-identical to the provider's cache, so every call re-pays full price for content that never actually changed.

## Protocol

- Store the fixed portion of a template (instructions, tool schemas, static examples) as a literal constant and concatenate the variable portion onto it, rather than regenerating the whole string from a formatter each call.
- Keep serialization deterministic: fixed key order, fixed whitespace, fixed encoding — anything that can vary run-to-run (dict ordering, floating timestamps in a "generated at" comment) breaks byte-identity for no functional reason.
- When a template is shared across multiple call sites, use one source of truth for its stable part instead of letting each call site format its own copy that drifts slightly over time.
- Version the stable prefix explicitly when it does need to change, so you can confirm all call sites are back in sync rather than silently running mismatched near-duplicate prefixes.
- Avoid "helpful" per-call touches to the stable part (adding a fresh comment, adjusting indentation) — even cosmetic edits invalidate the cached prefix from that point on.

## When not to cut

If the template must legitimately vary per call in its early sections (personalized instructions, per-user config baked in near the top), forcing byte-identical reuse would mean serving stale or wrong content — let that part vary and confine reuse to whatever genuinely is constant, even if that's a smaller prefix.
