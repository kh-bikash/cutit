---
name: cutit-cross-turn-dedup
description: Catches redoing a search, computation, or file read from an earlier turn because a later user message asks for something that's actually already been produced or is derivable from it. Invoke when a new request sounds similar to something already done earlier in the conversation.
---

# cutit-cross-turn-dedup

Multi-turn sessions accumulate work — files read, values computed, summaries written — that a later turn can reuse if the agent notices the overlap. Without checking, each new turn is treated as a blank slate and redoes the earlier work, even though the answer (or the material needed to derive it quickly) is already sitting earlier in the transcript.

## Protocol

- Before starting a new turn's task, scan whether an earlier turn already produced the needed result outright, or the raw material to derive it cheaply (a file already read, a list already computed, a value already looked up).
- Reuse the earlier result directly when the request is the same computation restated; derive from earlier material (a filter, a sort, a reformat) rather than re-fetching from scratch when the request is a variation.
- Watch for rephrasing that hides the overlap ("what were the failing tests" after already having run and shown the test output) — match on intent, not exact wording.
- If session state may be stale by the time of the later turn (files could have changed, the user may have edited something), do a cheap freshness check before trusting the earlier result outright.
- When reusing, say so briefly ("reusing the file list from earlier") so the user can flag it if they actually wanted a fresh look.

## When not to cut

If the user's later request implies something changed since the earlier turn (they mention an edit, a new run, or explicitly say "check again"), treat it as a fresh task — assuming the old answer still holds when the user's phrasing suggests otherwise risks giving a stale answer with false confidence.
