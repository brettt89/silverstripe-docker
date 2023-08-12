#!/bin/bash
set -euo pipefail

currentDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"
buildDir="$currentDir/../src"

phpVersions=( "$@" )
if [ ${#phpVersions[@]} -eq 0 ]; then
	phpVersions=(
        '8.0'
        '8.1'
        '8.2'
    )
fi
phpVersions=( "${phpVersions[@]%/}" )

declare -A variantExtras=(
	[apache]="$(< "$currentDir/apache-extras.template")"
)

declare -A variantDebianDistros=(
    [8.0]='buster bullseye'
    [8.1]='buster bullseye'
    [8.2]='buster bullseye'
)

declare -a variantImplementation=(
    'apache'
    'fpm'
    'cli'
)

declare -A variantBases=(
    [apache]='debian'
    [fpm]='debian alpine'
    [cli]='debian alpine'
)

sed_escape_rhs() {
	sed -e 's/[\/&]/\\&/g; $!a\'$'\n''\\n' <<<"$*" | tr -d '\n'
}

build_dockerfile() {
    phpVersion="$1"
    variant="$2"
    distro="$3"

    extras="${variantExtras[$variant]:-}"
    if [ -n "$extras" ]; then
        extras=$'\n'"$extras"$'\n'
    fi

    dir="$buildDir/$phpVersion/$variant/$distro"
    mkdir -p "$dir"

    sed -r \
        -e 's!%%PHP_VERSION%%!'"$phpVersion"'!g' \
        -e 's!%%VARIANT%%!'"$variant"'!g' \
        -e 's!%%DISTRO%%!'"$distro"'!g' \
        -e 's!%%VARIANT_EXTRAS%%!'"$(sed_escape_rhs "$extras")"'!g' \
        "$currentDir/Dockerfile.template" > "$dir/Dockerfile"
}

for phpVersion in "${phpVersions[@]}"; do
	
	# phpVersion="${phpVersion#php}"

	for variant in "${variantImplementation[@]}"; do

        for base in ${variantBases[$variant]}; do

            case "$base" in
                debian )
                    for distro in ${variantDebianDistros[$phpVersion]}; do
                        build_dockerfile "$phpVersion" "$variant" "$distro"
                    done
                    ;;
                alpine )
                    build_dockerfile "$phpVersion" "$variant" "alpine"
            esac
		
            
        done
	done
done