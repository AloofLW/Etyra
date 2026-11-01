#!/usr/bin/env python3
"""Join pinned OEWN and COW candidates by explicit CILI identifier for review."""

import argparse
import csv
import gzip
import hashlib
import json
import tarfile
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OEWN_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"
COW_SHA256 = "93e9357dda50a38ce626904c2229479afa177df74d9c504aebfeba06ff2f241e"


def verify(path, expected, parser):
    with path.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != expected:
        parser.error(f"Unexpected SHA-256 for {path}: {digest}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("oewn", type=Path, help="Pinned OEWN 2024 XML gzip")
    parser.add_argument("cow", type=Path, help="Pinned COW 1.1 tar.xz")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are not overwritten")
    args = parser.parse_args()
    verify(args.oewn, OEWN_SHA256, parser)
    verify(args.cow, COW_SHA256, parser)

    with (ROOT / "docs/OEWN_SENSE_CANDIDATES.csv").open(encoding="utf-8", newline="") as source:
        candidates = list(csv.DictReader(source))
    wanted_senses = {row["sense_id"]: row["synset_id"] for row in candidates}
    wanted_synsets = set(wanted_senses.values())
    found_senses = {}
    english_ili = {}
    with gzip.open(args.oewn, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                for sense in element.findall("Sense"):
                    if sense.get("id") in wanted_senses:
                        found_senses[sense.get("id")] = sense.get("synset")
                element.clear()
            elif element.tag == "Synset":
                if element.get("id") in wanted_synsets:
                    english_ili[element.get("id")] = element.get("ili")
                element.clear()
    if found_senses != wanted_senses or set(english_ili) != wanted_synsets:
        raise ValueError("Candidate sense or synset references differ from the pinned OEWN release")
    wanted_ili = {ili for ili in english_ili.values() if ili and ili != "in"}

    chinese_forms = defaultdict(set)
    chinese_ili = defaultdict(set)
    with tarfile.open(args.cow, "r:xz") as archive:
        with archive.extractfile("cow/cow-1.1.xml") as source:
            for _, element in ET.iterparse(source, events=("end",)):
                if element.tag == "LexicalEntry":
                    lemma = element.find("Lemma")
                    form = lemma.get("writtenForm", "").strip() if lemma is not None else ""
                    if form:
                        for sense in element.findall("Sense"):
                            if sense.get("synset"):
                                chinese_forms[sense.get("synset")].add(form)
                    element.clear()
                elif element.tag == "Synset":
                    if element.get("ili") in wanted_ili:
                        chinese_ili[element.get("ili")].add(element.get("id"))
                    element.clear()

    rows = []
    for row in candidates:
        ili = english_ili[row["synset_id"]]
        if not ili or ili == "in":
            continue
        cow_synsets = sorted(chinese_ili.get(ili, set()))
        forms = sorted({form for synset in cow_synsets for form in chinese_forms.get(synset, set())})
        if forms:
            rows.append((row["candidate_id"], row["headword"], row["oewn_written_form"],
                         row["pos"], row["sense_id"], row["synset_id"], ili,
                         "|".join(cow_synsets), json.dumps(forms, ensure_ascii=False), "candidate_only"))
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "oewn_written_form", "pos", "sense_id", "oewn_synset_id",
                         "ili", "cow_synset_ids", "chinese_lemmas_json", "status"))
        writer.writerows(rows)
    print(f"Aligned {len(rows)} sense candidates across {len({row[0] for row in rows})} candidate words.")
    print("CILI links and Chinese lemmas are review candidates, not approved translations or etymologies.")


if __name__ == "__main__":
    main()
