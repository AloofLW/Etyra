#!/usr/bin/env python3
"""Flag candidate words whose COW-linked OEWN forms differ in letter case."""
import argparse
import collections
import csv
from pathlib import Path
from build_vocabulary_review_queue import read


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    grouped = collections.defaultdict(list)
    for row in read("COW_SENSE_CANDIDATES.csv"):
        grouped[row["candidate_id"]].append(row)
    with args.output.open("x", encoding="utf8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_forms", "cow_sense_rows", "status"))
        for candidate_id, values in sorted(grouped.items()):
            words = {item["headword"] for item in values}
            if len(words) != 1:
                raise ValueError(f"Inconsistent headword: {candidate_id}")
            word = next(iter(words))
            forms = {item["oewn_written_form"] for item in values}
            if word not in forms:
                writer.writerow((candidate_id, word, "|".join(sorted(forms)), len(values), "case_mismatch_needs_review"))
    print("Case mismatches are review signals, not proof of incorrect meaning.")


if __name__ == "__main__":
    main()
