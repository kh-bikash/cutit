---
name: cutit-known-failure-shortcuts
description: Catches re-diagnosing an error from scratch when its signature (message, error code, stack shape) matches one already solved earlier this session or documented in the project. Invoke as soon as an error message appears — check it against known signatures before starting fresh investigation.
---

# cutit-known-failure-shortcuts

Full diagnosis — reading source, tracing a call path, forming a hypothesis — is the expensive path, and it's wasted work if this exact failure already got solved once this session, or the project has already written down the fix (a troubleshooting doc, a comment, a past commit message). Re-deriving a known answer costs the same as deriving it the first time, but returns nothing new.

## Protocol

- On seeing an error, check it against failures already resolved this session (a matching message, error code, or stack shape) before starting a fresh investigation.
- Also check for a project-level record: a troubleshooting section, an FAQ, an inline comment near the failing code, or a recent commit/PR that touched the same area — a documented fix is cheaper to apply than to re-derive.
- Match on the error's *signature*, not surface text — a changed file path or variable name with the same underlying cause is still the same known failure.
- When a shortcut fix is applied, verify it actually resolves this instance before moving on — a matched signature is a strong prior, not a guarantee the context is identical.
- When you resolve a new failure that seems likely to recur, leave a trace (a clear commit message, a comment) so the next lookup — yours or another agent's — finds it.

## When not to cut

If the surrounding code or error details differ enough that the same fix might not apply (different call site, different input shape, a similar-looking message from an unrelated cause), treat it as a new diagnosis — applying last time's fix on a superficial match risks a wrong or silently-broken result.
