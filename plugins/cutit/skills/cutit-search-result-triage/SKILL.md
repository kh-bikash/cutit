---
name: cutit-search-result-triage
description: Catches opening every hit from a search in full when only the top few are actually relevant to the task at hand. Invoke whenever a Grep/Glob/search tool returns more than a handful of results.
---

# cutit-search-result-triage

A search for a common symbol or string can return dozens of hits; reading every one of them in full (as opposed to the file/line + snippet already in the result) pulls whole files into context that the task never needed.

## Protocol

- Rank the returned hits by relevance to the task before opening anything — exact-name matches, matches in the file the task named, and matches near the top of a file usually matter most.
- Read the top 2-4 most relevant hits in full context (via Read with offset/limit around the match); for the rest, rely on the filename and the snippet/line already returned by the search.
- If a lower-ranked hit turns out to matter after triage (e.g. it's the one actually called at runtime), read that one in full at that point — don't pre-read all of them defensively.
- When results are ambiguous (many equally-plausible hits), narrow the search pattern instead of opening more files to disambiguate.

## When not to cut

If the task requires an exhaustive change across every hit (a rename, a security fix that must land everywhere), every result needs to be opened and edited — triage only decides read depth, not which hits get skipped entirely for a task that legitimately touches all of them.
