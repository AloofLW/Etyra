#!/usr/bin/env python3
"""Exploratory 2020 official curriculum comparison; not current coverage proof."""

import argparse
import collections
import csv
import hashlib
import re
from pathlib import Path

import pdfplumber

DOCS = Path(__file__).resolve().parents[2] / "docs"
PDF_SHA256 = "8ebd6bb12e9eb1c58e422ee01b540a4a71d2e681a4c4a764a36ee3a34b21c1be"
SIMPLE = re.compile(r"[A-Za-z]+\**")


def read(path):
    with path.open(encoding="utf-8-sig", newline="") as file:
        return list(csv.DictReader(file))


def extract(pdf):
    entries = []
    with pdfplumber.open(pdf) as document:
        if len(document.pages) != 220:
            raise ValueError("Unexpected 2020 curriculum page count")
        # PDF pages 129–184; exclude the introductory text and country appendix.
        for page_index in range(128, 184):
            start = 470 if page_index == 128 else 75
            end = 260 if page_index == 183 else 675
            for right in (False, True):
                words = sorted((w for w in document.pages[page_index].extract_words(x_tolerance=2, y_tolerance=3)
                                if start <= w["top"] < end and (w["x0"] >= 250) == right),
                               key=lambda w: (w["top"], w["x0"]))
                lines = []
                for word in words:
                    if lines and abs(word["top"] - lines[-1][0]) <= 2:
                        lines[-1][1].append(word)
                    else:
                        lines.append((word["top"], [word]))
                for _, line in lines:
                    text = " ".join(word["text"] for word in sorted(line, key=lambda w: w["x0"]))
                    if re.fullmatch(r"[A-Z]", text) or not re.match(r"[A-Za-z]", text):
                        continue
                    entries.append((page_index + 1, text))
    return entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path)
    parser.add_argument("--review-csv", type=Path, help="Local-only review CSV; rights have not been cleared")
    args = parser.parse_args()
    if hashlib.sha256(args.pdf.read_bytes()).hexdigest() != PDF_SHA256:
        parser.error("PDF SHA-256 differs from the recorded 2020 source")
    main_words = {r["headword"].strip().casefold() for r in read(DOCS / "VOCABULARY_CANDIDATES.csv")}
    supplement = {r["headword_key"].strip().casefold() for r in read(DOCS / "SUPPLEMENT_REVIEW_QUEUE.csv")}
    if main_words & supplement:
        raise ValueError("Candidate spelling keys overlap")
    entries = extract(args.pdf)
    result = []
    for page, line in entries:
        key = line.rstrip("*").casefold()
        category = ("complex_needs_review" if not SIMPLE.fullmatch(line) else
                    "main_exact" if key in main_words else
                    "supplement_exact" if key in supplement else "unmatched")
        result.append((page, line, category))
    counts = collections.Counter(row[2] for row in result)
    simple_keys = {line.rstrip("*").casefold() for _, line, kind in result if kind != "complex_needs_review"}
    print(f"Extracted rows: {len(result)}; simple rows: {len(result) - counts['complex_needs_review']}; "
          f"unique simple spellings: {len(simple_keys)}; complex rows: {counts['complex_needs_review']}")
    print(f"Simple exact main: {counts['main_exact']}; supplement: {counts['supplement_exact']}; "
          f"unmatched: {counts['unmatched']}")
    print("Historical extraction pilot only; page layout, meaning, version and rights require review.")
    if args.review_csv:
        with args.review_csv.open("x", encoding="utf-8", newline="") as file:
            writer = csv.writer(file, lineterminator="\n")
            writer.writerow(("pdf_page", "source_line", "classification"))
            writer.writerows(result)
        print("Local review CSV written; do not redistribute without a rights review.")


if __name__ == "__main__":
    main()
