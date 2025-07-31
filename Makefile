# ----------------------------
# Makefile for TreeTimer project
# ----------------------------

VENV_DIR := .venv
PYTHON_VERSION := 3.11
PYTHON := $(VENV_DIR)/bin/python
RUFF := uv run ruff
MYPY := uv run mypy

# ----------------------------
# Setup
# ----------------------------

.PHONY: setup
setup:
	@echo "Creating virtual environment..."
	uv venv --python=${PYTHON_VERSION}
	@echo "Installing dependencies..."
	uv pip install -e .[dev]
	@echo "Environment setup complete"

# ----------------------------
# Quality Checks
# ----------------------------

.PHONY: check
check:
	@echo "Running format check..."
	${RUFF} format .
	@echo "Running lint check..."
	$(RUFF) check .
	@echo "Running type check..."
	$(MYPY) .

.PHONY: test
test:
	$(PYTHON) -m pytest tests


# ----------------------------
# Run Examples
# ----------------------------

.PHONY: run-examples
run-examples:
	@echo "Running example 1: simple.py"
	$(PYTHON) examples/simple.py
	@echo "\nRunning example 2: nested_scope.py"
	$(PYTHON) examples/nested_scope.py
	@echo "\nRunning example 3: series_loop.py"
	$(PYTHON) examples/series_loop.py
	@echo "\nRunning example 4: combined_parallel.py"
	$(PYTHON) examples/combined_parallel.py

# ----------------------------
# Build & Publish
# ----------------------------

.PHONY: build
build:
	uv build
	@echo "Build complete"

.PHONY: publish
publish: build
	@echo "Publishing to PyPI..."
	uv publish --token=$(PYPI_TOKEN)

# ----------------------------
# Clean
# ----------------------------

.PHONY: clean
clean:
	rm -rf dist/ build/ *.egg-info .mypy_cache .ruff_cache .pytest_cache
	@echo "Cleaned build and cache files"

# ----------------------------
# All-in-One
# ----------------------------

.PHONY: all
all: clean setup check test build
