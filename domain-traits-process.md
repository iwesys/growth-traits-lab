# Choosing or designing characteristics for a specific craft

Some characteristics matter no matter what someone is working on — clarity of thinking,
initiative, regularity. Others only make sense inside a specific craft: what moves someone
forward in swimming isn't what moves someone forward in game theory. This page is the process
for the second kind — how to go from "here's a craft with no existing standard" to a validated,
trackable set of characteristics for it.

## Three groups, not one list

1. **General** — apply to every craft without modification. Already covered by the general
   catalog (clarity, initiative, regularity, focus, and similar).
2. **Threshold** — the minimum needed to practice the craft at all, but practicing more doesn't
   grow them much further once past the minimum.
3. **Growth-through-practice** — specific to the craft, and genuinely move as someone practices
   it (depth of understanding, reliability of application, ability to teach it to someone else).

A rare fourth case: a group-3 characteristic turns out to be useful across several unrelated
crafts. That's a candidate for promotion into group 1 — but only on a high evidence bar (the
same rung discipline as everywhere else in this lab), because it's easy to mistake coincidence
for real transfer.

## The procedure

**Step 0 — Trigger.** The process starts when someone names a specific craft and asks for its
characteristic set — it isn't run speculatively for crafts nobody has asked about yet.

**Step 1 — Check general coverage.** Confirm which group-1 characteristics already apply to
this craft without change. No new work needed for those.

**Step 2 — Gather candidates for groups 2–3.** Look for an existing external standard for the
craft first (a grading system, a certification ladder, a professional standard) — use that as
the source of candidates. If none exists, fall back to expert knowledge or direct
self-experimentation in the craft.

**Step 3 — Run the six-point checklist** (see `methodology/six-point-checklist.md`) on every
candidate: indicator, method, convergent check, discriminant check, resistance to gaming,
evidence rung. A candidate that doesn't clear all six stays dormant — not activated, not used
in any recommendation — until it does.

**Step 4 — One number or several axes?** Decide per craft, not once for all crafts. Some crafts
compress well into a single score; others genuinely need independent axes that don't reduce to
one number without losing information. This is decided fresh for each craft.

**Step 5 — Level semantics: no universal ladder.** Don't invent one scale that's supposed to fit
every craft. Instead:

1. Look for existing standard(s) for skill levels in this craft — there may be more than one
   competing standard (different federations, different certification bodies).
2. Present the found options to the person choosing, as an explicit list — don't silently pick
   one.
3. **Personalization, where data allows it:** if there's already data about this specific
   person (telemetry, practice history, self-report), suggest which of the found standards fits
   them best — not just a neutral list. Where no such history exists, this step degenerates to
   the neutral list from step 2.
4. Record which standard was chosen alongside the level value itself — if more than one
   standard exists, a level number alone is ambiguous without knowing which ladder it's on.

**Step 6 — Record.** Characteristics that clear step 3 get recorded with: which craft, which
level-standard (if any) from step 5, and an explicit rung marking — as a hypothesis (rung 1),
not a settled fact.

**Step 7 — Rare promotion to group 1.** If a group-3 characteristic shows convergent usefulness
across two or more crafts, it's a candidate for promotion — again, only on a high evidence bar.
This is not a routine mechanism.

**Step 8 — Hand off.** The output for any consumer of this process is the same shape:
`{characteristic, craft, checklist verdict, rung}`.

## What this process does not decide

- Where the resulting data physically lives. That's an ownership question, not a process
  question — see "Where the data lives" below.
- Independent design critique of this process itself, if one hasn't been run yet.

## A pilot run across three real crafts

This process was piloted end-to-end on three genuinely different crafts: swimming, piano, and
short-form video (the "yap" style common on platforms like TikTok). The point of choosing three
very different crafts was to stress-test whether "one process, three domains" actually holds —
not to produce results for any one of them.

**What the pilot run found:**

- **Swimming and piano** both have multiple existing, competing standards for skill level (found
  directly, not assumed) — exactly the case where step 5 asks the person to choose rather than
  inventing a new scale.
- **Short-form video** has **no formal level scale at all** (verified, not assumed) — confirming
  that a universal ladder across all crafts would have been the wrong design. This craft tracks
  progress through platform metrics instead (retention, completion rate, share rate).
- In all three crafts, the six-point checklist genuinely separated candidates: some passed every
  point confidently (stroke efficiency from wearable data, repertoire difficulty against a
  published grading catalog, the strength of a video's first three seconds), others stayed
  hypothesis-only because no validated way to measure them exists yet (e.g. "authenticity" in
  video, "musicality" in piano playing, "comfort in water" in swimming). That split is expected,
  not a failure of the process — the honest label is what matters.

**Standard chosen per craft** (criterion: simplicity for a hobbyist beginner, not competitive
precision):

- **Swimming → a four-stage adult learn-to-swim award ladder**, named stages rather than numeric
  scores or distance/time tables — chosen over more competition-oriented standards that assume
  the learner is training for events.
- **Piano → an eight-grade system**, a single numeric progression that's broadly recognizable
  even to non-musicians — chosen over systems requiring a separate mandatory theory track.
- **Short-form video → no level scale**, because none exists; progress tracked through the
  platform's own engagement metrics instead.

## Where the data lives — a decision this lab got wrong once, then corrected

The first attempt at this pilot wrote craft-specific characteristics directly into the shared
platform registry that also holds the general (cross-craft) catalog. That was technically fine
but architecturally wrong: it reused a pattern meant for solving *catalog fragmentation* to
answer a *different* question — should a craft-specific catalog live on the shared platform at
all?

**The correction:** the platform's shared registry holds only the general, cross-craft
characteristics — because those are the only ones any collective, authoritative body evaluates
and certifies. Craft-specific mastery (swimming technique, piano playing, anything else someone
picks up) is chosen and tracked by that person individually — the platform has no need to know
about stroke efficiency specifically.

The correction was applied cleanly: the craft-specific data from the pilot was removed from the
shared registry and moved into personal, individually-owned files instead — the general
principle being that a shared registry only holds what a shared authority actually needs to
evaluate.

**The lesson, stated plainly:** deciding "should this be one catalog or eight" is a different
question from "should this catalog exist on the shared platform at all" — getting the first
question right doesn't mean the second one was even asked.
