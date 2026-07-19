# CI inventory

Names of secrets and variables this repository's CI expects — names only, never values.

| Name | Kind | Used by | Purpose |
|------|------|---------|---------|
| `GITHUB_TOKEN` | secret (auto-provided) | `.github/workflows/publication-gate.yml` | checkout access, provided automatically by GitHub Actions |

No other secrets are required for the `publication-gate` workflow — it runs entirely against
the local git diff and needs no external credentials.

The `lab/` scripts (`db_url.sh`, `extract.sh`) require `NEON_PROJECT_ID`, `NEON_BRANCH_ID`, and
`NEON_API_KEY` to run against a real database, but these are never set in this repository's CI —
they're only used locally, by whoever is running an actual calibration pass, and are not
committed anywhere in this repo (see `lab/db_url.sh` for the exact variables expected).
