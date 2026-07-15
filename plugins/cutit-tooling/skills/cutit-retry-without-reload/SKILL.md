---
name: cutit-retry-without-reload
description: Catches re-sending context that already made it into a failed tool call — invoke right after any tool call errors out and before constructing the retry.
---

# cutit-retry-without-reload

When a tool call fails (bad argument, transient error, rate limit), the arguments and any context that produced them are still sitting in the transcript from the failed attempt. Re-reading a file, re-running a search, or re-deriving a value to build the retry duplicates work whose output is already visible a few lines up.

## Protocol

- On a tool error, first re-read the failed call's own arguments and error message before doing anything else — the fix is usually a small correction to what's already there, not a reason to re-derive everything from scratch.
- Fix only the specific field the error complains about (a wrong path, a missing required parameter, a malformed value); leave every other argument as it was.
- Don't re-fetch source data (file contents, search results) that fed into the failed call's arguments unless the error indicates that data itself was stale or wrong.
- For transient failures (timeouts, rate limits), retry the identical call rather than reconstructing it — there's nothing to fix, only to resend.
- If a retry needs one more piece of information the first attempt lacked, fetch only that piece, not the whole context bundle again.

## When not to cut

If the error suggests your understanding of the situation was wrong (e.g. a "file not found" implies the path you derived earlier was based on stale information), re-derive the relevant piece properly rather than patching the call blindly — a second wrong guess costs more than one honest re-check.
