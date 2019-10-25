#!/bin/bash

declare -a oss=("debian")
declare -a platforms=("jessie" "stretch" "buster")
declare -a phpVersions=("7.3" "7.2" "7.1" "5.6")
declare -a defaultPhpVersion="7.3"
declare -a defaultPlatform="buster"
declare -a defaultOS="debian"

for version in "${phpVersions[@]}"
do
    for os in "${oss[@]}"
    do
        for platform in "${platforms[@]}"
        do
            # Build "$Version"-"$OS"-"$Platform"
            if [ -f "${version}/${os}/${platform}/Dockerfile" ]; then
                echo "### Building brettt89/silverstripe-web:${version}-${os}-${platform} ###"
                docker build -t "brettt89/silverstripe-web:${version}-${os}-${platform}" "${version}/${os}/${platform}"
            fi
        done
        # Build "$Version"-"$OS"
        if [ -f "${version}/${os}/${defaultPlatform}/Dockerfile" ]; then
            echo "### Building brettt89/silverstripe-web:${version}-${os} using ${defaultPlatform}"
            docker build -t "brettt89/silverstripe-web:${version}-${os}" "${version}/${os}/${defaultPlatform}"
        elif [ -f "${version}/${os}/stretch/Dockerfile" ]; then
            echo "### Building brettt89/silverstripe-web:${version}-${os} using stretch"
            docker build -t "brettt89/silverstripe-web:${version}-${os}" "${version}/${os}/stretch"
        fi
    done
    # Build "$Version"
    if [ -f "${version}/${defaultOS}/${defaultPlatform}/Dockerfile" ]; then
        echo "### Building brettt89/silverstripe-web:${version}"
        docker build -t "brettt89/silverstripe-web:${version}" "${version}/${defaultOS}/${defaultPlatform}"
    elif [ -f "${version}/${defaultOS}/stretch/Dockerfile" ]; then
        echo "### Building brettt89/silverstripe-web:${version}} using stretch"
        docker build -t "brettt89/silverstripe-web:${version}" "${version}/${defaultOS}/stretch"
    fi
done
# Build "latest"
if [ -f "${defaultPhpVersion}/${defaultOS}/${defaultPlatform}/Dockerfile" ]; then
    ## Force ${defaultPhpVersion}/${defaultOS}/${defaultPlatform} to be latest build
    echo "### Building brettt89/silverstripe-web:latest"
    docker build -t "brettt89/silverstripe-web:latest" "${defaultPhpVersion}/${defaultOS}/${defaultPlatform}"
fi