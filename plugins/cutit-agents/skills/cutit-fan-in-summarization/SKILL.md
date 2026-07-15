---
name: cutit-fan-in-summarization
description: Catches reading each returned sub-agent result in full one at a time and re-summarizing after every one, instead of collecting all results and synthesizing once — repeated partial summarization re-processes the same growing context on every pass. Invoke when multiple sub-agents spawned in parallel are returning results that need to be combined.
---

# cutit-fan-in-summarization

When results from a fan-out come back, summarizing after each individual
return means re-reading the accumulated summary-so-far every time a new one
arrives — an N-squared pattern for N sub-agents. Waiting for all of them and
synthesizing once processes the same total input a single time instead.

## Protocol

- Let independent sub-agents finish (or reach a natural review point)
  before synthesizing, rather than folding each result in immediately as it
  lands.
- When all results are in, read each digest once and produce a single
  combined synthesis — don't produce an intermediate summary after every
  individual return.
- If the fan-out is large, group results by theme before synthesizing (e.g.
  digests that agree vs. conflict) rather than merging linearly one at a
  time.
- Only break this and process one result immediately if it blocks or
  changes what the remaining sub-agents should even be doing.

## When not to cut

If an early result reveals the whole fan-out's premise is wrong (e.g. the
task was already done, or the sub-agents were given a bad shared
assumption), act on that immediately instead of waiting for the rest to
return — waiting here just lets the other sub-agents burn tokens on moot
work.
