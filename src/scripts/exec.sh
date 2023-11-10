#!/usr/bin/env bash

Exec() {
    CMD="nullstone exec"
    if [ -n "${PARAM_STACK}" ]; then
        CMD="${CMD} --stack=${PARAM_STACK}"
    fi
    if [ -n "${PARAM_APP}" ]; then
        CMD="${CMD} --app=${PARAM_APP}"
    fi
    if [ -n "${PARAM_ENV}" ]; then
        CMD="${CMD} --env=${PARAM_ENV}"
    fi
    if [ -n "${PARAM_COMMAND}" ]; then
        CMD="${CMD} ${PARAM_COMMAND}"
    fi
    echo "[Running] ${CMD}"
    echo ""
    eval "${CMD}"
}
