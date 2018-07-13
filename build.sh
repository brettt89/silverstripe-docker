#!/bin/bash

declare -a platforms=("alpine" "platform")
declare -a phpVersions=("7.1" "5.6")

for platform in "${platforms[@]}"
do
    for version in "${phpVersions[@]}"
    do
        echo "### Building brettt89/silverstripe-web:${version}-${platform} ###"
        docker build -t "brettt89/silverstripe-web:${version}-${platform}" "${version}/${platform}"
    done
    echo "### Building brettt89/silverstripe-web:${platform}"
    docker build -t "brettt89/silverstripe-web:${platform}" "5.6/${platform}"
done

## Force 5.6/platform to be latest build
echo "### Building brettt89/silverstripe-web:latest"
docker build -t "brettt89/silverstripe-web:latest" "5.6/platform"