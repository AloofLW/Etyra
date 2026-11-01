#!/usr/bin/env python3
"""Record source revisions for unresolved complex-form fragments."""

import argparse
import csv
import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path
from urllib.parse import urlencode

from build_candidate_inventory import candidate_id
from build_complex_gap_candidates import ROOT, existing_keys, fragments
from compare_curriculum_pilot import EXPECTED_PDF_SHA256, SIMPLE_ENTRY, extract_entries

ENGLISH = re.compile(r"(?ms)^==English==\s*$(.*?)(?=^==[^=\n]+==\s*$|\Z)")
HEADINGS = re.compile(r"^={3,5}\s*(Verb|Phrase|Preposition|Adverb|Noun|Determiner|Conjunction|Adjective)\s*={3,5}\s*$", re.M)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("pdf", type=Path, help="Pinned unverified curriculum mirror")
    parser.add_argument("wiktionary_json", type=Path, help="MediaWiki query response with English revision content")
    parser.add_argument("output", type=Path, help="New CSV output; existing files are not overwritten")
    args = parser.parse_args()
    with args.pdf.open("rb") as source:
        digest = hashlib.file_digest(source, "sha256").hexdigest()
    if digest != EXPECTED_PDF_SHA256:
        parser.error(f"Unexpected PDF SHA-256: {digest}")

    known = existing_keys()
    with (ROOT / "docs/COMPLEX_FORM_CANDIDATES.csv").open(encoding="utf-8", newline="") as source:
        known.update(row["normalized_key"] for row in csv.DictReader(source))
    gaps = defaultdict(lambda: {"pages": set(), "forms": set()})
    for page, entry in extract_entries(args.pdf):
        if SIMPLE_ENTRY.fullmatch(entry):
            continue
        for value in fragments(entry):
            key = value.casefold()
            if key not in known:
                gaps[key]["pages"].add(page)
                gaps[key]["forms"].add(value)

    with args.wiktionary_json.open(encoding="utf-8") as source:
        query = json.load(source)["query"]
    redirects = {item["from"].casefold(): item["to"] for item in query.get("redirects", [])}
    pages = {page["title"].casefold(): page for page in query["pages"].values() if "missing" not in page}
    rows = []
    missing = []
    for key, group in sorted(gaps.items()):
        title = redirects.get(key, sorted(group["forms"])[0])
        page = pages.get(title.casefold())
        if page is None:
            missing.append(key)
            continue
        revision = page["revisions"][0]
        match = ENGLISH.search(revision["slots"]["main"]["*"])
        if not match:
            raise ValueError(f"No English section for {title}")
        headings = sorted(set(HEADINGS.findall(match.group(1))))
        if not headings:
            raise ValueError(f"No supported English part-of-speech heading for {title}")
        url = "https://en.wiktionary.org/w/index.php?" + urlencode({"title": page["title"], "oldid": revision["revid"]})
        rows.append((candidate_id(key), key, "|".join(sorted(group["forms"])), page["title"],
                     revision["revid"], revision["timestamp"], "|".join(headings), url,
                     "|".join(map(str, sorted(group["pages"]))), "candidate_only"))
    if len(gaps) != 10 or len(rows) != 9 or missing != ["before the common era"]:
        raise ValueError(f"Unexpected remaining fragments: gaps={len(gaps)} rows={len(rows)} missing={missing}")

    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "normalized_key", "mirror_forms", "source_title", "source_revision",
                         "source_timestamp_utc", "english_headings", "source_url", "mirror_pdf_pages", "status"))
        writer.writerows(rows)
    print(f"Recorded {len(rows)} Wiktionary revision candidates; {len(missing)} expansion requires separate review.")
    print("Mirror authenticity, source senses, redirects and curriculum relevance remain unverified.")


if __name__ == "__main__":
    main()
