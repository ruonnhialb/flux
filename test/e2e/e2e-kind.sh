#!/usr/bin/env bash

# Install the `kind` executable, and with that, construct a Kubernetes
# cluster in docker. This is necessary before it's possible to source
# `e2e-kube.env`, since that uses `kind`.

set -o errexit

source $(dirname $0)/e2e-paths.env

echo ">>> Installing kubectl to $TOOLBIN"
if ! [ -f "$TOOLBIN/kubectl" ]; then
    curl -sLO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x kubectl
    mv kubectl $TOOLBIN/
fi

echo ">>> Building sigs.k8s.io/kind into $GOBIN/"
if ! [ -f "$GOBIN/kind" ]; then
    go get sigs.k8s.io/kind
fi

echo ">>> Creating kind cluster"
if [ "$(kind get cluster | grep kind)" == "kind" ]; then
    kind create cluster --wait 5m
fi

export KUBECONFIG="$(kind get kubeconfig-path --name="kind")"
kubectl get pods --all-namespaces
