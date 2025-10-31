# DATASET_CARD

This project uses web documents (or structured text) with body content for SFT and evaluation.

## Recommended Columns
- `title`: document title (string)
- `content`: document body (string; consider stripping HTML tags)
- `gold_quality`: binary ground truth for quality (0/1)
- `quality_pred`: model or rule prediction (0/1)
- `summary`: target extractive summary (string)
- `features`: JSON string like `{"tag": "...", "topic": "..."}`

## Generated Artifacts
- `v1.jsonl`: SFT dataset (`instruction` / `input` / `output`)
- `eval_*.tsv`: evaluation outputs (quality / summary / features)
- Aggregated tables and figures: see `EVAL.md` (and `figures/`).

> Ensure data is anonymized and compliant before publishing.