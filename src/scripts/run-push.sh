#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/push.sh"

Push
