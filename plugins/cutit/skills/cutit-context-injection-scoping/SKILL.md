---
name: cutit-context-injection-scoping
description: Catches serializing an entire object (a full API response, a whole database row, a complete config struct) into context when the agent only needs a few fields from it — invoke when injecting structured data from code into a prompt.
---

# cutit-context-injection-scoping

It's easy to `json.dumps` a whole object into a prompt because it's one line of code, but most objects carry fields the current step has no use for — internal ids, metadata, nested sub-objects unrelated to the task. The model reads and reasons past all of it, and a verbose object repeated across many injected records multiplies the waste.

## Protocol

- Extract and inject only the fields the current step's instructions or the model's next decision actually depends on, not the full object.
- Name the extraction explicitly (a small projection/mapping) rather than passing the object through a generic serializer that dumps everything by default.
- For lists of objects, project each item to its needed fields before injecting the list — the savings compound per row, unlike a single-object case.
- When different steps of a pipeline need different subsets of the same object, scope the projection per step rather than injecting the full object once so it's ready for all downstream steps.
- Flatten deeply nested structures down to the relevant leaf values instead of injecting the nesting wrapper the model has to visually parse to find them.

## When not to cut

If the step's job is to inspect or transform the object's structure itself (schema validation, debugging an unexpected field, "what does this API actually return"), inject the full object — a scoped projection would hide the very thing being examined.
