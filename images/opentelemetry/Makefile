
.DEFAULT_GOAL:=build

# set default shell
SHELL=/bin/bash -o pipefail -o errexit

DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
INIT_BUILDX=$(DIR)/../../hack/init-buildx.sh

# 0.0.0 shouldn't clobber any released builds
TAG ?= 0.0
REGISTRY ?= gcr.io/k8s-staging-ingress-nginx

