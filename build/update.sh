#!/bin/bash
set -euo pipefail

currentDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"
buildDir="$currentDir/../src"

phpVersions=( "$@" )
if [ ${#phpVersions[@]} -eq 0 ]; then
	phpVersions=(
        '5.6'
        '7.1'
        '7.2'
        '7.3'
        '7.4'
    )
fi
phpVersions=( "${phpVersions[@]%/}" )

declare -A variantExtras=(
	[apache]="$(< "$currentDir/apache-extras.template")"
)

declare -A variantDebianDistros=(
	[5.6]='jessie stretch'
    [7.1]='jessie stretch buster'
    [7.2]='stretch buster'
    [7.3]='stretch buster'
    [7.4]='buster'
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

build_debian() {
    phpVersion="$1"
    variant="$2"
    extras="$3"
    phpVersionDir="$phpVersion"
    for distro in ${variantDebianDistros[$phpVersion]}; do
        dir="$buildDir/$phpVersionDir/$variant/$distro"
        mkdir -p "$dir"

        sed -r \
            -e 's!%%PHP_VERSION%%!'"$phpVersion"'!g' \
            -e 's!%%VARIANT%%!'"$variant"'!g' \
            -e 's!%%DISTRO%%!'"$distro"'!g' \
            -e 's!%%VARIANT_EXTRAS%%!'"$(sed_escape_rhs "$extras")"'!g' \
            "$currentDir/Dockerfile-debian.template" > "$dir/Dockerfile"

        case "$phpVersion" in
            7.2 )
                sed -ri \
                    -e '/libzip-dev/d' \
                    "$dir/Dockerfile"
                ;;
        esac

        case "$phpVersion" in
            7.2 | 7.3 )
                sed -ri \
                    -e 's!gd --with-freetype --with-jpeg!gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr!g' \
                    "$dir/Dockerfile"
                ;;
        esac
    done
}

build_alpine() {
    phpVersion="$1"
    variant="$2"
    extras="$3"
    phpVersionDir="$phpVersion"
    dir="$buildDir/$phpVersionDir/$variant/alpine"
    mkdir -p "$dir"

    sed -r \
        -e 's!%%PHP_VERSION%%!'"$phpVersion"'!g' \
        -e 's!%%VARIANT%%!'"$variant"'!g' \
        -e 's!%%VARIANT_EXTRAS%%!'"$(sed_escape_rhs "$extras")"'!g' \
        "$currentDir/Dockerfile-alpine.template" > "$dir/Dockerfile"

    case "$phpVersion" in
        7.2 )
            sed -ri \
                -e '/libzip-dev/d' \
                "$dir/Dockerfile"
            ;;
    esac
    
    case "$phpVersion" in
        7.2 | 7.3 )
            sed -ri \
                -e 's!gd --with-freetype --with-jpeg!gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr!g' \
                "$dir/Dockerfile"
            ;;
    esac
}

for phpVersion in "${phpVersions[@]}"; do
	
	# phpVersion="${phpVersion#php}"

	for variant in "${variantImplementation[@]}"; do
		extras="${variantExtras[$variant]:-}"
		if [ -n "$extras" ]; then
			extras=$'\n'"$extras"$'\n'
		fi

        for base in ${variantBases[$variant]}; do

            case "$base" in
                debian )
                    build_debian "$phpVersion" "$variant" "$extras"
                    ;;
                alpine )
                    build_alpine "$phpVersion" "$variant" "$extras"
            esac
		
            
        done
	done
done