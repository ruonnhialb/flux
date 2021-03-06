#!/usr/bin/env bash

set -o errexit

source $(dirname $0)/e2e-paths.env
source $(dirname $0)/machine.env

GO_VERSION=1.11.4

echo ">>> Installing go ${GO_VERSION} to $GOBASE/go"
if ! [ -f "go${GO_VERSION}.${OS}-${ARCH}.tar.gz" ]; then
    curl -O https://storage.googleapis.com/golang/go${GO_VERSION}.${OS}-${ARCH}.tar.gz
fi
tar -xf go1.11.4.${OS}-${ARCH}.tar.gz
rm -rf $GOBASE/go
mkdir -p $GOBASE
mv go $GOBASE/

go version
