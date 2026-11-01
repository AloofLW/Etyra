#!/usr/bin/env python3
"""Build provisional OEWN headword candidates from a curriculum mirror comparison."""

import argparse
import csv
import gzip
import hashlib
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from build_candidate_inventory import candidate_id
from compare_curriculum_pilot import EXPECTED_PDF_SHA256, SIMPLE_ENTRY, extract_entries, load_candidates

OEWN_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def verify(path, expected, parser):
    with path.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != expected:
        parser.error(f"Unexpected SHA-256 for {path}: {digest}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path, help="Pinned unverified curriculum mirror")
    parser.add_argument("oewn", type=Path, help="Pinned OEWN 2024 XML gzip")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are not overwritten")
    args = parser.parse_args()
    verify(args.pdf, EXPECTED_PDF_SHA256, parser)
    verify(args.oewn, OEWN_SHA256, parser)

    baseline = load_candidates()
    gaps = defaultdict(lambda: {"pages": set(), "forms": set()})
    for page, entry in extract_entries(args.pdf):
        if SIMPLE_ENTRY.fullmatch(entry):
            form = entry.rstrip("*")
            key = form.casefold()
            if key not in baseline:
                gaps[key]["pages"].add(page)
                gaps[key]["forms"].add(form)

    dictionary = defaultdict(list)
    with gzip.open(args.oewn, "rb") as source:
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

    with args.output.open("x", encoding="utf-8", newline="") as file:
        writer = csv.writer(file, lineterminator="\n")
        writer.writerow(("candidate_id", "normalized_key", "oewn_forms", "oewn_entry_ids", "oewn_pos", "mirror_pdf_pages", "status"))
        for key in sorted(dictionary):
            entries = dictionary[key]
            writer.writerow((candidate_id(key), key,
                             "|".join(sorted({x[0] for x in entries})),
                             "|".join(sorted({x[1] for x in entries if x[1]})),
                             "|".join(sorted({x[2] for x in entries if x[2]})),
                             "|".join(str(page) for page in sorted(gaps[key]["pages"])),
                             "candidate_only"))
    print(f"{len(gaps)} unique mirror spellings not in baseline; {len(dictionary)} have OEWN entries; {len(gaps) - len(dictionary)} still need another source or form review.")
    print("Curriculum mirror and all candidate matches require verification; no sense or relation was approved.")


if __name__ == "__main__":
    main()
