lint:
	@uv run ruff check
	@uv run ruff format --check

typecheck:
	@uv run pyrefly check --summarize-errors

tests:
	@uv run pytest -q

ci: lint typecheck tests

.PHONY: lint typecheck tests ci