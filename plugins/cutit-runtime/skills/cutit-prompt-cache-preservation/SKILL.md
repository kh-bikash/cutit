---
name: cutit-prompt-cache-preservation
description: Catches an edit to a prompt's stable prefix (system instructions, fixed context) that silently invalidates a warm prompt cache for every call after it. Invoke before editing anything earlier in an assembled prompt than the newest per-call content.
---

# cutit-prompt-cache-preservation

Prompt caching only pays off if the cached prefix stays byte-identical across calls — one edit anywhere in it, even a whitespace change, invalidates the cache from that point forward and every subsequent call re-pays full price for that prefix. This is easy to trigger by accident when "just tidying" shared instructions that are actually load-bearing for cache hits.

## Protocol

- Keep stable content (system prompt, fixed few-shot examples, unchanging context) strictly separated from volatile per-call content, and always append volatile content after the stable prefix, never interleaved.
- Treat the cached prefix as append-only during a session: add new stable material at the end of the stable block if needed, rather than editing text in the middle of it.
- Before editing anything in the stable prefix, ask whether the edit is actually necessary now, or could wait until a natural cache-refresh point (a new session, a version bump) — a cosmetic fix mid-session pays the full re-cache cost immediately.
- When a prefix edit is genuinely necessary (a correctness bug in the instructions), make it once, deliberately, and expect/accept the one-time cache miss rather than making several small edits that each cost a fresh miss.
- If unsure whether content belongs in the cached prefix or the volatile suffix, default to volatile — the cost of not caching one piece of content is smaller than the cost of invalidating the whole cached prefix repeatedly.

## When not to cut

If the stable prefix contains an actual error affecting correctness (wrong instruction, stale fact), fix it immediately regardless of cache cost — a warm cache serving a wrong prompt is not a saving, it's the same mistake repeated cheaply.
