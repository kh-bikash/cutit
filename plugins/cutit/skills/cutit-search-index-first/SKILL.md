---
name: cutit-search-index-first
description: Catches reaching straight for a live repo-wide grep/find when a cheaper prebuilt index, lockfile, manifest, or symbol table already answers the same question. Invoke before any raw search when the target is the kind of thing a project already indexes (dependency, symbol definition, route, exported API).
---

# cutit-search-index-first

Repos already carry indexes of the things agents commonly search for — lockfiles list resolved dependency versions, manifests list entry points and scripts, ctags/LSP symbol tables list definitions — but a live grep across every file re-derives the same answer at much higher token cost.

## Protocol

- Before a live search, check whether an index already exists for this question: lockfile for dependency versions, `package.json`/`pyproject.toml`/manifest for scripts and entry points, a generated symbol index or IDE-maintained tags file for definitions.
- Prefer reading the index file directly (it's usually small and structured) over grepping source for the same fact.
- Fall back to a live search only when no index covers the question, or the index is stale relative to what you need (e.g., checking uncommitted local changes).
- If unsure an index is current, a quick targeted grep to spot-check one entry is cheaper than distrusting the whole index and re-searching everything.

## When not to cut

If the index might be stale (generated at build time, not regenerated since a recent edit) and the task depends on current state, verify against a live search rather than trusting a cached answer that could be wrong.
