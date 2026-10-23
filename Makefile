# —— Inspired by ———————————————————————————————————————————————————————————————
# https://www.strangebuzz.com/en/snippets/the-perfect-makefile-for-symfony

# Setup ————————————————————————————————————————————————————————————————————————

# Parameters
SHELL         = bash
ME            = $(shell whoami)

# Executables: local only
DOCKER        = docker
UV_RUN        = uv run
PLAYBOOK      = $(UV_RUN) ansible-playbook -i hosts -c local --limit localhost

# Misc
.DEFAULT_GOAL = build
.PHONY       =  # Not needed here, but you can put your all your targets to be sure
	            # there is no name conflict between your files and your targets.

## —— 🐝 The Strangebuzz Docker Makefile 🐝 ———————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— All 🎵 ———————————————————————————————————————————————————————————————
.PHONY: all
all: clean build

## —— Clean 🧹 ———————————————————————————————————————————————————————————————
.PHONY: clean
clean:
	@echo "=> Cleaning image..."

## —— Install 📦 ———————————————————————————————————————————————————————————————
.PHONY: install
install: ## Install tools (mise), python dependencies (uv) and ansible requirements
	mise install
	mise run install

## —— Ansible 🐝 ————————————————————————————————————————————————————————————————
.PHONY: check-ansible
check-ansible: ## Dry-run the playbook on localhost (no change applied)
	$(PLAYBOOK) --check --diff shell.yml

.PHONY: build-ansible
build-ansible: ## Build workstation with ansible
	@echo "=> Building ansible..."
	$(PLAYBOOK) --diff shell.yml

## —— Build 🚀 —————————————————————————————————————————————————————————————————
.PHONY: build
build: build-ansible

## —— Up ✅ —————————————————————————————————————————————————————————————————
.PHONY: up
up:
	@echo "up"

.PHONY: down
down:
	@echo "down"

.PHONY: run
run: down up

## —— Formating 🧪🔗 ———————————————————————————————————————————————————————————————
.PHONY: fmt
fmt: ## Run formating
	@echo "=> Executing formating..."
	shfmt -i 2 -ci -w *.sh || true
	$(UV_RUN) ansible-lint --write ./

## —— Tests Ansible 🧪🔗 —————————————————————————————————————————————————————————————————
.PHONY: test
test: ## Run all tests
	@echo "=> Testing ansible..."
	$(UV_RUN) yamllint .
	$(UV_RUN) ansible-lint ./
