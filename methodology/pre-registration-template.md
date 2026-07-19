# Pre-registration template

Fill this in and commit it *before* running any query against cohort data. The commit that adds
this file is the fixation point — analysis starts after it, not before. Anything found that
wasn't specified here gets reported separately, labeled exploratory, never folded into the
pre-registered result.

```markdown
---
date: YYYY-MM-DD
status: fixed
fixation: "commit of this file = the moment analysis is allowed to start"
---

# Pre-registration — <short title>

## Sample and period

- Subjects: <who, how many, rung-1 requires stating N explicitly>
- Data source: <which system, read-only access, what tables/events>
- Period: <start> — <fixation date>. State the honesty constraint: how wide are the
  confidence intervals at this sample size, and will the report show them.

## Hypotheses

| # | What's being measured | Decision metric |
|---|------------------------|------------------|
| H1 | <plain statement> | <correlation / delta / comparison, with the exact decision rule for "insufficient data"> |

## Out of scope for this iteration

<What is explicitly deferred, so a later report doesn't retroactively expand this one's scope.>

## Analyst's commitment

The first query against data runs only after this file is committed. Anything beyond what's
listed above is labeled exploratory in the report, never treated as a confirmed finding.
```
