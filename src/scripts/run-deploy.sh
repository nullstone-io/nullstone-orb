#!/usr/bin/env bash

Deploy() {
    CMD="nullstone deploy"
    if [ -n "${PARAM_STACK}" ]; then
        CMD="${CMD} --stack=${PARAM_STACK}"
    fi
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

Deploy
