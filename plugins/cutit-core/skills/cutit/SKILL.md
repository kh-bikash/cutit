---
name: cutit
description: Apply a token-efficiency protocol to agentic coding work — narrow before reading, delegate open-ended search, cap tool output, edit instead of rewrite — so the same task finishes on fewer tokens with no drop in correctness. Invoke at the start of any non-trivial coding task, or explicitly via /cutit. Load references/checklist.md before a large read/search/write when unsure if it's warranted; load references/techniques.md for the rationale behind a rule.
---

# cutit

Every rule below trades a cheap step (a grep, a narrower read, a delegated
search) for an expensive one (dumping a whole file, re-deriving context,
paginating through logs). None of them trade away correctness — if a
cut would risk giving the user a wrong or incomplete answer, don't make it.
Spending the tokens once beats getting it wrong and paying for a redo.

## Protocol

**Read narrow, not wide.**
Grep/Glob for the symbol or file first; only read the lines you need. Use
`offset`/`limit` on large files instead of reading them whole. Never re-read
a file you just read or edited in this session — you already have it.

**Search with the cheapest tool that will work.**
A targeted Grep/Glob beats a shell `find`/`grep`/`cat` pipeline (dedicated
tools return structured, boundable results). Reserve open-ended,
multi-file research ("how does auth flow through this repo") for a
delegated search — one round trip back instead of dozens of exploratory
reads in the main thread.

**Don't spawn what you can just do.**
A sub-agent starts cold and re-derives context you already hold — that
re-derivation is pure token cost. Delegate only when the task is genuinely
open-ended, parallelizable, or would otherwise flood your own context with
exploration you don't need to keep. Never delegate a task whose context
you already have loaded.

**Cap everything that comes back.**
Bound search results (`head_limit`, targeted globs) and file reads
(`offset`/`limit`) instead of pulling entire result sets or files into
context "to be safe." Summarize logs/diffs instead of pasting them back
into the transcript when the user only needs the outcome.

**Edit, don't rewrite.**
Use a diff-based edit for existing files; it sends only the change.
Reserve a full-file write for new files or genuine full rewrites.

**Track state instead of writing it back into context.**
Use structured task tracking for multi-step plans instead of an
intermediate planning doc you'll read back in later — the read-back is the
token cost, not the writing.

**Load tool/schema detail lazily.**
If your environment supports deferred/on-demand tool schemas, only pull in
the schema for a tool you're about to call, not every tool that might be
relevant.

**Structure prompts for cache hits.**
If you're building the prompt yourself (an agent, an app on top of an
API): put stable instructions first and volatile, per-call content last.
Don't edit the stable prefix if you don't have to — every edit invalidates
the cache from that point forward.

**Route by difficulty.**
For mechanical, low-reasoning subtasks (formatting, extraction, boilerplate),
use the cheapest model that gets it right. Reserve the strongest model for
steps that actually need its reasoning. Right-sizing the model is a token
cut with no quality cost when the subtask doesn't need the bigger model.

**Say less, don't know less.**
Terser narration and shorter summaries save tokens too. Cutting words in
your own output is free; cutting the investigation behind them is not —
never shorten the work itself to shorten the write-up.

## When not to cut

- The user asked to see the full file/diff/log — show it.
- A narrower read would risk missing the actual bug (e.g. a fix that
  depends on code above the matched line) — read enough to be sure, not
  the minimum that looks plausible.
- The task is genuinely ambiguous — asking one clarifying question costs
  less than confidently doing the wrong task twice.

See [references/checklist.md](references/checklist.md) for a pre-flight
gut-check before a big read/search/write, and
[references/techniques.md](references/techniques.md) for the reasoning and
before/after examples behind each rule above.
