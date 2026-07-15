---
name: cutit-rerank-before-stuff
description: Catches paying to include irrelevant retrieved candidates in the prompt when they could have been scored and dropped first — invoke whenever multiple retrieval candidates are about to be inserted into context ("stuffed") before the model reasons over them.
---

# cutit-rerank-before-stuff

Retrieval returns candidates ranked by a cheap similarity score, which is often loose enough that several irrelevant results make it into the top-k. If those get stuffed straight into the prompt, the model pays full input-token price to read and dismiss them — reasoning-token work a rerank step could have done for a fraction of the cost.

## Protocol

- Insert a reranking pass (cross-encoder, lightweight LLM scorer, or even a keyword-overlap heuristic) between retrieval and prompt assembly whenever candidate count exceeds what you're willing to stuff.
- Drop or truncate low-scoring candidates after reranking instead of passing the full retrieved set "in case the rerank missed something" — that defeats the purpose.
- Rerank on the passage that will actually be stuffed, not a proxy (title, summary) that can rank a chunk highly while its body is off-topic.
- When rerank cost matters, use a cheaper model or non-LLM scorer for the rerank step than the one that will consume the stuffed context — it's a narrow, mechanical judgment, not a reasoning task.
- Log discarded-vs-kept scores occasionally to confirm the reranker's cutoff line matches where the model would have judged content irrelevant anyway.

## When not to cut

If the reranker itself is unreliable for this domain (e.g. no cross-encoder tuned for the corpus's jargon) and it's discarding true positives, don't force a rerank step that hurts recall — fall back to a wider, unfiltered stuff and accept the extra tokens rather than silently dropping the correct answer.
