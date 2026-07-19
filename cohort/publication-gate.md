# Publication gate

The lab studies real people, and its findings will eventually say something about them. This
page fixes, in advance, what "safe to publish" means — a default policy, not a case-by-case
judgment call made under the pressure of an interesting result.

## The policy

- **Quantitative facts** (numbers, correlations, thresholds): published only once observed
  across **n≥5 participants** with the same pattern, or independently replicated by a second
  method. Below that, a number is a hypothesis, not a finding — it stays in the private
  pre-registration file, not here.
- **Qualitative / structural observations** (a method works, a source is missing, a design
  choice held up): published at **n≥3 participants**.
- **Individual data** — anything that describes one specific, identifiable person — is never
  published, regardless of cohort size.
- **Combinations that narrow the field to one person** are refused unconditionally, even if
  every individual fact in the combination would pass the thresholds above on its own.

## Why these numbers

n≥5 for quantitative claims exists because smaller samples make "the effect disappears if you
drop one person" the norm, not the exception — at n=3, removing one participant leaves n=2,
where the direction of an effect is close to a coin flip. n≥3 for qualitative observations is a
lower bar because those claims are falsifiable in a different way (a missing source stays
missing regardless of who reports it) and the cost of being wrong is lower than misreporting a
number about someone.

## Enforcement

This is a default, not a request for permission each time — the check runs automatically in CI
(`lab/publication-gate-check.sh`) and blocks a push or PR that introduces a raw calibration
number or a personal identifier ahead of the thresholds above.

**Override:** only through a written, per-fact exception, signed by the pilot in the commit
history, with the reason stated. No override is silent or blanket.
