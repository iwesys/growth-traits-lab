#!/usr/bin/env python3
"""growth-traits-lab: template pre-registered analysis over extract.sh CSVs.

This is a worked example of the analysis shape this lab uses, not a
ready-to-run tool — column names and thresholds below are placeholders.
Adapt CHARACTERISTIC_COLUMNS and the functions below to your own
pre-registration before running against real data. Anything computed here
that isn't in the committed pre-registration file is exploratory, per
methodology/discipline.md.

Prints a markdown fragment intended to be folded into the iteration's report
by the person running the analysis.
"""

import csv
import statistics
import sys
from pathlib import Path

from scipy import stats

# Placeholder — replace with the characteristic columns your pre-registration
# actually tracks (see methodology/pre-registration-template.md).
CHARACTERISTIC_COLUMNS = ["<characteristic_1>", "<characteristic_2>"]


def read_csv(path: Path) -> list[dict]:
    with path.open() as f:
        return list(csv.DictReader(f))


def data_sufficiency(source_depth_rows: list[dict], hypotheses: list[dict]) -> str:
    """Report, per pre-registered hypothesis, whether the required source has
    enough history to say anything — the honest first check before any
    correlation or delta is computed.
    """
    depth = {r["src"]: r for r in source_depth_rows}
    lines = ["| Hypothesis | Required source | Rows on hand | Verdict |",
             "|---|---|---|---|"]
    for h in hypotheses:
        row = depth.get(h["source"])
        rows = int(row["rows"]) if row else 0
        verdict = "insufficient data" if rows < h["min_rows"] else "proceed"
        lines.append(f"| {h['id']} | {h['source']} | {rows} | {verdict} |")
    return "\n".join(lines)


def paired_correlation(pairs: list[tuple[float, float]], label: str) -> str:
    """A single rung-1 correlation check between two series, with the honesty
    guard this lab requires: report when N is too small or one axis is
    constant, rather than compute a number that looks precise but isn't.
    """
    if len(pairs) < 5:
        return f"{label}: only {len(pairs)} pairs — insufficient data."
    xs, ys = zip(*pairs)
    if len(set(xs)) == 1 or len(set(ys)) == 1:
        return f"{label}: n={len(pairs)}, but one axis is constant — correlation undefined."
    r, pval = stats.pearsonr(xs, ys)
    return f"{label}: n={len(pairs)}, r={r:.3f} (p={pval:.3g}). Rung 1 — correlation, not cause."


def weekly_summary(rows: list[dict], event_kinds: list[str]) -> str:
    by_week: dict[str, dict[str, int]] = {}
    for r in rows:
        by_week.setdefault(r["week_start"], {})[r["event_type"]] = int(r["n"])
    lines = ["| week | " + " | ".join(event_kinds) + " |",
             "|" + "---|" * (len(event_kinds) + 1)]
    for wk in sorted(by_week):
        counts = [str(by_week[wk].get(k, 0)) for k in event_kinds]
        lines.append("| " + wk + " | " + " | ".join(counts) + " |")
    return "\n".join(lines)


def main() -> None:
    data = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    print("## Data sufficiency check\n")
    print("(fill in your pre-registration's hypothesis list and re-run)\n")
    print("## Weekly activity summary\n")
    print(weekly_summary(read_csv(data / "weekly_events.csv"),
                          event_kinds=["<your_event_type_1>", "<your_event_type_2>"]))


if __name__ == "__main__":
    main()
