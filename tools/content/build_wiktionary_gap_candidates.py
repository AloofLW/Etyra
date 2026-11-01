#!/usr/bin/env python3
"""Record English Wiktionary revisions for remaining simple mirror gaps."""

import argparse
import csv
import json
import re
from collections import defaultdict
from pathlib import Path

from build_candidate_inventory import candidate_id

ROOT = Path(__file__).resolve().parents[2]
ENGLISH = re.compile(r"(?ms)^==English==\s*$(.*?)(?=^==[^=\n]+==\s*$|\Z)")
HEADING = re.compile(r"^={3,5}\s*(Pronoun|Determiner|Noun|Interjection)\s*={3,5}\s*$", re.M)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("review_csv", type=Path, help="Local review output from the pinned curriculum mirror")
    parser.add_argument("wiktionary_json", type=Path, help="MediaWiki query response containing revision content")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are not overwritten")
    args = parser.parse_args()

    with (ROOT / "docs/CURRICULUM_GAP_CANDIDATES.csv").open(encoding="utf-8", newline="") as source:
        covered = {row["normalized_key"] for row in csv.DictReader(source)}
    gaps = defaultdict(set)
    with args.review_csv.open(encoding="utf-8", newline="") as source:
        for row in csv.DictReader(source):
            if row["classification"] == "unmatched":
                key = row["source_line"].rstrip("*").casefold()
                if key not in covered:
                    gaps[key].add(int(row["pdf_page"]))

    with args.wiktionary_json.open(encoding="utf-8") as source:
        pages = json.load(source)["query"]["pages"].values()
    data = {}
    for page in pages:
        key = page["title"].casefold()
        revision = page["revisions"][0]
        match = ENGLISH.search(revision["slots"]["main"]["*"])
        if key not in gaps or not match:
            raise ValueError(f"Unexpected page or missing English section: {page['title']}")
        headings = sorted(set(HEADING.findall(match.group(1))))
        if not headings:
            raise ValueError(f"No relevant English part-of-speech heading: {page['title']}")
        data[key] = (page["title"], revision["revid"], revision["timestamp"], headings)
    if set(data) != set(gaps):
        raise ValueError(f"Wiktionary pages differ from remaining gaps: {sorted(set(gaps) ^ set(data))}")

    with args.output.open("x", encoding="utf-8", newline="") as file:
        writer = csv.writer(file, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_revision", "source_timestamp_utc", "english_headings", "source_url", "mirror_pdf_pages", "status"))
        for key in sorted(data):
            title, revid, timestamp, headings = data[key]
            writer.writerow((candidate_id(key), title, revid, timestamp, "|".join(headings),
                             f"https://en.wiktionary.org/w/index.php?title={title}&oldid={revid}",
                             "|".join(str(page) for page in sorted(gaps[key])), "candidate_only"))
    print(f"Recorded {len(data)} source revisions; English sections and part-of-speech headings present.")
    print("These are provisional candidates; individual senses, licensing and curriculum claims still need review.")


if __name__ == "__main__":
    main()
