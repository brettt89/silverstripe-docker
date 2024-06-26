#!/bin/bash
set -euo pipefail

REGEX="${1:-}"

PHP_VERSION_ARRAY=("8.3" "8.2" "8.1")
VARIATION_ARRAY=("apache" "fpm" "cli")
DISTRO_ARRAY=("bookworm" "bullseye" "alpine")

function build() {
    local ARG_VERSION=${1:-}
    local ARG_VARIATION=${2:-}
    local ARG_DISTRO=${3:-}

    local TAG="${ARG_VERSION:-latest}-${ARG_VARIATION:-#}-${ARG_DISTRO:-#}"
    TAG=${TAG%%-#}

    ## If regex is set, then compare this against tag format and skip if not matching
    if [[ -n $REGEX ]] && ! [[ "${TAG//-#/}" =~ $REGEX ]]; then
        return 0
    fi

    OUTPUT=${OUTPUT:-build.log} IMAGE_TAG=${TAG} make build-image
}

function loop() {
    local -n ARG_VERSION_ARRAY=$1
    local -n ARG_VARIATION_ARRAY=$2
    local -n ARG_DISTRO_ARRAY=$3

    for VERSION in "${ARG_VERSION_ARRAY[@]}"; do
        for VARIATION in "${ARG_VARIATION_ARRAY[@]}"; do
            for DISTRO in "${ARG_DISTRO_ARRAY[@]}"; do

                if [ "$DISTRO" == "alpine" ] && [ "$VARIATION" == "apache" ]; then
                    continue
                fi
                
                build "$VERSION" "$VARIATION" "$DISTRO"
            done
        done
    done
}

## Loop over and build images
loop PHP_VERSION_ARRAY VARIATION_ARRAY DISTRO_ARRAY

