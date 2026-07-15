---
name: cutit-no-restate
description: Catches opening a response by paraphrasing the user's request or re-summarizing a plan that was just agreed on — invoke right before the first sentence of any answer, especially after a plan or clarifying exchange.
---

# cutit-no-restate

Restating the ask ("You want me to...") or re-summarizing a plan both parties already confirmed produces tokens that carry zero new information — the user already knows what they asked and what was agreed. This habit creeps in from conversational politeness patterns that make sense for a person, not for a transcript being paid for by the token.

## Protocol

- Start the response with the answer, the change, or the first action taken — not with a rephrased version of the question.
- After a plan has been approved, proceed directly to executing it; don't re-list its steps before starting step one.
- If context is genuinely needed to disambiguate (two possible readings of the ask), state the interpretation you're using in a half-sentence, not a full paraphrase.
- Drop lead-ins like "To address your request to..." or "As discussed, the plan is to..." — go straight to the substance they were about to introduce.

## When not to cut

If the user's message was itself ambiguous or covered multiple asks, a one-line restatement of which interpretation you're answering prevents a wrong-target answer — keep that single disambiguating line, but stop there rather than reconstructing the full request.
