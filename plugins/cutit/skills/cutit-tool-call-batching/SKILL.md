---
name: cutit-tool-call-batching
description: Catches issuing independent tool calls one at a time across separate turns, each round-trip re-stating the same surrounding context — invoke whenever you're about to make a tool call and can already see the next one coming.
---

# cutit-tool-call-batching

Every serial round trip re-sends the model's reasoning about what to do next, and the harness re-sends the accumulating transcript alongside it — costs that don't exist if the calls are issued together. Splitting three independent lookups into three turns triples that overhead for zero added information.

## Protocol

- Before issuing a tool call, check whether the next one or two calls are already fully determined (don't depend on this call's result) — if so, issue them in the same turn.
- Batch reads of multiple known files, multiple independent greps, or multiple independent lookups (status + diff + log) into one multi-call turn instead of sequencing them.
- Keep calls in one turn only while they're truly independent; the moment call B needs call A's output, split them — batching a dependent call just means guessing its arguments.
- When a user asks for several unrelated pieces of information ("check X and also Y"), resolve both in parallel rather than treating them as a sequential checklist.
- Don't over-batch into a single giant turn when some calls are conditional on earlier ones in the same batch — that reintroduces the dependency problem batching is meant to avoid.

## When not to cut

If a later call's parameters depend on an earlier call's result (a file path discovered by a search, an ID returned from a lookup), don't guess and batch — issue the dependent call after you have the real value, even though that costs a round trip.
