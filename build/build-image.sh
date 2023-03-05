#!/bin/bash
set -euo pipefail

OUTPUT=${OUTPUT:-/dev/stdout}

IMAGE=${IMAGE-brettt89/silverstripe-web}
TAG=${1:-8.2-apache-bullseye}

DOCKER_BUILD_ARGS="--build-arg TAG=${TAG}"
BUILD_DIR="$(dirname "$(dirname "$(readlink -f "$BASH_SOURCE")")")/src"

declare -a TAG_ARRAY
IFS='-' read -r -a TAG_ARRAY <<< "$TAG"

PHP_VERSION="${TAG_ARRAY[0]:-}"
PACKAGE="${TAG_ARRAY[1]:-}"
DISTRO="${TAG_ARRAY[2]:-}"

if [ -n "${PHP_VERSION}" ]; then
    BUILD_DIR="${BUILD_DIR}/$PHP_VERSION"
fi

if [ -n "${PACKAGE}" ]; then
    BUILD_DIR="${BUILD_DIR}/$PACKAGE"
fi

if [ -n "${DISTRO}" ]; then
    BUILD_DIR="${BUILD_DIR}/$DISTRO"
fi

mkdir -p "${BUILD_DIR}"
DOCKERFILE="${BUILD_DIR%/}/Dockerfile"

function add_file() {
    local FILE=$1
    local CONTENT=""
    if [ -f "${FILE}" ] ; then
        CONTENT=$(cat "${FILE}")
        printf "%s\n" "${CONTENT}" >> "${DOCKERFILE}"
    fi
}

echo "Building image: '${IMAGE}:${TAG}'"
cat "${DOCKERFILE}" > "${OUTPUT}"
docker build -t "${IMAGE}:${TAG}" ${DOCKER_BUILD_ARGS} "${BUILD_DIR%/}" > "${OUTPUT}"

# If we got this far, then all good. remove log.
rm -f "${OUTPUT}" || true
