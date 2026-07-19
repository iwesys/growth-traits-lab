# Cohort protocol

How a candidate joins the study, and what happens once they do. This is the public version of
the protocol — the private version additionally tracks who's actually in the cohort right now,
which stays private by design (see `publication-gate.md`).

## 1. Enrollment — a strict order, no skipping steps

1. **Consent** — explicit opt-in, no exceptions. This is the GDPR-minimum floor, not a
   suggestion.
2. **Pipeline dry-run** — before enrollment, the candidate's data sources are audited against
   synthetic events. If the candidate's craft needs a signal the lab doesn't already track
   (a new sensor, a new kind of self-report), that source gets registered and tested *before*
   enrollment, not discovered mid-study. A dry-run that fails blocks enrollment until the source
   is fixed — the pipeline isn't debugged live against a real participant's real data.
3. **Enrollment** — only after both of the above pass.

**Staggering start dates** across candidates is optional, not default. It's used only when the
dry-run surfaces a problem that can't be fixed quickly, or when the person joining specifically
wants a spread-out start for their own attention/workload reasons.

## 2. Run-in period (4 weeks, starts at enrollment)

Starting the clock at enrollment (not earlier) matters: starting earlier would bias the sample
toward people who were already engaged before they formally joined.

**Passing criteria (both required):**
- **Completeness:** at least 3 of the 4 weeks show sufficient daily activity and at least one
  weekly check-in per week.
- **Stability:** the coefficient of variation of the candidate's core tracked metric within the
  window stays within a bounded range.

Not passing → either extend the run-in (not restart from zero) or mark the candidate "not ready"
— continuing or stopping from there is a judgment call, not automatic.

The dry-run (step 1.2) and the run-in are different gates and don't substitute for each other:
the dry-run checks whether the pipeline works; the run-in checks whether the candidate's actual
behavior (do they log consistently, do they wear the sensor, do they update the tracked artifact)
holds up over real time.

## 3. Metrics — two tracks

**Track A (confirmatory, closed):** the pre-registered hypotheses, unchanged, run independently
per candidate — replicating the original rung-1 findings on a new subject.

**Track B (exploratory, explicitly labeled):** anything craft-specific and new for this
candidate. Exploratory findings never get folded into Track A's confirmed results, and never
skip the six-point checklist (`methodology/six-point-checklist.md`) before being treated as an
actual tracked characteristic.

## 4. Main observation period

After run-in, observation continues to the same weekly-point threshold used for the lab's first
iteration — more candidates in the cohort doesn't lower the bar for any individual one; sample
size and per-candidate observation depth are different axes.

**Analysis stays separate per candidate** for the whole period. Findings aren't pooled across
candidates until each one has completed their own confirmatory run — pooling too early risks
treating within-person noise as a between-person effect.

## What this protocol deliberately leaves open

- Who specifically joins the cohort — a decision made by the pilot personally, outside the scope
  of this protocol.
- Registering genuinely new data sources for a new candidate's craft — a technical task handled
  case by case, not decided here.
