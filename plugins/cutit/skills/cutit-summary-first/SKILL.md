---
name: cutit-summary-first
description: Catches building up to an answer through a walkthrough of the investigation before stating the conclusion — invoke before structuring any response that has a clear bottom line.
---

# cutit-summary-first

Narrating a search chronologically — "First I checked X, then Y, which led to Z" — before finally landing on the answer forces the reader through the whole path to get what they wanted from the first line. In an agentic loop this pattern also tends to re-derive and restate intermediate steps that don't change the final answer, padding the response with process the user didn't ask to see.

## Protocol

- Put the conclusion, the fix, or the direct answer in the first sentence or two, every time — the investigation trail is supporting detail, not the headline.
- Only include the reasoning steps that the user needs to trust or act on the conclusion; drop dead ends and false starts that didn't contribute to the final answer.
- If more detail seems useful, add it after the summary as an optional expansion, not before it as a prerequisite the reader must wade through.
- For multi-part answers, lead each part with its own conclusion rather than saving the payoff for the end of a long paragraph.

## When not to cut

If the process itself is what was asked for (the user wants to see how you debugged it, or the investigation reveals something they need to know before trusting the conclusion), keep the walkthrough — but still open with the bottom line, then follow with the path that got you there.
