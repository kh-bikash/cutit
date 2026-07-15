---
name: cutit-partial-retry
description: Catches re-running an entire multi-step task from step one after only the last step failed, redoing work that already succeeded. Invoke when a pipeline, script, or plan with multiple steps fails partway through.
---

# cutit-partial-retry

When step 4 of a 5-step task fails, restarting from step 1 re-executes steps 1-3 that already produced correct output — re-reading files, re-running builds, re-calling APIs that didn't need to change. In agentic loops this compounds: every retry-from-scratch multiplies the cost of everything upstream of the actual failure point.

## Protocol

- Track which steps of a multi-step task have already completed and what they produced, so a failure doesn't erase that record.
- On failure, identify exactly which step broke and re-run only that step and anything downstream of it — leave completed upstream steps' outputs in place.
- If a step is not idempotent (it appends, creates, or mutates shared state), check whether it needs cleanup before re-running, rather than blindly re-invoking it and doubling the effect.
- Prefer task decomposition that makes steps independently re-runnable (each step reads clear inputs and writes a clear output) over one monolithic script where failure forces a full restart.
- When reporting the retry, state which step failed and which steps were skipped as already-done — this also lets the user catch it if your step boundary was wrong.

## When not to cut

If earlier steps' outputs may have gone stale (an upstream file changed, or the failure suggests a shared assumption was wrong all along), verify or re-run the affected upstream step too — resuming from a stale checkpoint is cheaper but wrong if the checkpoint itself is suspect.
