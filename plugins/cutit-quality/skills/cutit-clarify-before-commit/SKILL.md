---
name: cutit-clarify-before-commit
description: Catches the pattern of guessing at an underspecified request and executing the full task on that guess, only to redo it at full cost once the user corrects the assumption. Invoke when a request has a genuine fork in interpretation before any code is written or files are searched.
---

# cutit-clarify-before-commit

A wrong guess on an ambiguous request doesn't just cost the redo — it costs the original wasted read/write/search pass plus the redo pass. Agentic loops tend to plow ahead rather than pause, because asking feels like it breaks momentum; but one short question is far cheaper than a full task executed twice.

## Protocol

- Before starting non-trivial work, check whether the request has more than one plausible interpretation that would lead to materially different output (different file, different scope, different format).
- If so, ask one specific, closed-form question (not an open-ended "what do you want?") — offer the likely options so the user can answer in a word.
- Don't ask about details that don't change the work either way — only fork on ambiguity that would actually change what gets built or where.
- If you can resolve the ambiguity cheaply yourself (a quick grep to see which of two files is meant, a glance at recent context), do that instead of asking — reserve the question for cases a cheap look can't settle.
- Batch multiple genuine ambiguities into a single question rather than asking one, getting an answer, then discovering a second fork.

## When not to cut

If the task is small enough that redoing it costs less than a round-trip question (a one-line fix, a quick lookup), just make the reasonable guess and proceed — asking would cost more than a wrong guess corrected in-place.
