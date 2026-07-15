---
name: cutit-function-calling-minimalism
description: Catches tool/function signatures carrying optional parameters, verbose descriptions, or redundant fields that get paid on every single call — invoke when designing or reviewing a tool schema before it ships.
---

# cutit-function-calling-minimalism

A function signature is transmitted in full with every call the model makes to it, not just once — a parameter nobody sets, a description repeating what the name already says, or a field derivable from another field is pure recurring cost multiplied across the whole session's call volume.

## Protocol

- Include only parameters that change the call's behavior in practice; drop ones that are always the same value or that duplicate information available elsewhere (a `file_type` field when the `path` extension already implies it).
- Prefer one well-named parameter over two that together encode what one enum or one combined field could express.
- Keep parameter descriptions to the minimum that resolves ambiguity — a type and a one-line purpose, not a paragraph of usage examples baked into the schema itself.
- Give required parameters short, unambiguous names so the model doesn't need a verbose description to use them correctly; save description budget for the genuinely ambiguous ones.
- When a tool has grown organically, review it for parameters that were added for one caller's edge case but now cost every caller — move rare cases to a separate tool instead of one bloated do-everything signature.

## When not to cut

If a parameter disambiguates between two dangerous behaviors (destructive vs. safe, write vs. read), keep it explicit and well-described even at extra token cost — a wrong default chosen to save a few schema tokens can cause an incorrect or harmful call, which costs far more than the tokens saved.
