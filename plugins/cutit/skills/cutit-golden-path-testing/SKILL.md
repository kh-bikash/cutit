---
name: cutit-golden-path-testing
description: Catches the pattern of exhaustively verifying edge cases before confirming the primary path even works, spending tokens on inputs nobody has hit yet while the common case sits unchecked. Invoke when deciding what to verify first after implementing a change.
---

# cutit-golden-path-testing

Edge-case verification is expensive per case and low-probability per case; running it before the main path is confirmed means paying that cost even when the change is broken in the common case, which would have been cheaper to catch first.

## Protocol

- Verify the primary, most-common usage first, with the cheapest check available (one representative input, one smoke run).
- Only move to edge cases once the golden path is confirmed working — a broken main path makes edge-case results moot anyway.
- Prioritize edge cases by realistic likelihood and by how the code actually branches, not by an exhaustive enumeration of every input type theoretically possible.
- Stop adding edge-case checks once you've covered the branches the change actually introduced or touched — untouched code paths don't need re-verification just because they're nearby.
- If the task explicitly concerns an edge case (a bug report about one, a change targeting one), that edge case becomes the golden path for this task — verify it first.

## When not to cut

If the change sits in a domain where edge cases are the actual risk (security boundaries, financial rounding, concurrency), don't stop at the golden path — confirm the main case works, but budget real verification for the edge cases too, since skipping them there is exactly what causes the incidents this pattern exists to avoid elsewhere.
