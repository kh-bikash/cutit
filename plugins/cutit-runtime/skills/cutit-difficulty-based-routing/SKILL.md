---
name: cutit-difficulty-based-routing
description: Catches the default of running every subtask on the same top-tier model, even the mechanical ones (formatting, extraction, boilerplate scaffolding) that a cheaper model handles just as well. Invoke when a multi-step task contains subtasks whose difficulty clearly varies.
---

# cutit-difficulty-based-routing

Agentic pipelines often fan a task out into steps and run all of them on whatever model started the session. A step like "reformat this JSON" or "pull the five field names out of this schema" costs the same tokens on the strongest model as on the cheapest one, but doesn't need the reasoning the strongest model is priced for.

## Protocol

- Before executing a multi-step plan, tag each step as mechanical (formatting, extraction, boilerplate, simple lookups) or reasoning-heavy (design decisions, ambiguous requirements, multi-file synthesis).
- Route mechanical steps to the cheapest model/agent config capable of them; reserve the strongest model for steps where its reasoning changes the outcome.
- Don't split a single coherent step across models just to save tokens — the coordination overhead (re-stating context to the second model) can exceed the savings.
- When unsure which tier a step needs, default to the stronger model rather than guessing down — a wrong-tier failure costs more (rerun on the expensive model anyway) than routing conservatively.
- Re-evaluate the split if a "mechanical" step keeps failing on the cheap tier — that's a signal it was misclassified, not a signal to retry it forever.

## When not to cut

If the mechanical-looking step actually depends on judgment buried in earlier reasoning (e.g. "format the output" where the format choice was itself the hard part), keep it on the model that did the reasoning — handing it to a cheaper model risks silently dropping that judgment.
