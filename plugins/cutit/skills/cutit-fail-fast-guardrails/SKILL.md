---
name: cutit-fail-fast-guardrails
description: Catches running expensive downstream pipeline steps before the cheapest guardrail check has had a chance to reject bad input, wasting every step that ran before the eventual rejection. Invoke when ordering a multi-stage pipeline that includes both cheap checks and expensive processing steps.
---

# cutit-fail-fast-guardrails

If a pipeline runs generation, retrieval, and formatting before a cheap validity check finally rejects the input, every one of those stages was wasted the moment the check fails. Ordering the pipeline cheapest-check-first means a rejection happens before any expensive work starts, not after.

## Protocol

- Inventory all guardrail/validation steps in the pipeline (input schema check, length bound, permission check, content filter, expensive model-based review) and rank them by cost.
- Place the cheapest checks — the ones that reject clearly-bad input without any model call — at the very front of the pipeline, before any generation or retrieval step runs.
- Order the remaining checks so each stage only runs on input that survived every cheaper stage before it; don't run an expensive check in parallel with cheap ones "to save time" if the cheap one would have rejected first anyway.
- When a check rejects, stop the pipeline immediately and return the rejection — don't let downstream stages keep running on input already known to be invalid.
- Periodically confirm the ranking still holds: if a "cheap" check's cost grows (e.g. it starts calling out to a slow service), re-rank it relative to the others.

## When not to cut

If an expensive stage produces information the guardrail itself needs (e.g. a content check that must run on generated output, not the input), it can't be moved earlier — reordering around a genuine dependency would either break the check or make it check the wrong thing.
