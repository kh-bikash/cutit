# Eval harness — blocked on early access

This project's core claim — cutting token usage without cutting result
quality — is currently backed only by each skill's own reasoning (the
"when not to cut" guardrails), not by measured evidence. `claude plugin
eval` is built for exactly this: it runs cases against a plugin with a
`--ablation with-without` mode that adds a no-plugin baseline arm and
reports the score delta, which would let us show, e.g., "installing
`cutit-core` holds task success steady while cutting N% of tokens" with
real numbers instead of an assertion.

**Status: blocked, not skipped.** On this account, both
`claude plugin eval init <name>` and `claude plugin eval init <name>
--bare` fail immediately with `plugin eval is currently in early access`.
It isn't documented publicly yet (checked the Claude Code and Claude API
docs directly), and the CLI gives no local flag to unlock it — it's an
account/plan-level entitlement, not a settings toggle.

We deliberately did **not** write `case.yaml` or `prompt.md`/`graders/*.md`
files against a guessed schema. The CLI help documents the two supported
file layouts and several flags (`--ablation`, `--case`, `--tag`,
`--judge-model`, `--runs`, `--scaffold`, `--threshold`), but not the exact
field names/types inside those files — writing to a guessed schema risks
cases that silently fail validation (or worse, silently no-op) once early
access opens up, which would be worse than having nothing.

## To unblock

Get `plugin eval` enabled on the Anthropic account this repo is developed
under, then:

1. Run `claude plugin eval init cutit-core` (the interactive interview,
   not `--bare`) to get a real, valid scaffold to work from.
2. Write a handful of cases per plugin comparing task outcomes with vs.
   without the plugin installed (`--ablation with-without` is the default
   for a plugin target), covering both "does it still get the task right"
   and "does it actually use fewer tokens."
3. Wire `claude plugin eval <plugin>@cutit-marketplace --json --threshold
   <n>` into `.github/workflows/ci.yml` as a new job, so a future skill
   change that breaks quality or stops saving tokens fails CI instead of
   shipping silently.
