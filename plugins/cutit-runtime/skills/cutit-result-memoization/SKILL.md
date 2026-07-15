---
name: cutit-result-memoization
description: Catches recomputing a deterministic result (a build, a query, a parsed file, a computed diff) a second time in the same session when the inputs haven't changed. Invoke before re-running any tool call whose output you already have from earlier in this session.
---

# cutit-result-memoization

If a command is deterministic and its inputs are unchanged, running it again just re-pays for an answer you already hold. This happens often in agentic loops when a later step "just re-runs the check to be sure" instead of checking whether it already knows the answer.

## Protocol

- Before re-running a tool call, ask whether this exact call (same command, same file, same arguments) already ran this session and nothing relevant has changed since — if so, reuse the earlier result instead of re-invoking it.
- Track *what changed* between then and now (a file edit, a dependency bump); if nothing touching this computation changed, the cached result is still valid.
- For expensive one-time setup (parsing a large file, building an index, resolving a dependency graph), do it once and refer back to the in-context result rather than re-deriving it per use.
- If you're not sure the inputs are unchanged, a cheap freshness check (file mtime, a quick diff) is worth it — it's far cheaper than blindly recomputing, and cheaper than blindly trusting a stale value.
- Don't memoize across a boundary that changes the answer — a different working directory, branch, or environment invalidates the cached result even if the command looks identical.

## When not to cut

If the computation is non-deterministic (timestamps, network calls, anything with side effects or external state) or its inputs may have silently changed (a file another process could have touched), re-run it — reusing a memoized result you can't actually guarantee is still valid is a correctness risk, not a saved step.
