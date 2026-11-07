#!/usr/bin/env python3
"""Compare simple extracted spellings and star marks, not official coverage."""

import argparse
import collections
import csv
import hashlib
import re
from pathlib import Path

PINNED = (
    "254e242458b1825e64dc92811c51e1c86ca95a9ee493f4f190f58d44460ec605",
    "d898a899415c2dc1a275d87e20f71f4a2848047dc0c310dfdc15b8f45cb3849a",
)
SIMPLE = re.compile(r"^([A-Za-z]+)(\*{0,2})$")


def load(path, expected, parser):
    if hashlib.sha256(path.read_bytes()).hexdigest() != expected:
        parser.error(f"Review CSV digest differs from recorded extraction: {path}")
    entries = collections.defaultdict(list)
    with path.open(encoding="utf-8-sig", newline="") as file:
        for row in csv.DictReader(file):
            match = SIMPLE.fullmatch(row["source_line"])
            if match:
                entries[match.group(1).casefold()].append((len(match.group(2)), row["pdf_page"]))
    return entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("review_2020", type=Path)
    parser.add_argument("review_2025_mirror", type=Path)
    parser.add_argument("--review-csv", type=Path, help="Local-only changed-mark review file; rights not cleared")
    args = parser.parse_args()
    before = load(args.review_2020, PINNED[0], parser)
    after = load(args.review_2025_mirror, PINNED[1], parser)
    shared = before.keys() & after.keys()
    single = sorted(key for key in shared if len(before[key]) == len(after[key]) == 1)
    changes = collections.Counter((before[key][0][0], after[key][0][0]) for key in single)
    print(f"Simple keys: 2020={len(before)}, 2025 mirror={len(after)}; shared={len(shared)}; "
          f"single in both={len(single)}; duplicate-key exclusions={len(shared) - len(single)}")
    for (old, new), count in sorted(changes.items()):
        print(f"stars {old} -> {new}: {count}")
    print(f"Only in 2020 simple extraction: {len(before.keys() - after.keys())}; "
          f"only in 2025 simple extraction: {len(after.keys() - before.keys())}")
    print("Spelling and marker triage only; complex rows, extraction, authentic version and meanings remain unverified.")
    if args.review_csv:
        with args.review_csv.open("x", encoding="utf-8", newline="") as file:
            writer = csv.writer(file, lineterminator="\n")
            writer.writerow(("normalized_key", "stars_2020", "pdf_page_2020", "stars_2025_mirror", "pdf_page_2025_mirror"))
            for key in single:
                old, old_page = before[key][0]
                new, new_page = after[key][0]
                if old != new:
                    writer.writerow((key, old, old_page, new, new_page))
        print("Local changed-marker list written; do not redistribute without a rights review.")


if __name__ == "__main__":
    main()
