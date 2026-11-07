#!/usr/bin/env python3
"""Index explicit English morphology templates as unreviewed source clues.

Template components do not establish a root relationship, historical origin,
or an appropriate learning item. Nested templates are deliberately excluded.
"""
import argparse
import csv
import json
import re
from pathlib import Path

from build_vocabulary_review_queue import read
from index_vocabulary_etymology import ENGLISH

HEADING = re.compile(r"^(={3,5})\s*(.*?)\s*\1\s*$", re.M)
TEMPLATE = re.compile(r"\{\{(af|affix|prefix|suffix|compound)\|en\|([^{}\n]*)\}\}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("cache", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--index", type=Path, help="Index for this cached batch; defaults to the complete repository index")
    args = parser.parse_args()
    if args.index:
        with args.index.open(encoding="utf8", newline="") as source:
            index = list(csv.DictReader(source))
    else:
        index = read("WIKTIONARY_BULK_SOURCE_INDEX.csv")
    pages = {}
    for path in sorted(args.cache.glob("batch-*.json")):
        checkpoint = json.loads(path.read_text(encoding="utf8"))
        for page in checkpoint["response"]["query"]["pages"]:
            revision = page.get("revisions", [{}])[0]
            if revision.get("revid"):
                pages[(page["title"], str(revision["revid"]))] = revision
    rows = set()
    for item in index:
        if not item["revision_id"]:
            continue
        key = (item["source_title"], item["revision_id"])
        if key not in pages or pages[key].get("sha1") != item["revision_sha1"]:
            raise ValueError(f"Missing or changed cached revision: {key}")
        content = pages[key].get("slots", {}).get("main", {}).get("content", "")
        english = ENGLISH.search(content)
        if not english:
            continue
        body = english.group(1)
        headings = list(HEADING.finditer(body))
        for i, heading in enumerate(headings):
            title = heading.group(2)
            if not re.fullmatch(r"Etymology(?:\s+\d+)?", title):
                continue
            level = len(heading.group(1))
            end = len(body)
            for following in headings[i + 1:]:
                if len(following.group(1)) <= level:
                    end = following.start()
                    break
            for match in TEMPLATE.finditer(body[heading.end():end]):
                parts = [part.strip() for part in match.group(2).split("|") if "=" not in part]
                if len(parts) < 2 or any(not p or re.search(r"[\[\]{}<>]", p) for p in parts):
                    continue
                rows.add((item["candidate_id"], item["headword"], item["source_title"], item["revision_id"],
                          title, match.group(1), json.dumps(parts, ensure_ascii=False), item["revision_url"],
                          "morphology_clue_unreviewed"))
    with args.output.open("x", encoding="utf8", newline="") as output:
        writer = csv.writer(output, lineterminator="\n")
        writer.writerow(("candidate_id", "headword", "source_title", "revision_id", "etymology_heading",
                         "template", "components_json", "revision_url", "status"))
        writer.writerows(sorted(rows))
    print(f"Extracted {len(rows)} morphology clues for {len({r[0] for r in rows})} candidates.")
    print("Each clue requires human verification; no root relation is approved.")


if __name__ == "__main__":
    main()
