files = async_lm test *.py
test_files = *

# For local development
test:
	pytest -s -v test/test_$(test_files).py --doctest-modules --cov async_lm --cov-config=.coveragerc --cov-report term-missing

# For github actions
test-ci:
	pytest -s -v test/test_$(test_files).py --doctest-modules --cov async_lm --cov-config=.coveragerc --cov-report=xml

lint:
	@echo "Running ruff..."
	@ruff check $(files)
	@echo "Running mypy..."
	@mypy $(files)

fix:
	ruff check --fix $(files)

install:
	pip install -U .[dev]

install-all:
	pip install -U .[dev,doc]

report:
	codecov

build: async_lm
	rm -rf dist
	python -m build

publish:
	make build
	twine upload --config-file ~/.pypirc -r pypi dist/*

.PHONY: test build
