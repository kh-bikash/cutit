# Contributing to cutit

## Adding or editing a skill

`plugins/cutit/skills/` is the **canonical source** for every skill in
this project. The six smaller plugins (`cutit-core`, `cutit-agents`,
`cutit-tooling`, `cutit-runtime`, `cutit-quality`, `cutit-domains`) each
hold a *generated copy* of a subset of those skills — don't edit a skill
inside a themed plugin's `skills/` folder directly, your change will be
silently overwritten (or just as bad, silently ignored) the next time
someone runs the sync script.

1. Add or edit a `SKILL.md` (and any `references/` it needs) under
   `plugins/cutit/skills/<skill-name>/`.
2. If it's a new skill that belongs in one of the themed plugins, add its
   name to the matching `sync_group` call in
   [`scripts/sync-plugins.sh`](scripts/sync-plugins.sh).
3. Run the sync script from the repo root:
   ```
   bash scripts/sync-plugins.sh
   ```
   This regenerates every themed plugin's `skills/` folder from the
   canonical source. It's safe to re-run any time — it deletes and
   repopulates each group before copying, so removed skills disappear
   from a group too.
4. Update [SWARM.md](SWARM.md) (the skill index) and, if the token cost
   changed meaningfully, the numbers in [README.md](README.md#install).
5. Follow the house style already established across the 112 skills:
   frontmatter (`name`, `description` with a concrete trigger cue), a
   short context paragraph, a `## Protocol` section with concrete
   actionable bullets, and a `## When not to cut` guardrail specific to
   that skill (not generic boilerplate — describe the actual situation
   where applying the cut would risk correctness).

## Before committing

Run these from the repo root:

```
claude plugin validate .                 # manifests are well-formed
bash scripts/sync-plugins.sh && git diff --exit-code plugins/  # no drift
```

If the second command shows a diff, you edited a generated copy instead
of the canonical source, or forgot to re-run the sync script after a
canonical edit — fix it before committing. CI runs both checks on every
push/PR and will fail the same way.

## Versioning

Each plugin's `plugin.json` carries its own semantic version. Bump the
version(s) of whatever you actually changed, and use
`claude plugin tag --push` to cut a tagged release once your change is
committed (it validates that `plugin.json` and the marketplace entry
agree before tagging). Don't bump every plugin's version for a change
that only touched one.

## What NOT to do

- Don't edit `plugins/<theme>/skills/**` by hand — see above.
- Don't add a skill without a genuine, skill-specific "when not to cut"
  guardrail — that guardrail is the whole point; a skill without one is
  just an unqualified instruction to cut corners.
- Don't inflate skill count for its own sake. A new skill should name a
  token-waste pattern distinct from all 112 existing ones, not a
  rephrasing of one that already exists.
