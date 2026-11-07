#!/usr/bin/env python3
"""Index OEWN lemmas corresponding to exploratory 2020 curriculum gaps."""

import argparse
import csv
import gzip
import hashlib
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from build_candidate_inventory import candidate_id
from compare_2020_curriculum import DOCS, PDF_SHA256, SIMPLE, extract, read

OEWN_SHA256 = "e1f633b0a93758cae34ea27c44c4dad310a8af2467b155f99dd6673af697e875"


def verify(path, expected, parser):
    if hashlib.sha256(path.read_bytes()).hexdigest() != expected:
        parser.error(f"Unexpected input digest: {path}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path)
    parser.add_argument("oewn", type=Path)
    parser.add_argument("output", type=Path, help="New CSV; never overwrites an existing file")
    args = parser.parse_args()
    verify(args.pdf, PDF_SHA256, parser)
    verify(args.oewn, OEWN_SHA256, parser)
    known = {r["headword"].strip().casefold() for r in read(DOCS / "VOCABULARY_CANDIDATES.csv")}
    known |= {r["headword_key"].strip().casefold() for r in read(DOCS / "SUPPLEMENT_REVIEW_QUEUE.csv")}
    missing = defaultdict(lambda: {"forms": set(), "pages": set()})
    for page, text in extract(args.pdf):
        if SIMPLE.fullmatch(text):
            form = text.rstrip("*")
            key = form.casefold()
            if key not in known:
                missing[key]["forms"].add(form)
                missing[key]["pages"].add(page)
    found = defaultdict(list)
    with gzip.open(args.oewn, "rb") as source:
        for _, element in ET.iterparse(source, events=("end",)):
            if element.tag == "LexicalEntry":
                lemma = element.find("Lemma")
                if lemma is not None:
                    form = lemma.get("writtenForm", "").strip()
                    key = form.casefold()
                    if key in missing:
                        found[key].append((form, element.get("id", ""), lemma.get("partOfSpeech", "")))
                element.clear()
            elif element.tag == "Synset":
                element.clear()
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "normalized_key", "oewn_forms", "oewn_entry_ids", "oewn_pos", "case_match", "historical_pdf_pages", "status"))
        for key, entries in sorted(found.items()):
            forms = {item[0] for item in entries}
            writer.writerow((candidate_id(key), key, "|".join(sorted(forms)),
                             "|".join(sorted({item[1] for item in entries if item[1]})),
                             "|".join(sorted({item[2] for item in entries if item[2]})),
                             "exact_present" if forms & missing[key]["forms"] else "casefold_only",
                             "|".join(map(str, sorted(missing[key]["pages"]))), "candidate_only"))
    print(f"Historical gaps: {len(missing)}; OEWN spelling candidates: {len(found)}; unmatched: {len(missing) - len(found)}")
    print("Not current curriculum coverage, approved meanings, or a product seed.")


if __name__ == "__main__":
    main()
