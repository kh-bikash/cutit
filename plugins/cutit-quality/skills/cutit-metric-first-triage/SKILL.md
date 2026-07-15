---
name: cutit-metric-first-triage
description: Catches opening individual failing cases one by one before checking what the aggregate metrics already say about where the problem concentrates. Invoke when a run produces both a metrics summary and per-case detail, before drilling into any single case.
---

# cutit-metric-first-triage

Aggregate metrics (pass rate by category, error type breakdown, slice-level scores) are usually already computed and cost nothing extra to read. Opening individual cases before checking them means spending tokens rediscovering, one case at a time, a pattern the summary would have shown in one read.

## Protocol

- Read the aggregate/summary view first: pass rate by category, error-type counts, score by slice — whatever breakdown the run already produced.
- Use that breakdown to decide which category or slice deserves a closer look, instead of opening cases in whatever order they happen to appear.
- Open individual cases only within the category the metrics flagged as worst or most concentrated, not across the whole set.
- If the metric breakdown doesn't exist yet, compute it once (a group-by/count pass) before opening any individual case — one aggregation pass is cheaper than N individual reads that each re-derive the same signal.
- Stop drilling into a category once you've confirmed the root cause it represents; move to the next-worst category rather than continuing to read more cases from one you already understand.

## When not to cut

If the aggregate metric is too coarse to distinguish real bugs from noise (e.g. an overall pass rate with no category breakdown available), or the case count is small enough that reading them directly is faster than building a breakdown, skip straight to the cases — computing a metric view that won't actually narrow anything is wasted motion.
