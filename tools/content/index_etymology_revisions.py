#!/usr/bin/env python3
"""Index revision metadata for existing Wiktionary etymology candidates."""

import argparse
import csv
import json
import re
from pathlib import Path
from urllib.parse import urlencode

ROOT = Path(__file__).resolve().parents[2]
ENGLISH = re.compile(r"(?ms)^==English==\s*$(.*?)(?=^==[^=\n]+==\s*$|\Z)")
ETYMOLOGY = re.compile(r"^={3,5}\s*(Etymology(?:\s+\d+)?)\s*={3,5}\s*$", re.M)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("api_json", type=Path, help="List of MediaWiki API query responses with revision content")
    parser.add_argument("output", type=Path, help="New CSV output; an existing file is never overwritten")
    args = parser.parse_args()

    with (ROOT / "docs/WORD_CANDIDATES_V0_1.csv").open(encoding="utf-8", newline="") as source:
        candidates = list(csv.DictReader(source))
    with args.api_json.open(encoding="utf-8") as source:
        batches = json.load(source)
    pages = {}
    aliases = {}
    for batch in batches:
        query = batch["query"]
        for alias in query.get("normalized", []) + query.get("redirects", []):
            aliases[alias["from"]] = alias["to"]
        for page in query["pages"]:
            if "missing" in page or page["title"] in pages:
                raise ValueError(f"Missing or duplicated page: {page['title']}")
            pages[page["title"]] = page

    rows = []
    seen = set()
    for candidate in candidates:
        title = candidate["word_candidate"]
        visited = set()
        while title in aliases:
            if title in visited:
                raise ValueError(f"Circular redirect: {title}")
            visited.add(title)
            title = aliases[title]
        if title not in pages:
            raise ValueError(f"Source page not found in API response: {title}")
        page = pages[title]
        revision = page["revisions"][0]
        content = revision["slots"]["main"]["content"]
        english = ENGLISH.search(content)
        sections = ETYMOLOGY.findall(english.group(1)) if english else []
        url = "https://en.wiktionary.org/w/index.php?" + urlencode({"title": title, "oldid": revision["revid"]})
        if candidate["candidate_id"] in seen:
            raise ValueError(f"Duplicate candidate ID: {candidate['candidate_id']}")
        seen.add(candidate["candidate_id"])
        rows.append((candidate["candidate_id"], candidate["word_candidate"], candidate["root_candidate_id"], title,
                     revision["revid"], revision["timestamp"], revision["sha1"], "|".join(sections), url,
                     "source_located_relation_unreviewed"))
    with args.output.open("x", encoding="utf-8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("word_candidate_id", "word_candidate", "root_candidate_id", "source_title", "revision_id",
                         "revision_timestamp_utc", "revision_sha1", "english_etymology_headings", "revision_url", "status"))
        writer.writerows(rows)
    print(f"Indexed {len(rows)} source revisions; {sum(bool(row[7]) for row in rows)} have an English etymology heading.")
    print("A heading alone does not verify a candidate morphological relation.")


if __name__ == "__main__":
    main()
