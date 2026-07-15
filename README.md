# cutit

A swarm of Claude Code skills that cut token usage on agentic work without
cutting result quality. Every skill trades a cheap step (grep before read,
edit before rewrite, cap before dump, resume before respawn) for an
expensive one — none of them trade away correctness. Each skill carries its
own "when not to cut" guardrail for exactly that reason.

The swarm has three layers, all bundled in one installable plugin (see
[Install](#install) below):

- **[`cutit`](plugins/cutit/skills/cutit/SKILL.md)** — the core skill: a broad protocol
  covering the highest-value cuts (narrow reads, cheap search, capped tool
  output, edit-not-rewrite, lazy tool schemas, cache-aware prompting,
  model routing, terse narration) with a `references/` pair
  ([checklist](plugins/cutit/skills/cutit/references/checklist.md),
  [techniques](plugins/cutit/skills/cutit/references/techniques.md)) for pre-flight checks and
  rationale.
- **108 `cutit-<pattern>` skills** — narrow, single-file skills, one per
  specific agentic-workflow pattern (planning, sub-agent delegation,
  tool-schema management, context/memory budgeting, verification,
  multi-agent pipelines, RAG, prompt construction, output discipline,
  session management, error recovery, caching, search strategy, state
  tracking, model routing, human-in-the-loop, eval/guardrails). Full index
  in [SWARM.md](SWARM.md).
- **3 `cutit-<domain>` skills** — broader, role-shaped variants for the
  three pillars of building a product:
  [`cutit-frontend`](plugins/cutit/skills/cutit-frontend/SKILL.md) (source over bundles, capped
  devtool logs, targeted screenshots),
  [`cutit-backend`](plugins/cutit/skills/cutit-backend/SKILL.md) (bounded queries, diffed
  migrations, capped stack traces), and
  [`cutit-design`](plugins/cutit/skills/cutit-design/SKILL.md) (grep-then-diff for design
  systems, Figma specs, ADRs, and architecture docs).

## Install

This repo is a Claude Code **plugin marketplace**
(`.claude-plugin/marketplace.json` at the root), live at
[github.com/kh-bikash/cutit](https://github.com/kh-bikash/cutit), hosting
**seven plugins** so you can install exactly as much as you want.

**Just want less token usage, nothing specialized?**

```
/plugin marketplace add kh-bikash/cutit
/plugin install cutit-core@cutit-marketplace
```

That's it — `cutit-core` is one general-purpose skill (narrow reads,
cheap search, capped tool output, edit-not-rewrite, cache-aware prompting)
at **~167 tokens always-on**, the cheapest possible entry point into this
whole project. Everything else below is for people who know they want a
specific specialization on top of that.

| Plugin | Skills | Always-on cost* | What it's for |
|---|---|---|---|
| `cutit-core` | 1 | **~167 tok** | Just the general token-reduction habit — start here |
| `cutit` | 112 (all of them) | ~10,220 tok | `cutit-core` plus every specialization below, in one shot |
| `cutit-agents` | 24 | ~2,589 tok | Building/orchestrating agent workflows: planning, sub-agent delegation, multi-agent pipelines |
| `cutit-tooling` | 22 | ~1,874 tok | Tool use, retrieval/RAG, prompt construction |
| `cutit-runtime` | 42 | ~3,815 tok | Operating long-running agents: context/memory budgeting, sessions, error recovery, caching, state, model routing, search |
| `cutit-quality` | 20 | ~1,859 tok | Correctness/output discipline: verification, human-in-the-loop, eval/guardrails, response-length |
| `cutit-domains` | 3 | ~340 tok | Frontend, backend, design work |

*All seven numbers measured directly with `claude plugin details
<plugin>@cutit-marketplace` on this build, not estimated.

Pick `cutit-core` alone if general token reduction is the whole ask. Add
one of the themed plugins on top of it if you also want a specific
specialization (`cutit-core` + `cutit-domains` is a common combo, for
instance). Pick `cutit` instead of stacking plugins if you want everything
with the least setup and don't mind the larger fixed cost. A local folder
works the same way as the GitHub form —
`/plugin marketplace add /path/to/cutit` — if you're testing a clone or a
fork before it's pushed.

Once installed, every skill is available automatically (Claude Code
invokes them when relevant) and can also be called explicitly, namespaced
under whichever plugin it came from: `/cutit:cutit`,
`/cutit-domains:cutit-frontend`, `/cutit-agents:cutit-parallel-delegation`,
etc.

**Still want finer than plugin-level granularity?** All seven plugins pull
their skill content from one canonical source,
`plugins/cutit/skills/<name>/`. Skip installing any plugin and copy just
the folders you want from there into your own `.claude/skills/<name>/`
(project-level) or `~/.claude/skills/<name>/` (global) — see
[SWARM.md](SWARM.md) for the full list to choose from.

**Maintainer note:** the six smaller plugins (`cutit-core`, `cutit-agents`,
`cutit-tooling`, `cutit-runtime`, `cutit-quality`, `cutit-domains`) are
generated, not hand-edited — `plugins/cutit/skills/` is the source of
truth. After changing a skill there, run `scripts/sync-plugins.sh` to
propagate it into whichever themed plugin bundles it, before committing.

## Why this works

Agentic sessions spend tokens in three places: what gets read in, what
tools hand back, and what gets written out — including everything a
sub-agent has to re-derive from scratch because it started cold, or a
pipeline stage re-explains to the next one. The swarm targets all three
without touching how carefully the actual task gets done: every file ends
with a guardrail describing exactly when applying its cut would risk
correctness, and defers to spending the tokens in that case.
