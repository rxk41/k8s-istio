#!/usr/bin/env bash

set -euo pipefail

ISTIO_VERSION="${ISTIO_VERSION:-1.28.0}"

echo "Installing Istio ${ISTIO_VERSION}"

curl -L https://istio.io/downloadIstio | ISTIO_VERSION="${ISTIO_VERSION}" sh -

cd "istio-${ISTIO_VERSION}"

export PATH="${PWD}/bin:${PATH}"

istioctl version

istioctl install \
  --set profile=default \
  --skip-confirmation

kubectl get pods -n istio-system

echo "Istio installation completed."
