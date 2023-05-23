#!/bin/bash -e

pushd "$(dirname "${BASH_SOURCE[0]}")"
source ./deploy.sh
popd

Deploy
