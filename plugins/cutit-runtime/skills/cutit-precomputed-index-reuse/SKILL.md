---
name: cutit-precomputed-index-reuse
description: Catches re-scanning or re-summarizing the same codebase/document set for every new query in a session instead of building one index or summary up front and querying it repeatedly. Invoke when a session is likely to run multiple searches or questions over the same material.
---

# cutit-precomputed-index-reuse

Answering three separate questions about the same codebase by running three separate full explorations re-pays the scanning cost three times, even though the underlying material didn't change between questions. Building a lightweight index or summary once — a file/symbol map, a directory overview — turns each subsequent query into a cheap lookup instead of a fresh search.

## Protocol

- When a session's shape suggests several queries over the same material (a code review, a multi-part audit, repeated "where is X" questions), build a reusable map first: file structure, key symbols, or a brief per-module summary.
- Keep the index at the altitude the queries need — a directory/symbol listing for "where is X" questions, a semantic summary for "how does X work" questions — don't over-build detail no query will use.
- Answer subsequent queries by consulting the built index/summary first, only dropping to a fresh targeted search when the index doesn't cover the specific question.
- Refresh only the part of the index that a file edit actually touches, rather than rebuilding the whole thing after every small change.
- If only one query is expected, skip building the index — the upfront cost only pays off across multiple reuses; a single question is cheaper answered directly.

## When not to cut

If the codebase changes materially mid-session (a large refactor, files added/removed) don't keep answering from the stale index — rebuild the affected portion, since a fast wrong answer from an outdated map costs more than the rebuild would have.
