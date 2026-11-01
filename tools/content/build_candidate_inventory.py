#!/usr/bin/env python3
"""Merge the pinned, licensed wordlists into a review-only candidate inventory."""

import argparse
import csv
import hashlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SOURCES = ROOT / "docs/reference/wordlists"
INPUTS = {
    "NGSL-GR-1.0-rank.csv": "5c4f7bb84b5d74d7481d43483b811f1591bd667b86a6131f1566fdf07cade91e",
    "NAWL-1.2-alphabetized.txt": "88a99099e10010ea40992cca4a5119102d05a0f2888ee5d43d4c8b4afd597fef",
}


def checked_text(name):
    data = (SOURCES / name).read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    if digest != INPUTS[name]:
        raise ValueError(f"Source checksum mismatch for {name}: {digest}")
    return data.decode("utf-8-sig")


def candidate_id(key):
    return "vocab-candidate-" + hashlib.sha256(key.encode("utf-8")).hexdigest()[:20]


def build_rows():
    records = {}
    for row in csv.DictReader(checked_text("NGSL-GR-1.0-rank.csv").splitlines()):
        spelling = row["Word"].strip()
        key = spelling.casefold()
        if not key or key in records:
            raise ValueError(f"Empty or duplicated NGSL headword: {spelling!r}")
        records[key] = {"headword": spelling, "ngsl_word_id": row["WordID"], "nawl": False}

    seen_nawl = set()
    for spelling in checked_text("NAWL-1.2-alphabetized.txt").splitlines()[6:]:
        spelling = spelling.strip()
        key = spelling.casefold()
        if not key or key in seen_nawl:
            raise ValueError(f"Empty or duplicated NAWL headword: {spelling!r}")
        seen_nawl.add(key)
        if key not in records:
            records[key] = {"headword": spelling, "ngsl_word_id": "", "nawl": False}
        records[key]["nawl"] = True

    ids = set()
    for key, record in sorted(records.items()):
        identity = candidate_id(key)
        if identity in ids:
            raise ValueError(f"Candidate ID collision: {identity}")
        ids.add(identity)
        sources = []
        if record["ngsl_word_id"]:
            sources.append("NGSL-GR-1.0")
        if record["nawl"]:
            sources.append("NAWL-1.2")
        yield (identity, record["headword"], key, "|".join(sources), record["ngsl_word_id"], "candidate_only")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path, help="New CSV output path; existing files are not overwritten")
    args = parser.parse_args()
    rows = list(build_rows())
    with args.output.open("x", encoding="utf-8", newline="") as file:
        writer = csv.writer(file, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "normalized_key", "source_ids", "ngsl_word_id", "status"))
        writer.writerows(rows)
    print(f"Wrote {len(rows)} review-only candidates to {args.output}")


if __name__ == "__main__":
    main()
