---
name: cutit-response-length-budgeting
description: Catches defaulting to a maximally thorough, multi-section answer regardless of how big the question actually is — invoke before drafting any response, to size it to the question first.
---

# cutit-response-length-budgeting

Left unconstrained, an agent tends to answer every question at the same elaborate register — headers, caveats, multiple examples — because that register is never wrong, just often unnecessary. A one-line question answered with five paragraphs spends tokens on structure the question never asked for.

## Protocol

- Before drafting, size the answer to the question: a factual lookup gets a sentence, a yes/no gets a sentence with the reason, a design decision gets paragraphs — pick the tier before you start writing, not after.
- Don't add sections (Overview, Details, Next Steps, Summary) unless the content actually splits into that many distinct ideas; one idea gets one paragraph, not a scaffold built for five.
- Skip caveats and edge-case disclaimers the user didn't ask about and isn't at risk from — mention a caveat only if it changes what the user should do next.
- If a fuller answer might be wanted, offer to expand rather than pre-emptively writing the expanded version every time.

## When not to cut

If the request is inherently multi-part (compare these options, walk me through this design, explain the tradeoffs), a short answer would drop information the user explicitly asked for — size the budget to match what was actually asked, not to a fixed short default.
