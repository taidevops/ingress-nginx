#!/bin/bash

if [ -n "$DEBUG" ]; then
  set -x
fi

set -o errexit
set -o nounset
set -o pipefail

# temporal directory for the /etc/ingress-controller directory
INGRESS_VOLUME=$(mktemp -d)

PKG=k8s.io/ingress-nginx
ARCH=${ARCH:-}
if [[ -z "${ARCH}" ]]; then
  ARCH=$(go env GOARCH)
fi