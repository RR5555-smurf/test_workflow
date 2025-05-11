.DEFAULT_GOAL := help
NAME ?= 'test_workflow'

docker-build: ## Build the Docker container
	docker build -t $(NAME) -f ./Docker/Dockerfile .


docker-run: ## Run the Docker container
	docker run --rm -it -v .:/root/test_workflow \
	--name $(NAME) $(NAME)



docker-bash: ## Access container bash
	docker exec -it $(NAME) /bin/bash

dev-install: ## uv sync
	uv sync --all-groups

lint: ## Run linter [dev]
	uv run ruff check .

format: ## Run formatter [dev]
	uv run ruff format --diff .

tox-rerun: ## Launch Tox [dev, tox]
	uv run tox --parallel

tox-run: ## Launch Tox [dev, tox]
	uv run tox -r --parallel

pre-commit: ## Run pre-commit
	uv run pre-commit run --all-files --show-diff-on-failure

pre-commit-enforce: ## Install the pre-commit as a git hook (you can just run pre-commit without doing that by: `make pre-commit`)
	uv run pre-commit install

update-pre-commit-hooks: ## Update automatically the hooks for `pre-commit`
	uv run pre-commit autoupdate

gitlint: ## Call gitlint `pre-commit` hook on last git commit msg
	pre-commit run gitlint --hook-stage commit-msg --commit-msg-filename .git/COMMIT_EDITMSG

commitizen-check: ## Call commitizen check `pre-commit` hook on last git commit msg
	pre-commit run commitizen --hook-stage commit-msg --commit-msg-filename .git/COMMIT_EDITMSG

commit-check: ## Semantic/Conventional commits check
	$(MAKE) commitizen-check
	$(MAKE) gitlint

pre-commit-msg: ## Install `commit-msg`-stage pre-commit hooks
	pre-commit install --hook-type commit-msg


semver: ## Display SemVer for current pkg
	uv run cz bump --dry-run

tag: ## Prompt for running git tag with next SemVer
	uv run cz bump --dry-run
	@echo "---"
	@VERSION="$(shell uv run cz bump --dry-run --get-next)"; while true; do echo "Do you want to:\n\`git tag -a \"v$$VERSION\" -m \"Release v$$VERSION\"\`? [Yn]"; read yn; yn=$${yn:-Y}; case $$yn in [Yy]*) git tag -a "v$$VERSION" -m "Release v$$VERSION"; break;; [Nn]*) exit;; *) echo "Please answer yes or no.";; esac; done

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
