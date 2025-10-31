# Makefile
.PHONY: help install playwright demo sft eval fmt

help:
	@echo "Targets:"
	@echo "  install     - Create venv and install requirements"
	@echo "  playwright  - Install Chromium for Playwright"
	@echo "  demo        - Run the multimodal demo"
	@echo "  sft         - Run SFT with LLaMA-Factory CLI (example)"
	@echo "  eval        - Run evaluation script over test data"
	@echo "  fmt         - Format Python code with ruff/black (if installed)"

install:
	python -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt

playwright:
	. .venv/bin/activate && python -m playwright install chromium

demo:
	. .venv/bin/activate && python llm_demo.py

sft:
	# Example: ensure LLaMA-Factory is installed and on PATH
	llamafactory-cli train examples/docproc_sft_qwen.yaml || true

eval:
	. .venv/bin/activate && python step2_eval_data.py

fmt:
	-ruff check --fix .
	-black .
