#!/bin/bash
set -euo pipefail

LATEST_PHP_VERSION="7.4"
LATEST_DISTRO="apache"
LATEST_PLATFORM="buster"

# Legacy support
LEGACY_PLATFORM="jessie"
LEGACY_VERSIONS=("5.6")
PLATFORM_TAGS=("5.6-platform" "7.1-platform")

IMAGE="brettt89/silverstripe-web"
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="${CUR_DIR%/}/src"

# Log Level
#   s  = Silent
#   w  = Warnings and Errors
#   o  = All logs (default)
LOG_LEVEL=${LOG_LEVEL:-o}

REGEX=${1:-}

error() {
    echo "[Error] ${1:-}"
}

warn() {
    if [ "${LOG_LEVEL}" != "s" ]; then
        echo "[Warning] ${1:-}"
    fi
}

info() {
    if [ "${LOG_LEVEL}" != "s" ] && [ "${LOG_LEVEL}" != "w" ]; then
        echo "[Info] ${1:-}"
    fi
}

elementIn () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

##
# Buld image based on arguments
#
# Parameters
#   1 - PHP version (e.g. 7.4)  (optional)
#   2 - Distro   (e.g. apache)  (optional)
#   3 - Platform (e.g. buster)  (optional)
#
# Example
#   build_image "7.4" "apache" "buster"  # Builds tag "7.4-apache-buster"
build_image() {
    ARG_VERSION=${1:-}
    ARG_DISTRO=${2:-}
    ARG_PLATFORM=${3:-}

    # Parse parameters (if provided) into tag string
    TAG="${ARG_VERSION:-latest}-${ARG_DISTRO:-#}-${ARG_PLATFORM:-#}"
    TAG=${TAG//-#/}

    if ! [ -z $REGEX ] && ! [[ $TAG =~ $REGEX ]]; then
        return 0
    fi

    # Check build directory
    BUILD_DIR="${ROOT_DIR%%/}/${ARG_VERSION:-${LATEST_PHP_VERSION}}/${ARG_DISTRO:-${LATEST_DISTRO}}/${ARG_PLATFORM:-${LATEST_PLATFORM}}"
    if ! [ -d $BUILD_DIR ] && ! [ -z $ARG_PLATFORM ]; then
        warn "Skipping '$BUILD_DIR' is not a valid directory"
        return 0
    fi

    # echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null

    # Legacy support added for 5.6 that doesn't have buster
    elementIn "${ARG_VERSION}" "${LEGACY_VERSIONS[@]}" || true
    if [ $? -eq 0 ] && [ ! -f "${BUILD_DIR%/}/Dockerfile" ]; then
        BUILD_DIR="${ROOT_DIR%%/}/${ARG_VERSION:-${LATEST_PHP_VERSION}}/${ARG_DISTRO:-${LATEST_DISTRO}}/${ARG_PLATFORM:-${LEGACY_PLATFORM}}"
    fi

    # Legacy support for platform builds
    elementIn "${TAG}" "${PLATFORM_TAGS[@]}" || true
    if [ $? -eq 0 ] && [ ! -f "${BUILD_DIR%/}/Dockerfile" ]; then
        BUILD_DIR="${ROOT_DIR%%/}/${ARG_VERSION}/platform"
    fi

    # Check directory for Dockerfile and build
    if [ -f "${BUILD_DIR%/}/Dockerfile" ]; then
        info "Building ${IMAGE}:${TAG}"
        docker build -t "${IMAGE}:${TAG}" "${BUILD_DIR%/}" > "build.log"
        return 0
    else
        error "Unable to find dockerfile for '$TAG', Skipping build"
        return 0
    fi
}

# Check ROOT_DIR to make sure its pointing to a directory
if [ ! -d "$ROOT_DIR" ]; then
    error "${ROOT_DIR} is not a directory"
    return 1
fi

# Build "latest"
build_image

# Main loop checking folder structure
#  - Calls function 'build_image'
for VERSION in ${ROOT_DIR%/}/*/; do
    VERSION=${VERSION%/}
    if [ ! -d "$VERSION" ]; then continue; fi
    build_image ${VERSION##*/}
    for DISTRO in ${VERSION}/*/; do
        DISTRO=${DISTRO%/}
        if [ ! -d $DISTRO ]; then continue; fi
        build_image ${VERSION##*/} ${DISTRO##*/}
        for PLATFORM in ${DISTRO}/*/; do
            PLATFORM=${PLATFORM%/}
            if [ ! -d $PLATFORM ]; then continue; fi
            build_image ${VERSION##*/} ${DISTRO##*/} ${PLATFORM##*/}
        done
    done
done

# Cleanup
rm -f build.log || true

info "Build completed succesfully"