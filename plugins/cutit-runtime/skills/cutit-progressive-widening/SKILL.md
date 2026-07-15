---
name: cutit-progressive-widening
description: Catches defaulting to a repo-wide search when a narrower scope (current directory, current module, file type matching the task) would likely hit first. Invoke at the start of any search where the task already implies a probable location.
---

# cutit-progressive-widening

A repo-wide Grep/Glob returns everything, including matches in vendored code, generated files, and unrelated modules — sorting through that noise costs more than starting narrow and only widening if the narrow pass comes back empty.

## Protocol

- Scope the first search to the most likely location implied by the task: the current file's directory, the module named in the request, or a glob matching the relevant file type.
- Only widen the scope (parent directory, then whole repo) if the narrow search returns zero relevant hits.
- Widen one step at a time rather than jumping straight to repo-wide — each step should roughly double scope, not skip straight to the largest possible search.
- Once a widened search succeeds, don't retroactively re-run the narrow search "to compare" — the wider hit already supersedes it.

## When not to cut

If the task is explicitly cross-cutting (a rename that must catch every usage, a security audit for a pattern that could appear anywhere), start at full repo scope from the first search — progressive widening would just mean re-running the same search multiple times before reaching the scope you needed all along.
