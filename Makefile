# provide JUSTFLAGS for just-backed targets
include ./justfiles/flags.mk

# Requires at least Python v3.9; specify a minor version below if needed
PYTHON?=python3

help: ## Prints this help message
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: build-go build-contracts ## Builds Go components and contracts-theweb3Chain
.PHONY: build

build-go: submodules dn-node dn-deployer## Builds dn-node and dn-deployer
.PHONY: build-go

build-contracts:
	(cd packages/contracts-dn-chain && just build)
.PHONY: build-contracts

lint-go: ## Lints Go code with specific linters
	golangci-lint run -E goimports,sqlclosecheck,bodyclose,asciicheck,misspell,errorlint --timeout 5m -e "errors.As" -e "errors.Is" ./...
	golangci-lint run -E err113 --timeout 5m -e "errors.As" -e "errors.Is" ./dn-program/client/...
.PHONY: lint-go

lint-go-fix: ## Lints Go code with specific linters and fixes reported issues
	golangci-lint run -E goimports,sqlclosecheck,bodyclose,asciicheck,misspell,errorlint --timeout 5m -e "errors.As" -e "errors.Is" ./... --fix
.PHONY: lint-go-fix

golang-docker: ## Builds Docker images for Go components using buildx
	# We don't use a buildx builder here, and just load directly into regular docker, for convenience.
	GIT_COMMIT=$$(git rev-parse HEAD) \
	GIT_DATE=$$(git show -s --format='%ct') \
	IMAGE_TAGS=$$(git rev-parse HEAD),latest \
	docker buildx bake \
			--progress plain \
			--load \
			-f docker-bake.hcl \
			dn-node dn-supervisor
.PHONY: golang-docker

docker-builder-clean: ## Removes the Docker buildx builder
	docker buildx rm buildx-build
.PHONY: docker-builder-clean

docker-builder: ## Creates a Docker buildx builder
	docker buildx create \
		--driver=docker-container --name=buildx-build --bootstrap --use
.PHONY: docker-builder

# add --print to dry-run
cross-dn-node: ## Builds cross-platform Docker image for dn-node
	# We don't use a buildx builder here, and just load directly into regular docker, for convenience.
	GIT_COMMIT=$$(git rev-parse HEAD) \
	GIT_DATE=$$(git show -s --format='%ct') \
	IMAGE_TAGS=$$(git rev-parse HEAD),latest \
	PLATFORMS="linux/arm64" \
	GIT_VERSION=$(shell tags=$$(git tag --points-at $(GITCOMMIT) | grep '^dn-node/' | sed 's/dn-node\///' | sort -V); \
             preferred_tag=$$(echo "$$tags" | grep -v -- '-rc' | tail -n 1); \
             if [ -z "$$preferred_tag" ]; then \
                 if [ -z "$$tags" ]; then \
                     echo "untagged"; \
                 else \
                     echo "$$tags" | tail -n 1; \
                 fi \
             else \
                 echo $$preferred_tag; \
             fi) \
	docker buildx bake \
			--progress plain \
			--builder=buildx-build \
			--load \
			--no-cache \
			-f docker-bake.hcl \
			dn-node
.PHONY: cross-dn-node

contracts-theweb3Chain-docker: ## Builds Docker image for Bedrock contracts
	IMAGE_TAGS=$$(git rev-parse HEAD),latest \
	docker buildx bake \
			--progress plain \
			--load \
			-f docker-bake.hcl \
		  contracts-theweb3Chain
.PHONY: contracts-theweb3Chain-docker

submodules: ## Updates git submodules
	git submodule update --init --recursive
.PHONY: submodules


dn-node: ## Builds dn-node binary
	just $(JUSTFLAGS) ./dn-node/dn-node
.PHONY: dn-node

generate-mocks-dn-node: ## Generates mocks for dn-node
	make -C ./dn-node generate-mocks
.PHONY: generate-mocks-dn-node

generate-mocks-dn-service: ## Generates mocks for dn-service
	make -C ./dn-service generate-mocks
.PHONY: generate-mocks-dn-service

dn-deployer: ## Builds dn-deployer binary
	just $(JUSTFLAGS) ./dn-deployer/build
.PHONY: dn-deployer

dn-program: ## Builds dn-program binary
	make -C ./dn-program dn-program
.PHONY: dn-program

reproducible-prestate:   ## Builds reproducible-prestate binary
	make -C ./dn-program reproducible-prestate
.PHONY: reproducible-prestate

mod-tidy: ## Cleans up unused dependencies in Go modules
	# Below GOPRIVATE line allows mod-tidy to be run immediately after
	# releasing new versions. This bypasses the Go modules proxy, which
	# can take a while to index new versions.
	#
	# See https://proxy.golang.org/ for more info.
	export GOPRIVATE="github.com/ethereum-optimism" && go mod tidy
.PHONY: mod-tidy

clean: ## Removes all generated files under bin/
	rm -rf ./bin
	cd packages/contracts-dn-chain/ && forge clean
.PHONY: clean

nuke: clean ## Completely clean the project directory
	git clean -Xdf
.PHONY: nuke

test-unit: ## Runs unit tests for all components
	make -C ./dn-node test
	(cd packages/contracts-dn-chain && just test)
.PHONY: test-unit

# Remove the baseline-commit to generate a base reading & show all issues
semgrep: ## Runs Semgrep checks
	$(eval DEV_REF := $(shell git rev-parse develop))
	SEMGREP_REPO_NAME=/roothash-pay/theweb3-chain semgrep ci --baseline-commit=$(DEV_REF)
.PHONY: semgrep

update-dn-geth: ## Updates the Geth version used in the project
	./ops/scripts/update-dn-geth.py
.PHONY: update-dn-geth
