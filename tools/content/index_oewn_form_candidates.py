#!/usr/bin/env python3
"""Find explicit OEWN Forms for candidates without a matching OEWN lemma.

Exact, case-folded form matches are review clues, not verified inflections,
translations, etymologies, or reasons to merge learning-progress identifiers.
"""
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
    parser.add_argument("archive", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    with args.archive.open("rb") as source:
        if hashlib.file_digest(source, "sha256").hexdigest() != EXPECTED_SHA256:
            parser.error("Unexpected OEWN archive SHA-256")
    with (ROOT / "docs/OEWN_CANDIDATE_INDEX.csv").open(encoding="utf-8", newline="") as source:
        candidates = [row for row in csv.DictReader(source) if not row["oewn_entry_ids"]]
    keys = {row["headword"].strip().casefold() for row in candidates}
    matches = defaultdict(set)
    with gzip.open(args.archive, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    for form in element.findall("Form"):
                        written = form.get("writtenForm", "")
                        key = written.strip().casefold()
                        if key in keys:
                            matches[key].add((written, lemma.get("writtenForm", ""),
                                              element.get("id", ""), lemma.get("partOfSpeech", "")))
                element.clear()
            elif element.tag == "Synset":
                element.clear()
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_form", "oewn_lemma", "oewn_entry_id", "pos", "status"))
        for row in candidates:
            for form, lemma, entry_id, pos in sorted(matches[row["headword"].strip().casefold()]):
                writer.writerow((row["candidate_id"], row["headword"], form, lemma, entry_id, pos,
                                 "form_match_needs_review"))
    print(f"Matched {sum(bool(values) for values in matches.values())} of {len(candidates)} unmatched candidates; {sum(map(len, matches.values()))} form-entry pairs.")
    print("OEWN Form entries need individual review; do not infer meaning or root relationships.")


if __name__ == "__main__":
    main()
