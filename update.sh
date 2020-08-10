#!/bin/bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

phpVersions=( "$@" )
if [ ${#phpVersions[@]} -eq 0 ]; then
	phpVersions=( *.*/ )
fi
phpVersions=( "${phpVersions[@]%/}" )

declare -A variantExtras=(
	[apache]="$(< apache-extras.template)"
)

declare -A variantDistros=(
	[5.6]='jessie stretch'
    [7.1]='jessie stretch buster'
    [7.2]='stretch buster'
    [7.3]='stretch buster'
    [7.4]='buster'
)

declare -A variantBases=(
    [apache]='debian'
    [fpm]='debian'
    [cli]='debian'
)

sed_escape_rhs() {
	sed -e 's/[\/&]/\\&/g; $!a\'$'\n''\\n' <<<"$*" | tr -d '\n'
}

for phpVersion in "${phpVersions[@]}"; do
	phpVersionDir="$phpVersion"
	phpVersion="${phpVersion#php}"

	for variant in apache fpm cli; do
		extras="${variantExtras[$variant]:-}"
		if [ -n "$extras" ]; then
			extras=$'\n'"$extras"$'\n'
		fi

        base="${variantBases[$variant]}"
		
        for distro in ${variantDistros[$phpVersion]}; do
            dir="$phpVersionDir/$variant/$distro"
            mkdir -p "$dir"

            sed -r \
                -e 's!%%PHP_VERSION%%!'"$phpVersion"'!g' \
                -e 's!%%VARIANT%%!'"$variant"'!g' \
                -e 's!%%DISTRO%%!'"$distro"'!g' \
                -e 's!%%VARIANT_EXTRAS%%!'"$(sed_escape_rhs "$extras")"'!g' \
                "Dockerfile-${base}.template" > "$dir/Dockerfile"

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
	done
done