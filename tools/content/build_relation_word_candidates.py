#!/usr/bin/env python3
"""Index OEWN entries for relation candidates missing from vocabulary inventories."""

import argparse
import csv
import gzip
import hashlib
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from build_candidate_inventory import candidate_id

ROOT = Path(__file__).resolve().parents[2]
OEWN_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path, help="Pinned OEWN 2024 XML gzip")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are never overwritten")
    args = parser.parse_args()
    with args.archive.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != OEWN_SHA256:
        parser.error(f"Unexpected OEWN SHA-256: {digest}")

    known = set()
    for filename in ("VOCABULARY_CANDIDATES.csv", "CURRICULUM_GAP_CANDIDATES.csv", "WIKTIONARY_GAP_CANDIDATES.csv", "COMPLEX_FORM_CANDIDATES.csv", "COMPLEX_WIKTIONARY_CANDIDATES.csv"):
        with (ROOT / "docs" / filename).open(encoding="utf-8", newline="") as source:
            for row in csv.DictReader(source):
                known.add((row.get("normalized_key") or row["headword"]).strip().casefold())
    gaps = defaultdict(set)
    with (ROOT / "docs/WORD_CANDIDATES_V0_1.csv").open(encoding="utf-8", newline="") as source:
        for row in csv.DictReader(source):
            key = row["word_candidate"].strip().casefold()
            if key not in known:
                gaps[key].add(row["candidate_id"])

    dictionary = defaultdict(list)
    with gzip.open(args.archive, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    form = lemma.get("writtenForm", "").strip()
                    key = form.casefold()
                    if key in gaps:
                        dictionary[key].append((form, element.get("id", ""), lemma.get("partOfSpeech", "")))
                element.clear()
            elif element.tag == "Synset":
                element.clear()

    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "normalized_key", "oewn_forms", "oewn_entry_ids", "oewn_pos", "word_relation_candidate_ids", "status"))
        for key, entries in sorted(dictionary.items()):
            writer.writerow((candidate_id(key), key, "|".join(sorted({item[0] for item in entries})),
                             "|".join(sorted({item[1] for item in entries if item[1]})),
                             "|".join(sorted({item[2] for item in entries if item[2]})),
                             "|".join(sorted(gaps[key])), "candidate_only"))
    print(f"{len(gaps)} missing relation-word spellings; {len(dictionary)} have OEWN entries; {len(gaps) - len(dictionary)} remain unmatched.")
    print("Candidates, case-folded matches and root relations still require review.")


if __name__ == "__main__":
    main()
