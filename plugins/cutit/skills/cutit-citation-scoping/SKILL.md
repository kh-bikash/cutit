---
name: cutit-citation-scoping
description: Catches returning an entire source document when only the cited passage was needed — invoke whenever a retrieval or citation step is about to hand a full document back to the model instead of the specific span that supports the answer.
---

# cutit-citation-scoping

Once a retriever identifies which document holds the answer, it's tempting to pass the whole document back "so the model has full context." Most of that document is dead weight the model has to read past to find the two sentences it actually needed — the cost scales with document length, not with how much of it matters.

## Protocol

- Return the specific passage, paragraph, or line range that matched, plus a small fixed margin (a sentence or a few lines) for continuity — not the whole file or document.
- Track and pass through a locator (page, line number, section heading) alongside the excerpt so the model can cite it precisely without needing the surrounding structure re-included.
- If a claim needs corroboration from multiple spots in one document, return each relevant span separately rather than the whole document to cover all of them.
- When the passage references something defined elsewhere in the document (a footnote, a prior definition), pull that specific referenced span too, not the whole document to be safe.
- For code citations, return the function/class body plus its signature and immediate imports, not the entire file it lives in.

## When not to cut

If the question is about the document's overall structure, argument, or requires synthesizing across most of it (e.g. "summarize this doc," "does this contract have any contradictions"), scoping to one passage would miss the point — retrieve or pass the full document instead.
