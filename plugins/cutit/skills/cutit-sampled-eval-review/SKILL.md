---
name: cutit-sampled-eval-review
description: Catches reading every failing transcript in an eval run when a representative sample would surface the same failure modes at a fraction of the tokens. Invoke when an eval run produces more failing cases than are needed to identify distinct failure patterns.
---

# cutit-sampled-eval-review

Eval failures cluster into a handful of root causes; reading all fifty transcripts to find three distinct bugs pays for forty-seven redundant confirmations of bugs already found. The tokens go into re-reading the same failure shape, not into new information.

## Protocol

- Pull the failing set and skim just enough of each (error message, final assistant turn, diff from expected) to bucket it into a failure-mode category, rather than reading full transcripts up front.
- Once a category has a couple of confirmed examples, stop reading more of that category — read a fresh sample only from categories not yet represented.
- Read one or two full transcripts per distinct category to understand root cause in depth; skip full reads for the rest of that category.
- If categories are lopsided (one bug causing 40 of 50 failures), weight your sampling toward the categories you haven't seen yet, not proportionally to how common each is.
- Report findings as "N failures, categories X/Y/Z with counts" rather than transcribing every case back into the summary.

## When not to cut

If failure counts are small enough that reading all of them costs about the same as sampling (under ~10), or the eval is a release gate where an unrepresented failure mode could ship a real bug, read the full set — sampling only pays off when there's genuine redundancy to skip.
