---
name: cutit-known-location-shortcuts
description: Catches searching for something that has a well-known conventional location instead of going straight there — config files, migration folders, entry points, CI definitions. Invoke when the target is a project-convention artifact rather than arbitrary user code.
---

# cutit-known-location-shortcuts

Ecosystems standardize where things live — `package.json`, `.env.example`, `migrations/`, `.github/workflows/`, a framework's routes file — so searching for these by keyword re-derives a location that's already implied by the tech stack.

## Protocol

- Before searching, ask whether the target is a conventional artifact for this stack/framework, and if so, Read/Glob that path directly instead of grepping for it.
- Confirm the convention holds for this specific project with a single Glob (e.g. `migrations/**`) rather than assuming blindly — one cheap check beats a wrong guess.
- If the conventional path doesn't exist, that miss is the signal to fall back to a real search — not a reason to have searched broadly from the start.
- Keep a mental (or noted) list of the conventions for the stack you're in per session so you don't re-derive them each time within the same task.

## When not to cut

If the project has been customized away from the framework default (a moved config, a monorepo with multiple candidates), verify with a quick listing before committing to the conventional path — a wrong guess here wastes more than the search would have.
