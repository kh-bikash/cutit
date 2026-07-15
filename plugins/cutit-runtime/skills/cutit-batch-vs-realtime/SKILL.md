---
name: cutit-batch-vs-realtime
description: Catches bulk, non-urgent work (large-scale classification, log summarization, dataset transforms) being run through a real-time/interactive call path when a batch or async path would do the same job for less, and without occupying the interactive budget. Invoke when a task item-count is large and no immediate response is required.
---

# cutit-batch-vs-realtime

Real-time request paths are priced and provisioned for low latency; that premium is wasted on work nobody is waiting on synchronously. Bulk jobs run one-at-a-time through an interactive loop also re-pay fixed per-call overhead (prompt setup, tool routing) on every item instead of once per batch.

## Protocol

- Before firing off a loop of many similar calls, ask whether the result is needed immediately — if not, route it through a batch/async job instead of the interactive path.
- Group similar items into as few calls as the context window and task independence allow, rather than one call per item, to amortize fixed overhead.
- Use the batch path's own completion/callback mechanism to collect results instead of polling in a tight loop — polling burns interactive-tier tokens checking on batch-tier work.
- Reserve the real-time path for the item(s) actually blocking the user's next action; push everything else (backfills, bulk re-labeling, nightly summarization) to batch.
- If the workload is mixed (a few urgent items plus a long tail of non-urgent ones), split it — don't force the whole batch through real-time just because a few items need it.

## When not to cut

If the user is waiting on the result, or downstream steps in this same session depend on the output before they can proceed, route through the real-time path — batch latency (minutes to hours) would stall the task, and that stall costs more than the batch discount saves.
