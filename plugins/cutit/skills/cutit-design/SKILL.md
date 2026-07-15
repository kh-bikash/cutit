---
name: cutit-design
description: Catches design-work token waste — reading a whole design system, style guide, or architecture doc to find one token or decision, re-describing a full Figma file or spec instead of its diff. Invoke when doing UI/UX design work (design tokens, components, Figma handoff) or system/architecture design (ADRs, design docs, API/interface contracts).
---

# cutit-design

Design work spans two flavors of the same waste: pulling a whole design
system or style guide into context to find one token's value, and pulling
a whole architecture doc or decision log into context to find one
decision. Both are answerable from a grep and a diff instead of a full
read.

## Protocol

- Grep the token/component name in the design system or style guide instead of reading the whole document to find its value.
- When reviewing a Figma handoff or visual spec, diff the changed frame/component against its prior version, not the whole file.
- Request only the specific token values (a color, a spacing scale, a type ramp entry) that are actually touched, not the full palette/scale dump.
- Look up one ADR or design-doc section by title/heading instead of scanning the whole decision log or doc tree.
- Diff a design or architecture doc against its previous revision when reviewing a change, rather than re-reading it in full.
- Read the specific section of an API/interface contract that changed, not the whole spec, when the design task is interface-level.

## When not to cut

A consistency check — do all buttons use the same token, does this decision contradict an earlier ADR, does this component match the system's spacing scale — is inherently a system-wide question; don't narrow it down to just the one item that prompted the check, or you'll miss the inconsistency you're actually looking for.
