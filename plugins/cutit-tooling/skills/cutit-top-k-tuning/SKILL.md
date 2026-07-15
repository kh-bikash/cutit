---
name: cutit-top-k-tuning
description: Catches over-fetching in retrieval calls — pulling top-20 and filtering down in the prompt instead of asking for what's actually needed. Invoke when setting or defaulting a top-k/limit parameter on a retrieval or search call.
---

# cutit-top-k-tuning

A common pattern is calling retrieval with a large top-k "so nothing gets missed," then having the model or a filter step discard most of it after it's already in context. The discarded candidates still cost tokens to read and reason past — over-fetching only moves the waste from the retrieval call into the prompt.

## Protocol

- Start top-k at the number of results the task actually needs (often 3-5 for a single-fact lookup), not a large round number used as a safety margin.
- If recall is genuinely uncertain, raise top-k at the retrieval layer with a cheap reranker or score-threshold filter downstream of it — not by handing the raw large set to the model to sift.
- Tune top-k per query type: a broad "summarize what's known about X" needs more candidates than a narrow "what's the value of Y."
- Watch for a score cliff in returned results (a sharp drop after the first few) as a signal that k was set too high for this query; use it to lower k for similar future queries.
- Don't hardcode one global top-k for every retrieval call in the pipeline — a single constant tuned for the hardest query type overspends on every easier one.

## When not to cut

If the task is recall-sensitive — verifying a claim is *absent*, or aggregating across a long tail of sources — a low top-k risks a false negative that's worse than the extra tokens. Widen k explicitly for that query and say so, rather than quietly under-fetching.
