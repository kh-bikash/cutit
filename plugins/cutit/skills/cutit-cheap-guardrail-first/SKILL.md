---
name: cutit-cheap-guardrail-first
description: Catches sending every output through an expensive model-based safety/quality check when a cheap rule-based check (regex, schema validation, keyword list, length bound) would already catch most violations. Invoke when designing or running a guardrail pipeline that has both rule-based and model-based checks available.
---

# cutit-cheap-guardrail-first

Model-based guardrails (a second LLM call scoring for toxicity, PII, policy violations) cost a full inference pass per item. Most violations that actually occur are structural — an obvious format break, a blocklisted term, an out-of-bounds value — and a rule-based check catches them for a fraction of a token's cost.

## Protocol

- Run the deterministic check first: regex/keyword match, schema/format validation, length or range bound — whatever can be expressed as a rule rather than a judgment call.
- Only route to the model-based guardrail for items the rule-based check passes (or flags as ambiguous) — don't run both on every item unconditionally.
- Keep the rule-based check's coverage list current from what the model-based check actually catches over time — if it keeps flagging the same pattern the rule missed, promote that pattern into the rule.
- Log what the cheap check catches separately from what the expensive check catches, so you can see whether the split is actually saving calls or the expensive check is still doing most of the work.
- Treat a rule-based rejection as final for clear-cut cases (banned term, malformed schema) — don't spend an extra model call re-confirming a violation the rule already proved.

## When not to cut

If the violation class is inherently a judgment call (tone, subtle policy nuance, context-dependent harm) that no rule can reliably express, send it straight to the model-based check — a rule-based gate that can't actually detect that class just adds latency without adding safety.
