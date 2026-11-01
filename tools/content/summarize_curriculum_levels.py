#!/usr/bin/env python3
"""Summarize tentative curriculum-mirror matching by star level.

This only reports aggregate counts. It does not authenticate the PDF, verify
its extraction, establish curriculum coverage, or copy its vocabulary list.
"""
import argparse
import collections
import csv
import hashlib
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SIMPLE_ENTRY = re.compile(r"[A-Za-z]+\**")
EXPECTED_REVIEW_SHA256 = "d898a899415c2dc1a275d87e20f71f4a2848047dc0c310dfdc15b8f45cb3849a"


def keys(path, field):
    with path.open(encoding="utf-8", newline="") as source:
        return {row[field].strip().casefold() for row in csv.DictReader(source)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("review_csv", type=Path, help="Pinned local exploratory extraction")
    args = parser.parse_args()
    if hashlib.sha256(args.review_csv.read_bytes()).hexdigest() != EXPECTED_REVIEW_SHA256:
        parser.error("Review CSV SHA-256 does not match the pinned extraction")
    docs = ROOT / "docs"
    main_keys = keys(docs / "VOCABULARY_CANDIDATES.csv", "normalized_key")
    supplement = keys(docs / "CURRICULUM_GAP_CANDIDATES.csv", "normalized_key")
    supplement |= keys(docs / "WIKTIONARY_GAP_CANDIDATES.csv", "headword")
    counts = collections.Counter()
    with args.review_csv.open(encoding="utf-8", newline="") as source:
        lines = [row["source_line"] for row in csv.DictReader(source)]
    for line in lines:
        if not SIMPLE_ENTRY.fullmatch(line):
            counts[("complex", "excluded")] += 1
            continue
        key = line.rstrip("*").casefold()
        stars = len(line) - len(line.rstrip("*"))
        level = {0: "no_star", 1: "one_star", 2: "two_stars"}.get(stars, "unexpected_stars")
        category = "main" if key in main_keys else "supplement" if key in supplement else "unmatched"
        counts[(level, category)] += 1
    for level in ("no_star", "one_star", "two_stars", "unexpected_stars"):
        print(level, *(f"{category}={counts[(level, category)]}" for category in ("main", "supplement", "unmatched")))
    print(f"complex_excluded={counts[('complex', 'excluded')]}")
    print("Counts are raw extracted lines; stars and matching require manual verification.")


if __name__ == "__main__":
    main()
