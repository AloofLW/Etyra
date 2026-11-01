#!/usr/bin/env python3
"""Exploratory coverage comparison for a specific, unverified PDF mirror.

Requires pdfplumber. Does not copy the PDF or its vocabulary into the repo.
This is a pilot extraction, not proof of curriculum coverage.
"""

import argparse
import collections
import csv
import hashlib
import re
from pathlib import Path

import pdfplumber

ROOT = Path(__file__).resolve().parents[2]
EXPECTED_PDF_SHA256 = "4d2d0f33e511dc0d239d2cdc53fe16f38a107afde9bd1ae557cec9ce7bb1bba0"
SIMPLE_ENTRY = re.compile(r"[A-Za-z]+\**")


def load_candidates():
    directory = ROOT / "docs/reference/wordlists"
    with (directory / "NGSL-GR-1.0-rank.csv").open(encoding="utf-8-sig", newline="") as file:
        ngsl = {row["Word"].strip().casefold() for row in csv.DictReader(file)}
    lines = (directory / "NAWL-1.2-alphabetized.txt").read_text(encoding="utf-8-sig").splitlines()
    nawl = {line.strip().casefold() for line in lines[6:] if line.strip()}
    return ngsl | nawl


def extract_entries(pdf_path):
    entries = []
    with pdfplumber.open(pdf_path) as document:
        if len(document.pages) < 132:
            raise ValueError("The PDF has fewer pages than the pinned source.")
        # PDF pages 76–132; the introductory section precedes page 76's list.
        for page_index in range(75, 132):
            for right_column in (False, True):
                lines = collections.defaultdict(list)
                for word in document.pages[page_index].extract_words(x_tolerance=2, y_tolerance=3):
                    top = word["top"]
                    if not (455 if page_index == 75 else 75) <= top < 690:
                        continue
                    if (word["x0"] >= 250) != right_column:
                        continue
                    lines[round(top)].append(word["text"])
                for words in (lines[key] for key in sorted(lines)):
                    entry = " ".join(words).strip()
                    if re.fullmatch(r"[A-Z]", entry) or not re.match(r"[A-Za-z]", entry):
                        continue
                    entries.append((page_index + 1, entry))
    return entries


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path, help="Local copy of the pinned unverified PDF mirror")
    parser.add_argument("--review-csv", type=Path, help="Optional local review file; do not publish without a rights review")
    args = parser.parse_args()
    actual_hash = hashlib.sha256(args.pdf.read_bytes()).hexdigest()
    if actual_hash != EXPECTED_PDF_SHA256:
        parser.error(f"PDF SHA-256 differs from pinned source: {actual_hash}")

    candidates = load_candidates()
    entries = extract_entries(args.pdf)
    simple = [(page, entry.rstrip("*").casefold()) for page, entry in entries if SIMPLE_ENTRY.fullmatch(entry)]
    matched = [(page, word) for page, word in simple if word in candidates]
    unmatched = [(page, word) for page, word in simple if word not in candidates]
    print(f"PDF SHA-256: {actual_hash}")
    print(f"Extracted lines: {len(entries)}")
    print(f"Simple single-word lines: {len(simple)}; unique spellings: {len({word for _, word in simple})}")
    print(f"Exact matches: {len(matched)}; unmatched: {len(unmatched)}")
    print(f"Complex lines excluded: {len(entries) - len(simple)}")
    print("Exploratory results only; PDF authenticity, extraction and meaning require review.")
    if args.review_csv:
        with args.review_csv.open("x", encoding="utf-8", newline="") as file:
            writer = csv.writer(file)
            writer.writerow(("pdf_page", "source_line", "classification"))
            for page, entry in entries:
                if SIMPLE_ENTRY.fullmatch(entry):
                    classification = "exact_match" if entry.rstrip("*").casefold() in candidates else "unmatched"
                else:
                    classification = "complex_needs_review"
                writer.writerow((page, entry, classification))
        print(f"Review file written: {args.review_csv}")


if __name__ == "__main__":
    main()
