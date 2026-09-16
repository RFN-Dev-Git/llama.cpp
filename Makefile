.PHONY: help install run cli health clean
.DEFAULT_GOAL := help

LLAMA ?= ~/.llama-app/llama
MODEL ?= Qwen/Qwen3-1.7B-GGUF
HOST  ?= 127.0.0.1
PORT  ?= 8060


help: ## Show available commands
	@echo "llama.cpp — available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Configuration:"
	@echo "  LLAMA = $(LLAMA)"
	@echo "  MODEL = $(MODEL)"
	@echo "  HOST  = $(HOST)"
	@echo "  PORT  = $(PORT)"


install: ## Install llama.cpp via llama.app
	curl -LsSf https://llama.app/install.sh | sh


run: ## Start the llama.cpp server
	$(LLAMA) serve \
		-hf $(MODEL) \
		--host $(HOST) \
		--port $(PORT)


cli: ## Run llama.cpp with the CLI
	$(LLAMA) cli -hf $(MODEL)


health: ## Check server health
	curl -s http://$(HOST):$(PORT)/health


clean: ## Remove llama.app installation
	rm -rf ~/.llama-app
