#!/bin/bash
set -euo pipefail

OUTPUT=${OUTPUT:-/dev/stdout}

IMAGE_TAG=${IMAGE_TAG:-8.3-apache-bookworm}
IMAGE=${IMAGE:-brettt89/silverstripe-web:${IMAGE_TAG}}

BUILD_DIR="$(dirname "$(dirname "$(readlink -f "$BASH_SOURCE")")")/src"

declare -a TAG_ARRAY
IFS='-' read -r -a TAG_ARRAY <<< "$IMAGE_TAG"

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

echo "Building image: '${IMAGE}'"
cat "${DOCKERFILE}" > "${OUTPUT}"
docker build -t "${IMAGE}" \
    --label org.opencontainers.image.revision=${COMMIT} \
    --label org.opencontainers.image.created="$(date --rfc-3339=seconds --utc)" \
    --label org.opencontainers.image.title=${IMAGE_NAME} \
    "${BUILD_DIR%/}" > "${OUTPUT}"

# If we got this far, then all good. remove log.
if [ "${OUTPUT}" != "/dev/stdout" ]; then
    rm -f "${OUTPUT}" || true
fi