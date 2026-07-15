---
name: cutit-breadth-vs-depth
description: Catches running a broad multi-file exploration when the target is already well specified — a named file, function, or error message that points at one place. Invoke when the request names a specific symbol/file/path instead of describing an area to explore.
---

# cutit-breadth-vs-depth

When the ask already names the thing ("fix the bug in `parseHeader`", "update `config/routes.rb`"), a repo-wide grep sweep or multi-directory Explore pass adds nothing — it just re-finds what was already given, at the cost of several extra tool round trips.

## Protocol

- If the request names a file, function, class, or error string, go straight there (Read/Grep for that exact symbol) instead of running an exploratory search first.
- Reserve broad exploration for when the target is genuinely unknown — a described behavior with no named location ("something's slow on checkout").
- Treat a single confirming Grep (to check the symbol still exists / find its line number) as sufficient targeting — don't follow it with a second, broader search "just to be sure" when the first one hit.
- If the named target turns out not to exist (renamed, moved, deleted), that's the trigger to widen — not a reason to have started broad in the first place.

## When not to cut

If the named file/function is large or the fix depends on callers or state defined elsewhere, depth still means reading enough context around the target, not just the one matched line — going straight there doesn't mean reading less than the fix requires.
