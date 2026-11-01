#!/usr/bin/env python3
"""Index candidate headwords against a pinned OEWN release for later review."""

import argparse
import csv
import gzip
import hashlib
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
EXPECTED_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path, help="Unmodified 2024-edition XML gzip")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are not overwritten")
    args = parser.parse_args()
    with args.archive.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != EXPECTED_SHA256:
        parser.error(f"Unexpected OEWN archive SHA-256: {digest}")

    with (ROOT / "docs/VOCABULARY_CANDIDATES.csv").open(encoding="utf-8", newline="") as file:
        candidates = list(csv.DictReader(file))
    keys = {row["normalized_key"] for row in candidates}
    matches = defaultdict(list)
    with gzip.open(args.archive, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    key = lemma.get("writtenForm", "").strip().casefold()
                    if key in keys:
                        senses = [sense.get("id") for sense in element.findall("Sense")]
                        matches[key].append((element.get("id"), lemma.get("partOfSpeech", ""), senses))
                element.clear()
            elif element.tag == "Synset":
                element.clear()

    with args.output.open("x", encoding="utf-8", newline="") as file:
        writer = csv.writer(file, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_entry_ids", "oewn_pos", "sense_count", "status"))
        for row in candidates:
            entries = matches[row["normalized_key"]]
            entry_ids = sorted({entry_id for entry_id, _, _ in entries if entry_id})
            pos = sorted({part for _, part, _ in entries if part})
            senses = {sense for _, _, group in entries for sense in group if sense}
            writer.writerow((row["candidate_id"], row["headword"], "|".join(entry_ids), "|".join(pos), len(senses), "candidate_only"))
    matched = sum(bool(matches[row["normalized_key"]]) for row in candidates)
    print(f"Indexed {len(candidates)} candidates: {matched} case-folded headword matches; {len(candidates) - matched} unmatched.")
    print("Case-folded matches do not select a sense or approve a definition.")


if __name__ == "__main__":
    main()
