# Pre-validation for the aws-demo sandbox definition.
# Run `make` (or `make validate`) before pushing / registering in the UI.
# Catches YAML, Ansible, and JSON errors locally so the UI build only has to
# surface AWS-specific issues (AMI/flavor/subnet).

PLAYBOOK := provisioning/playbook.yml
YAML_FILES := topology.yml variables.yml $(PLAYBOOK) provisioning/requirements.yml
JSON_FILES := training.json

.DEFAULT_GOAL := validate

.PHONY: validate yaml ansible-syntax ansible-lint json tools

validate: tools yaml json ansible-syntax ansible-lint ## Run all pre-validation checks
	@echo "✅ aws-demo definition passed pre-validation."

tools: ## Verify required tools are installed
	@for t in yamllint ansible-playbook ansible-lint jq; do \
		command -v $$t >/dev/null 2>&1 || { echo "❌ missing tool: $$t"; exit 1; }; \
	done

yaml: ## Lint all YAML files
	@echo "── yamllint ──"
	@yamllint -c .yamllint.yml $(YAML_FILES)

json: ## Validate training.json is well-formed JSON
	@echo "── json (training.json) ──"
	@for f in $(JSON_FILES); do jq empty "$$f" && echo "ok: $$f"; done

ansible-syntax: ## Ansible syntax check on the provisioning playbook
	@echo "── ansible --syntax-check ──"
	@ansible-playbook $(PLAYBOOK) --syntax-check

ansible-lint: ## Lint the provisioning playbook
	@echo "── ansible-lint ──"
	@ansible-lint $(PLAYBOOK)

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN{FS=":.*?## "}{printf "  %-16s %s\n", $$1, $$2}'
