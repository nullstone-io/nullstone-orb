#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# shellcheck source=./src/scripts/install.sh
source "${SCRIPT_DIR}/install.sh"
Install
