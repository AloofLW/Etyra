#!/usr/bin/env python3
"""Triage exact text matches in an unverified local curriculum mirror extract."""

import argparse
import collections
import csv
import hashlib
import re
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / "docs"
EXPECTED = "d898a899415c2dc1a275d87e20f71f4a2848047dc0c310dfdc15b8f45cb3849a"


def read(path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def fragments(entry):
    """Return literal pieces without asserting spelling or meaning equivalence."""
    entry = entry.strip().rstrip("*").strip()
    outer = entry.split("(", 1)[0].strip()
    yield from (part.strip() for part in outer.split("/") if part.strip())
    match = re.search(r"\(([^()]*)\)", entry)
    if match:
        for part in re.split(r"[,/]", match.group(1)):
            part = part.strip().lstrip("=").strip()
            if part:
                yield part


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("review_csv", type=Path)
    args = parser.parse_args()
    if hashlib.sha256(args.review_csv.read_bytes()).hexdigest() != EXPECTED:
        parser.error("Review CSV digest does not match the recorded mirror extraction")
    main_words = {r["headword"].casefold() for r in read(DOCS / "VOCABULARY_CANDIDATES.csv")}
    supplemental = {r["headword_key"].casefold() for r in read(DOCS / "SUPPLEMENT_REVIEW_QUEUE.csv")}
    if main_words & supplemental:
        raise ValueError("Main and supplemental spelling keys overlap")
    rows = [r for r in read(args.review_csv) if r["classification"] == "complex_needs_review"]
    counts = collections.Counter()
    for row in rows:
        # Trim an optional star suffix, including a space caused by PDF extraction.
        key = re.sub(r"\s*\*+$", "", row["source_line"]).strip().casefold()
        category = "main" if key in main_words else "supplement" if key in supplemental else "other"
        counts[category] += 1
        pieces = list(fragments(row["source_line"]))
        if pieces and all(piece.casefold() in main_words | supplemental for piece in pieces):
            counts["all_fragments_found"] += 1
    print(f"Complex rows: {len(rows)}; exact main: {counts['main']}; "
          f"exact supplement: {counts['supplement']}; other: {counts['other']}")
    print(f"Rows whose literal fragments all have candidate spelling keys: {counts['all_fragments_found']}; "
          f"rows with at least one unmatched fragment: {len(rows) - counts['all_fragments_found']}")
    print("Exploratory spelling matches only; all original lines and curriculum levels still need review.")


if __name__ == "__main__":
    main()
