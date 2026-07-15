---
name: cutit-backoff-without-context-bloat
description: Catches re-appending the same failed request/output/error block into context on every retry attempt during a backoff loop, letting an N-attempt retry cost N times the tokens of one. Invoke when writing or driving any retry-with-backoff loop.
---

# cutit-backoff-without-context-bloat

A naive retry loop logs the full request and full error on every attempt: attempt 1's failure, then attempt 2's identical failure appended below it, then attempt 3's — by attempt five the transcript holds five copies of the same information. The backoff delay is supposed to be the only added cost, not a growing wall of repeated context.

## Protocol

- On retry, overwrite or replace the previous attempt's logged error in context rather than appending a new copy — only the latest attempt's state needs to be visible.
- Track attempt count and last error as small state (a counter and one message), not as an accumulating transcript of every attempt's full output.
- If attempts differ only in timestamp/attempt-number, note "attempt N failed, same error" instead of re-quoting the identical error body.
- Only keep a full record per-attempt when the error is *changing* across attempts (useful diagnostic signal) — that's a sign to stop blind-retrying and switch to root-cause diagnosis, not to keep backing off.
- Cap total retries with a fixed budget up front so the loop can't silently accumulate cost past the point the user would have wanted a diagnosis instead.

## When not to cut

If you're debugging *why* retries keep failing (not just trying to get one to succeed), keep the differing details across attempts — comparing what changed between attempt 2 and attempt 4 can be the diagnostic signal itself, so don't collapse those into "same error" summaries.
