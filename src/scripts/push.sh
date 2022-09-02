#!/bin/bash -e

Push() {
    CMD="nullstone push --source=${PARAM_SOURCE}"
    if [ -n "${PARAM_APP}" ]; then
        CMD="${CMD} --app=${PARAM_APP}"
    fi
    if [ -n "${PARAM_ENV}" ]; then
        CMD="${CMD} --env=${PARAM_ENV}"
    fi
    if [ -n "${PARAM_VERSION}" ]; then
        CMD="${CMD} --version=${PARAM_VERSION}"
    fi
    echo "[Running] ${CMD}"
    echo ""
    eval "${CMD}"
}
