#!/bin/bash -e

pushd "$(dirname "${BASH_SOURCE[0]}")"
source ./push.sh
popd

Push
