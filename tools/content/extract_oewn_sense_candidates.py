#!/usr/bin/env python3
"""Extract OEWN definitions for candidate review, without selecting a sense."""

import argparse
import csv
import gzip
import hashlib
import json
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
EXPECTED_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path, help="Unmodified OEWN 2024 XML gzip")
    parser.add_argument("output", type=Path, help="New output CSV; existing files are not overwritten")
    parser.add_argument("--candidate-file", type=Path, action="append", help="Candidate CSV; repeat for supplemental files")
    args = parser.parse_args()
    with args.archive.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != EXPECTED_SHA256:
        parser.error(f"Unexpected OEWN archive SHA-256: {digest}")

    candidates = []
    candidate_files = args.candidate_file or [ROOT / "docs/VOCABULARY_CANDIDATES.csv"]
    for path in candidate_files:
        with path.open(encoding="utf-8", newline="") as file:
            for row in csv.DictReader(file):
                if row.get("status") != "candidate_only":
                    raise ValueError(f"Unexpected candidate status in {path}")
                row["headword"] = row.get("headword") or row["normalized_key"]
                candidates.append(row)
    by_key = {row["normalized_key"]: row for row in candidates}
    if len(by_key) != len(candidates):
        raise ValueError("Candidate keys must be unique")
    senses = []
    with gzip.open(args.archive, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    written = lemma.get("writtenForm", "").strip()
                    candidate = by_key.get(written.casefold())
                    allowed = candidate.get("oewn_entry_ids", "") if candidate else ""
                    if candidate and (not allowed or element.get("id") in allowed.split("|")):
                        for sense in element.findall("Sense"):
                            senses.append((candidate["candidate_id"], candidate["headword"], written,
                                           element.get("id"), lemma.get("partOfSpeech", ""),
                                           sense.get("id"), sense.get("synset")))
                element.clear()
            elif element.tag == "Synset":
                element.clear()

    wanted = {row[-1] for row in senses}
    if None in wanted or any(not all(row) for row in senses):
        raise ValueError("Missing required lexical entry or sense metadata")
    definitions = {}
    with gzip.open(args.archive, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "Synset":
                synset_id = element.get("id")
                if synset_id in wanted:
                    definitions[synset_id] = ["".join(item.itertext()).strip() for item in element.findall("Definition")]
                element.clear()
            elif element.tag == "LexicalEntry":
                element.clear()
    missing = wanted - definitions.keys()
    if missing or any(not definitions[key] or any(not text for text in definitions[key]) for key in wanted):
        raise ValueError(f"Missing synsets or definitions; missing synset count: {len(missing)}")

    keys = [(row[0], row[5]) for row in senses]
    if len(keys) != len(set(keys)):
        raise ValueError("Duplicate candidate/sense pair")
    with args.output.open("x", encoding="utf-8", newline="") as file:
        writer = csv.writer(file, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_written_form", "oewn_entry_id", "pos", "sense_id", "synset_id", "definitions_json", "status"))
        for row in sorted(senses):
            writer.writerow((*row, json.dumps(definitions[row[-1]], ensure_ascii=False), "candidate_only"))
    print(f"Wrote {len(senses)} candidate sense rows across {len({row[0] for row in senses})} candidate words.")
    print("Definitions are source excerpts for review; no sense is approved or selected.")


if __name__ == "__main__":
    main()
