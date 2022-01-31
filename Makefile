.DEFAULT_GOAL:=help

.EXPORT_ALL_VARIABLES:

ifndef VERBOSE
.SILENT:
endif

# set default shell
SHELL=/bin/bash -o pipefail -o errexit

# Use the 0.0 tag for testing, it shouldn't clobber any release builds
TAG ?= $(shell cat TAG)

REPO_INFO ?= $(shell git config --get remote.origin.url)
COMMIT_SHA ?= git-$(shell git rev-parse --short HEAD)
BUILD_ID ?= "UNSET"

PKG = k8s.io/ingress-nginx

HOST_ARCH = $(shell which go >/dev/null 2>&1 && go env GOARCH)

# set default shell
SHELL=/bin/bash -o pipefail -o errexit

.PHONY: image
image: clean-image ## Build image for a particular arch.
	echo "Building docker image ($(ARCH))..."
	@docker build \
		--no-cache \
		--build-arg BASE_IMAGE="$(BASE_IMAGE)" \
		--build-arg VERSION="$(TAG)" \
		--build-arg TARGETARCH="$(ARCH)" \
		--build-arg COMMIT_SHA="$(COMMIT_SHA)" \
		--build-arg BUILD_ID="$(BUILD_ID)" \
		-t $(REGISTRY)/controller:$(TAG) rootfs

.PHONY: clean-image
clean-image: ## Removes local image
	echo "removing old image $(REGISTRY)/controller:$(TAG)"
	@docker rmi -f $(REGISTRY)/controller:$(TAG) || true

.PHONY: show-version
show-version:
	echo -n $(TAG)