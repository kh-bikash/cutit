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
**six plugins** so you can install everything or just the slice you need:

```
/plugin marketplace add kh-bikash/cutit
/plugin install <plugin-name>@cutit-marketplace
```

| Plugin | Skills | Always-on cost* | What it's for |
|---|---|---|---|
| `cutit` | 112 (all of them) | ~10,220 tok | The whole swarm in one shot |
| `cutit-agents` | 24 | ~2,589 tok | Building/orchestrating agent workflows: planning, sub-agent delegation, multi-agent pipelines |
| `cutit-tooling` | 22 | ~1,874 tok | Tool use, retrieval/RAG, prompt construction |
| `cutit-runtime` | 42 | ~3,815 tok | Operating long-running agents: context/memory budgeting, sessions, error recovery, caching, state, model routing, search |
| `cutit-quality` | 20 | ~1,859 tok | Correctness/output discipline: verification, human-in-the-loop, eval/guardrails, response-length |
| `cutit-domains` | 3 | ~340 tok | Frontend, backend, design work |

*All six numbers measured directly with `claude plugin details
<plugin>@cutit-marketplace` on this build, not estimated.

Pick `cutit` if you want it all with the least setup. Pick one or more of
the other five if you know which part of your work this needs to help
with — they compose freely (install `cutit-agents` + `cutit-tooling`
together, for instance, without pulling in `cutit-runtime` too). A local
folder works the same way as the GitHub form —
`/plugin marketplace add /path/to/cutit` — if you're testing a clone or a
fork before it's pushed.

Once installed, every skill is available automatically (Claude Code
invokes them when relevant) and can also be called explicitly, namespaced
under whichever plugin it came from: `/cutit:cutit`,
`/cutit-domains:cutit-frontend`, `/cutit-agents:cutit-parallel-delegation`,
etc.

**Still want finer than plugin-level granularity?** All six plugins pull
their skill content from one canonical source,
`plugins/cutit/skills/<name>/`. Skip installing any plugin and copy just
the folders you want from there into your own `.claude/skills/<name>/`
(project-level) or `~/.claude/skills/<name>/` (global) — see
[SWARM.md](SWARM.md) for the full list to choose from.

**Maintainer note:** the five themed plugins (`cutit-agents`,
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
