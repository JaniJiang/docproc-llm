# docproc-llm
End-to-end pipeline for multimodal web document understanding with Qwen2.5-VL: offline HTML restore → full-page screenshot → VLM inference (summary/quality/features) → SFT dataset → evaluation. Includes demo, Makefile, sample YAML, metrics and figures.

# DocProc-LLM: Web Document Parsing & SFT Toolkit (Qwen2.5-VL)

[![Python 3.9+](https://img.shields.io/badge/Python-3.9%2B-blue)](#)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.x-red)](#)
[![ModelScope-Qwen2.5-VL](https://img.shields.io/badge/ModelScope-Qwen2.5--VL-green)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-black)](./LICENSE)

An end-to-end pipeline for **multimodal web document understanding** with **Qwen2.5-VL-7B**:

**offline HTML restore → full-page screenshot (Base64) → VLM inference (summary / quality / features) → SFT dataset → evaluation**.

---

## Features
- **Offline HTML restore** for cleaner, readable inputs
- **HTML → image** via Playwright + Chromium (full-page screenshot as Base64)
- **Unified inference wrapper** (`qwen_vl_predict`) for templating/decoding/parsing
- **SFT dataset builder** (TSV → `instruction` / `input` / `output` JSONL)
- **Evaluation script** (HTTP inference → results written back to TSV)
- **Batteries included**: demo script, Makefile, and a sample YAML for LLaMA-Factory

---

## Repository Layout
```
.
├── const.py
├── html_utils.py
├── image_utils.py
├── llm_utils.py
├── llm_demo.py
├── meta.py
├── step1_process_data.py
├── step2_eval_data.py
├── EVAL.md
├── examples/
│   └── docproc_sft_qwen.yaml
├── figures/
│   └── fig_chunks_hist.png
├── data/
│   └── README.md
├── requirements.txt
├── Makefile
├── LICENSE
└── .gitignore
```

---

## Quickstart
```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt

# Install Chromium for Playwright
python -m playwright install chromium
# On Linux you may also need: python -m playwright install-deps
```

### Run the Demo
```bash
# Set `model_name_or_path` in llm_demo.py (local weights or Hub name)
python llm_demo.py
```

> If you do not use the Chromium that ships with Playwright, set `CHROMIUM_PATH` in `const.py` to the path of your local executable.

---

## Data & Training

### 1) Build SFT JSONL
```bash
python step1_process_data.py
# Output: data/cloud_share/mcp_tools/doc_process/train_model/v1.jsonl
```
Each JSONL line contains `instruction` / `input` / `output` and can be consumed by LLaMA-Factory or TRL.

### 2) Train (Example)
- **CLI (recommended)**
```bash
llamafactory-cli train \
  --stage sft \
  --model_name_or_path Qwen/Qwen2.5-7B \
  --dataset_dir data/cloud_share/mcp_tools/doc_process/train_model \
  --dataset v1.jsonl \
  --output_dir outputs/qwen2_5_7b_docproc_sft \
  --per_device_train_batch_size 2 \
  --gradient_accumulation_steps 8 \
  --save_steps 200 \
  --num_train_epochs 3
```
- **YAML**: see `examples/docproc_sft_qwen.yaml` and adjust to your LLaMA-Factory version.

---

## Evaluation & Results
```bash
python step2_eval_data.py
# Uses `llm_config` in meta.py to call your HTTP inference service and writes results back to TSV
```
- Key metrics and figures are summarized in **[EVAL.md](./EVAL.md)**.
- If your Excel data includes a ground-truth column (e.g., `gold_quality`) and a prediction column (e.g., `quality_pred`), the repo can also produce accuracy and confusion-matrix counts automatically.

**Current metrics snapshot**: KUC=0.0049, features_coverage=0.0217, docs_with_chunks=92, avg_chunks_per_doc=1.39

---

## Key Scripts
- `html_utils.py`: `OfflineHTMLRestorer`, offline HTML structure/style enhancement
- `image_utils.py`: `html_to_base64_image`, full-page HTML screenshot to Base64
- `llm_utils.py`: `qwen_vl_predict`, Qwen2.5-VL inference wrapper
- `step1_process_data.py`: TSV → JSONL (SFT data)
- `step2_eval_data.py`: HTTP evaluation → write back to TSV
- `meta.py`: unified prompt templates and `llm_config` (service URL mapping)

---

## Roadmap
- [ ] Auto-summaries for ROUGE/BERTScore/EM and dashboards
- [ ] Quality confusion matrix and calibration plots
- [ ] One-click export of CSV/PNG/HTML evaluation artifacts
- [ ] Web UI: upload → restore/screenshot → inference

---

## Contributing
PRs and issues are welcome. Please include a minimal reproducible example and environment details.

---

## License
MIT — see [LICENSE](./LICENSE).
