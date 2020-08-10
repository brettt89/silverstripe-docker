#!/bin/bash
set -euo pipefail

OUTPUT=${OUTPUT:-/dev/stdout}

IMAGE=${IMAGE-localrepo/silverstripe-web}

TAG=${1:-7.4-apache-buster}

TMP_BUILD_DIR=$(mktemp -d)
TMP_DOCKERFILE="${TMP_BUILD_DIR%/}/Dockerfile"

DOCKER_BUILD_ARGS="--build-arg TAG=${TAG}"

function add_file() {
    local FILE=$1
    local CONTENT=""
    if [ -f "${FILE}" ] ; then
        CONTENT=$(cat "${FILE}")
        printf "%s\n" "${CONTENT}" >> "${TMP_DOCKERFILE}"
    fi
}

function cleanup() {
    rm -rf "$TMP_BUILD_DIR" || true
}

# Remove any old file
rm -f "${TMP_DOCKERFILE}" || true

if [[ "${TAG}" =~ alpine ]] ; then
    TEMPLATE_DIR="src/alpine"
else
    TEMPLATE_DIR="src/debian"
fi

# Add base template (override existing file)
add_file "src/Dockerfile"

# Add PHP configurations
add_file "${TEMPLATE_DIR}/Dockerfile.php.tpl"

if [[ "${TAG}" =~ apache ]] ; then
    add_file "${TEMPLATE_DIR}/Dockerfile.apache.tpl"
fi

if [[ "${TAG}" =~ 7.4 ]] ; then
    DOCKER_BUILD_ARGS="${DOCKER_BUILD_ARGS} --build-arg GD_BUILD_ARGS="
fi

echo "Building image: '${IMAGE}:${TAG}'"
cat "${TMP_DOCKERFILE}" > "${OUTPUT}"
docker build -t "${IMAGE}:${TAG}" ${DOCKER_BUILD_ARGS} "${TMP_BUILD_DIR%/}" > "${OUTPUT}"

# If we got this far, then all good. remove log.
rm -f build.log || true

trap cleanup EXIT