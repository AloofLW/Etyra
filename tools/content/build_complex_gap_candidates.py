#!/usr/bin/env python3
"""Find OEWN headword candidates in complex lines of a pinned mirror PDF."""

import argparse
import csv
import gzip
import hashlib
import re
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from build_candidate_inventory import candidate_id
from compare_curriculum_pilot import EXPECTED_PDF_SHA256, SIMPLE_ENTRY, extract_entries

ROOT = Path(__file__).resolve().parents[2]
OEWN_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def verify(path, expected, parser):
    with path.open("rb") as source:
        actual = hashlib.file_digest(source, "sha256").hexdigest()
    if actual != expected:
        parser.error(f"Unexpected SHA-256 for {path}: {actual}")


def existing_keys():
    keys = set()
    for filename in ("VOCABULARY_CANDIDATES.csv", "CURRICULUM_GAP_CANDIDATES.csv", "WIKTIONARY_GAP_CANDIDATES.csv"):
        with (ROOT / "docs" / filename).open(encoding="utf-8", newline="") as source:
            for row in csv.DictReader(source):
                keys.add((row.get("normalized_key") or row["headword"]).strip().casefold())
    return keys


def fragments(entry):
    """Yield literal fragments only; no claim of equivalence or inflection."""
    entry = entry.strip().rstrip("*").strip()
    outer = entry.split("(", 1)[0].strip()
    for value in outer.split("/"):
        if value.strip():
            yield value.strip()
    match = re.search(r"\(([^()]*)\)", entry)
    if match:
        for value in re.split(r"[,/]", match.group(1)):
            value = value.strip().lstrip("=").strip()
            if value:
                yield value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path)
    parser.add_argument("oewn", type=Path)
    parser.add_argument("output", type=Path, help="New output file; an existing file is never overwritten")
    args = parser.parse_args()
    verify(args.pdf, EXPECTED_PDF_SHA256, parser)
    verify(args.oewn, OEWN_SHA256, parser)
    known = existing_keys()

    missing = defaultdict(lambda: {"pages": set(), "forms": set()})
    complex_count = 0
    for page, entry in extract_entries(args.pdf):
        if SIMPLE_ENTRY.fullmatch(entry):
            continue
        complex_count += 1
        for value in fragments(entry):
            key = value.casefold()
            if key not in known:
                missing[key]["pages"].add(page)
                missing[key]["forms"].add(value)

    dictionary = defaultdict(list)
    with gzip.open(args.oewn, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    form = lemma.get("writtenForm", "").strip()
                    key = form.casefold()
                    if key in missing:
                        dictionary[key].append((form, element.get("id", ""), lemma.get("partOfSpeech", "")))
                element.clear()
            elif element.tag == "Synset":
                element.clear()

    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "normalized_key", "oewn_forms", "oewn_entry_ids", "oewn_pos", "case_match", "mirror_pdf_pages", "status"))
        for key, entries in sorted(dictionary.items()):
            writer.writerow((candidate_id(key), key, "|".join(sorted({x[0] for x in entries})),
                             "|".join(sorted({x[1] for x in entries if x[1]})),
                             "|".join(sorted({x[2] for x in entries if x[2]})),
                             "exact_present" if {x[0] for x in entries} & missing[key]["forms"] else "casefold_only",
                             "|".join(map(str, sorted(missing[key]["pages"]))), "candidate_only"))
    print(f"Complex lines: {complex_count}; new literal fragments: {len(missing)}; OEWN matches: {len(dictionary)}; other fragments: {len(missing) - len(dictionary)}.")
    print("Fragments, casing, curriculum relevance and word senses all require review.")


if __name__ == "__main__":
    main()
