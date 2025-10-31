# Evaluation Report

This report summarizes the uploaded evaluation artifacts (spreadsheets, per-document stats, and JSON metrics). It is ready to be committed to the repository.

## Data Sources
- 1023.xlsx
- 分析结果1.xlsx
- 分析结果2.xlsx
- 分析结果3.xlsx
- chunk_eval_metrics.json
- chunk_eval_per_doc.csv

## Chunk-level Metrics (`chunk_eval_metrics.json`)
- **docs_with_chunks**: 92
- **key_unit_covered**: 2
- **key_unit_total**: 410
- **KUC**: 0.0049
- **features_coverage**: 0.0217
- **avg_need_chunks**: 2.043
- **waste_ratio**: 0.0
- **avg_chunk_len**: 10.8
- **avg_chunks_per_doc**: 1.39

## Quality Classification
No reliable ground-truth/prediction column pair was detected (or the sample is insufficient), so accuracy is not reported yet. Add columns like `gold_quality` and `quality_pred` to enable this section.
