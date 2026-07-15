---
name: cutit-wakeup-scheduling
description: Catches scheduling a fixed, over-frequent check-in cadence regardless of how fast the watched condition actually changes — invoke when setting up any recurring check, loop interval, or scheduled wake-up.
---

# cutit-wakeup-scheduling

A recurring check scheduled tighter than the state it watches can possibly change produces wake-ups that find nothing new every time — each one still costs a full context load and a status pass. This shows up when a default interval ("check every minute") gets reused for something that only changes hourly or daily, instead of being set from the actual rate of change.

## Protocol

- Set the check interval from the watched process's real cadence (a deploy that takes 10 minutes doesn't need a 30-second poll; a daily digest doesn't need an hourly one), not from a copy-pasted default.
- When the cadence is unknown, start wide and tighten only if you observe the state changing faster than expected — don't start tight "just in case."
- If the mechanism supports being woken by an event instead of a timer, prefer that over any fixed interval, however well-tuned.
- Re-evaluate the interval when the situation changes (a task enters a faster-moving phase, or slows to a steady state) rather than leaving the first guess in place for the whole task's lifetime.

## When not to cut

If missing a narrow window matters more than the cost of extra checks (a fast-moving incident, a build step known to fail unpredictably and fast), schedule tighter than the average cadence would suggest — the cost of a missed event exceeds the cost of a few empty checks.
