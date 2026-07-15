---
name: cutit-tool-selection
description: Catches reaching for a broad, general-purpose tool when a narrow one exists — invoke whenever more than one tool could answer the same call, since the broad one both costs more to invoke and returns more to read.
---

# cutit-tool-selection

A general-purpose tool (a shell pipeline, a "search everything" endpoint, a catch-all agent) tends to return unstructured, unbounded output that you then have to read in full to find the part you wanted. A narrow tool built for the specific job returns exactly the shape you need, so both the call and the result stay small.

## Protocol

- Before invoking, ask whether a more specific tool exists for this exact operation (a dedicated search tool over a shell `grep`, a typed API call over a generic HTTP fetch) — prefer it even if it takes one extra lookup to find.
- Prefer tools whose output is structured (JSON, a list of matches) over ones that return prose or raw logs you'd need to parse yourself.
- When two tools return equivalent information, pick the one with the smaller default result size or the one that accepts bounding parameters.
- Don't reach for a multi-purpose "do everything" tool for a single-purpose task just because it's already open or familiar — the narrower tool's smaller surface is the point.
- If no narrow tool exists, say so and fall back deliberately, rather than defaulting to the broad tool by habit.

## When not to cut

If the narrow tool doesn't actually cover the case (e.g. it can't search binary content, or its filters don't support the pattern you need), use the broader tool rather than forcing a narrow one to approximate — a failed narrow call followed by a broad one costs more than just using the broad one correctly the first time.
