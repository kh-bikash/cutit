---
name: cutit-structured-output
description: Catches generating flowing prose when the caller (a tool, a script, another agent) only ever consumes specific fields — invoke before writing a response that will be parsed, filtered, or forwarded rather than read as narrative.
---

# cutit-structured-output

When the consumer of your output is code or another agent rather than a person reading along, every sentence of connective prose is generation cost with no reader to justify it. Agentic loops default to writing answers the way you'd explain them to a colleague even when nothing downstream reads sentences — it just parses a value.

## Protocol

- Before answering, ask who reads this next: a human in the chat, or a parser/grep/another agent step. If it's the latter, emit the minimal structured form (a list, a table, a JSON blob, a single value) instead of prose.
- Match the shape to the question: yes/no gets a word, a lookup gets a value, a comparison gets a short table — don't wrap any of them in explanatory sentences unless asked why.
- When a plan or task tool exists for structured state, write status into it directly rather than describing status in prose first and then also recording it.
- Drop transitional phrasing ("Now let's look at...", "Great, next I'll...") entirely in structured responses — it serves a reader, not a parser.

## When not to cut

If the same response is also the one place a human will check the reasoning (a decision that needs justification, a result the user must trust without re-deriving it themselves), keep enough prose to explain the "why," not just the "what" — a bare value with no rationale forces the human to re-derive it, which costs more than the words saved.
