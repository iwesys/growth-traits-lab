# CI inventory

Names of secrets and variables this repository's CI expects — names only, never values.

| Name | Kind | Used by | Purpose |
|------|------|---------|---------|
| `GITHUB_TOKEN` | secret (auto-provided) | `.github/workflows/publication-gate.yml` | checkout access, provided automatically by GitHub Actions |

No other secrets are required for the `publication-gate` workflow — it runs entirely against
the local git diff and needs no external credentials.

This repository's content (everything except `.github/workflows/publication-gate.yml` itself)
is published automatically from the private source repository whenever the maintained English
copy changes there. That publishing pipeline's own secrets (`CANON_SYNC_APP_ID`,
`CANON_SYNC_APP_KEY`) live on the source side, not here — this repo only receives commits
authored by `canon-sync[bot]`.

The `lab/` scripts (`db_url.sh`, `extract.sh`) require `NEON_PROJECT_ID`, `NEON_BRANCH_ID`, and
`NEON_API_KEY` to run against a real database, but these are never set in this repository's CI —
they're only used locally, by whoever is running an actual calibration pass, and are not
committed anywhere in this repo (see `lab/db_url.sh` for the exact variables expected).
