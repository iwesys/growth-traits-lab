#!/usr/bin/env bash
# Extract pre-registered datasets (SELECT-only) into local CSVs for analysis.
# Output dir is NOT committed — raw personal data stays local, never enters git.
#
# This script is a template: the actual table names, event types, and schemas
# are specific to whatever tracking system feeds this lab's data, and are
# deliberately not published here (see cohort/publication-gate.md — the
# underlying schema can itself narrow down who the single early participant
# is). Adapt the queries below to your own data source.
#
# Usage: extract.sh <output_dir>

set -euo pipefail

OUT="${1:?usage: extract.sh <output_dir>}"
mkdir -p "$OUT"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DB_URL=$(bash "$SCRIPT_DIR/db_url.sh" "${LAB_DB_NAME:?set LAB_DB_NAME}")

echo "[extract] pilot daily activity series (for regularity-window analysis)..."
psql "$DB_URL" -c "\copy (
    SELECT <date_column>::date AS day, <event_type_column>, count(*) AS n
      FROM <your_events_table>
     WHERE <participant_filter>
       AND <event_type_column> IN (<your_daily_event_types>)
       AND <date_column> >= DATE '<period_start>'
     GROUP BY 1, 2 ORDER BY 1, 2
) TO '$OUT/daily_activity.csv' CSV HEADER"

echo "[extract] weekly auto-signal series (descriptive telemetry)..."
psql "$DB_URL" -c "\copy (
    SELECT date_trunc('week', <date_column>)::date AS week_start,
           <event_type_column>, count(*) AS n
      FROM <your_events_table>
     WHERE <participant_filter>
       AND <event_type_column> IN (<your_weekly_event_types>)
       AND <date_column> >= DATE '<period_start>'
     GROUP BY 1, 2 ORDER BY 1, 2
) TO '$OUT/weekly_events.csv' CSV HEADER"

echo "[extract] latest calculated profile per participant (cross-section)..."
psql "$DB_URL" -c "\copy (
    SELECT DISTINCT ON (<participant_id_column>) <participant_id_column>,
           <calculated_at_column>, <profile_value_column>
      FROM <your_profile_table>
     WHERE <profile_type_filter>
     ORDER BY <participant_id_column>, <calculated_at_column> DESC
) TO '$OUT/profiles.csv' CSV HEADER"

echo "[extract] data-depth audit per pre-registered source..."
psql "$DB_URL" -c "\copy (
    SELECT '<source_name>' AS src, count(*)::text AS rows,
           min(<created_at_column>)::date::text AS from_d,
           max(<created_at_column>)::date::text AS to_d
      FROM <your_source_table>
) TO '$OUT/source_depth.csv' CSV HEADER"

echo "[extract] done → $OUT"
ls -la "$OUT"
