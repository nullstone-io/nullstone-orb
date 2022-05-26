#!/bin/bash -e

Deploy() {
    CMD="nullstone deploy"
    if [ -n "${PARAM_APP}" ]; then
        CMD="${CMD} --app=${PARAM_APP}"
    fi
    if [ -n "${PARAM_ENV}" ]; then
        CMD="${CMD} --env=${PARAM_ENV}"
    fi
    if [ -n "${PARAM_VERSION}" ]; then
        CMD="${CMD} --version=${PARAM_VERSION}"
    fi
    eval "${CMD}"
}

# Will not run if sourced from another script. This is done so this script may be tested.
# View src/tests for more information.
if [[ "$_" == "$0" ]]; then
    Deploy
fi