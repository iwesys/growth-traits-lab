#!/usr/bin/env bash
# Technical enforcement of the publication-gate policy (see cohort/publication-gate.md).
# Blocks a commit/push that introduces raw calibration numbers or personal identifiers
# before the cohort is large enough to publish them safely.
#
# Scope: text diff against the previous commit. Not a substitute for human review —
# a narrow, fast tripwire for the two failure modes that matter most: a stray number,
# a stray name.
#
# Usage: lab/publication-gate-check.sh [<base-ref>]   (default base-ref: HEAD~1)

set -euo pipefail

# Methodology/policy files are allowed to discuss thresholds and worked examples
# in prose (e.g. "at n=3, removing one participant leaves n=2") — they describe
# the gate, they aren't cohort data the gate protects. Only exclude files that
# talk *about* the policy, never a real findings/report file.
POLICY_EXCLUDES=(
    ':(exclude)lab/publication-gate-check.sh'
    ':(exclude)cohort/publication-gate.md'
    ':(exclude)methodology/discipline.md'
    ':(exclude)methodology/six-point-checklist.md'
    ':(exclude)methodology/pre-registration-template.md'
)

BASE_REF="${1:-HEAD~1}"
echo "[publication-gate] checking diff against $BASE_REF..."
DIFF=$(git diff "$BASE_REF" -- . "${POLICY_EXCLUDES[@]}")

fail=0

# 1. Raw calibration thresholds / numeric findings: a bare decimal next to a known
#    characteristic-index name, the shape numbers take once calibration produces them.
if echo "$DIFF" | grep -E '^\+' | grep -qiE '(clarity|agency|composure|regularity|production_capacity|resourcefulness|stress_resilience)[_a-z]*[[:space:]]*[:=][[:space:]]*[0-9]'; then
    echo "publication-gate: found a calibration index paired with a raw number in the diff." >&2
    echo "  → n>=5 (quantitative) / n>=3 (qualitative) required first, see cohort/publication-gate.md" >&2
    fail=1
fi

# 2. Cohort size claims below threshold ("n=1", "n=2", "n=3" as a standalone token) —
#    catches an accidental quantitative claim made before the gate opens.
if echo "$DIFF" | grep -E '^\+' | grep -qiE '\bn[[:space:]]*=[[:space:]]*[123]\b'; then
    echo "publication-gate: found an explicit small-n claim (n=1/2/3) in the diff." >&2
    echo "  → quantitative facts require n>=5 or an independently replicated method." >&2
    fail=1
fi

# 3. Personal identifiers: email addresses, telegram handles.
if echo "$DIFF" | grep -E '^\+' | grep -qiE '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}|@[a-z0-9_]{5,32}\b'; then
    echo "publication-gate: found an email address or telegram-style handle in the diff." >&2
    echo "  → individual data is never published, per cohort/publication-gate.md." >&2
    fail=1
fi

if [ "$fail" -eq 1 ]; then
    echo "" >&2
    echo "Override only via a written, per-fact, signed exception from the pilot (see cohort/publication-gate.md)." >&2
    exit 1
fi

echo "publication-gate: clean."
