---
name: cutit-query-rewriting
description: Catches the retry-loop pattern where a vague first-pass query returns weak results and triggers a second or third retrieval call — invoke before issuing a retrieval query built directly from raw user phrasing.
---

# cutit-query-rewriting

Agentic loops often fire a retrieval call with the user's raw phrasing, get back weak or off-target hits, then issue another query, then another — each miss costs a full round trip plus the tokens for judging its irrelevance. A single well-formed query up front is cheaper than three vague ones and the filtering work between them.

## Protocol

- Before the first retrieval call, rewrite the raw query into a precise one: resolve pronouns and ambiguous references, add the specific term/identifier if known, and drop conversational filler that doesn't carry search signal.
- Expand implicit scope explicitly (which repo, which time range, which doc type) instead of relying on the retriever's default scope and re-querying when it guesses wrong.
- If the user's request bundles two questions, split them into separate targeted queries rather than one blended query that retrieves a muddled set for both.
- Use the cheapest available model or a fixed heuristic for the rewrite step itself — it's a mechanical transformation, not a task requiring the main model's full reasoning budget.
- Treat a second retrieval call as a signal to inspect and fix the rewrite step, not just a normal part of the loop — repeated re-querying on the same task means the first query was under-specified.

## When not to cut

If the user's intent is itself ambiguous (could mean either of two things), don't guess a single precise rewrite — a wrong confident rewrite retrieves confidently wrong results. Ask a clarifying question or issue one query per plausible interpretation instead.
