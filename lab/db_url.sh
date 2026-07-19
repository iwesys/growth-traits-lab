#!/usr/bin/env bash
# Print a psql connection URL for a Neon Postgres branch, read-only discipline
# (the lab only ever issues SELECT statements — enforced by convention and
# report review, not by a separate database role).
#
# Configure via environment (see docs/ci-inventory.md for the variable names
# this lab actually uses in its private deployment):
#   NEON_PROJECT_ID, NEON_BRANCH_ID, NEON_API_KEY
#
# Usage: db_url.sh <dbname>

set -euo pipefail

DB="${1:?usage: db_url.sh <dbname>}"
: "${NEON_PROJECT_ID:?set NEON_PROJECT_ID}"
: "${NEON_BRANCH_ID:?set NEON_BRANCH_ID}"

if [ -z "${NEON_API_KEY:-}" ] && [ -f "$HOME/.secrets/neon" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.secrets/neon"
fi
[ -n "${NEON_API_KEY:-}" ] || { echo "NEON_API_KEY not set" >&2; exit 1; }

host=$(curl -fsS \
    "https://console.neon.tech/api/v2/projects/$NEON_PROJECT_ID/branches/$NEON_BRANCH_ID/endpoints" \
    -H "Authorization: Bearer $NEON_API_KEY" \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['endpoints'][0]['host'])")

pass=$(curl -fsS \
    "https://console.neon.tech/api/v2/projects/$NEON_PROJECT_ID/branches/$NEON_BRANCH_ID/roles/neondb_owner/reveal_password" \
    -H "Authorization: Bearer $NEON_API_KEY" \
    | python3 -c "import sys,json,urllib.parse; print(urllib.parse.quote(json.load(sys.stdin)['password'], safe=''))")

printf "postgresql://neondb_owner:%s@%s/%s?sslmode=require" "$pass" "$host" "$DB"
