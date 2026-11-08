#!/usr/bin/env python3
"""Attach editorial context to component clues without approving relations."""
import argparse
import csv
from pathlib import Path

DOCS = Path(__file__).resolve().parents[2] / "docs"


def read(name):
    with (DOCS / name).open(encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    components = read("MORPHOLOGY_COMPONENT_REVIEW_INDEX.csv")
    reviews = read("MORPHOLOGY_CONTEXT_REVIEW_PILOT.csv")
    contexts = {r["source_row"]: r for r in reviews}
    if len(contexts) != len(reviews):
        raise ValueError("Duplicate context review source row")
    seen = set()
    columns = list(components[0]) + ["context_class", "context_summary_zh", "context_review_status"]
    with args.output.open("x", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=columns, lineterminator="\n")
        writer.writeheader()
        for component in components:
            row = dict(component)
            context = contexts.get(component["source_row"])
            if context:
                if (context["candidate_id"] != component["word_candidate_id"]
                        or context["headword"] != component["headword"]
                        or context["revision_id"] != component["revision_id"]
                        or context["etymology_heading"] != component["etymology_heading"]
                        or context["revision_url"] != component["revision_url"]):
                    raise ValueError(f"Context mismatch at source row {component['source_row']}")
                seen.add(component["source_row"])
                row.update(context_class=context["context_class"],
                           context_summary_zh=context["context_summary_zh"],
                           context_review_status=context["status"])
            else:
                row.update(context_class="", context_summary_zh="", context_review_status="not_reviewed")
            writer.writerow(row)
    if seen != set(contexts):
        raise ValueError("Context review without matching component")
    print(f"Indexed {len(components)} components, {len(seen)} context-reviewed clues; none approved.")


if __name__ == "__main__":
    main()
