#!/bin/bash
set -euo pipefail

REQUEST_URI="/dev/build"

# Retries a command on failure.
# $1 - the max number of attempts
# $2... - the command to run

retry() {
    local -r -i max_attempts="$1"; shift
    local -r cmd="$@"
    local -i attempt_num=1
    until $cmd
    do
        if ((attempt_num==max_attempts))
        then
            return 1
        else
            sleep $((attempt_num++))
        fi
    done
}


try_curl() {
    RESULT=$(retry 5 lynx -dump http://silverstripe/dev/build)

    echo "${RESULT}"
}

try_cgi() {
    RESULT=$(REQUEST_URI=${REQUEST_URI:-/dev/build} \
    SCRIPT_FILENAME=${WORK_DIR:-/var/www/html}/index.php \
    SERVER_PROTOCOL=HTTP/1.1 \
    REQUEST_METHOD=GET \
    QUERY_STRING=${QUERY_STRING:-} \
    ./wait-for silverstripe:9000 --quiet --timeout=20 -- cgi-fcgi -bind -connect silverstripe:9000 | lynx --dump -stdin)

    echo "${RESULT}"
}

fail() {
    MESSAGE="Tests failed!"
    echo "${MESSAGE}"
    echo ""
    echo "REQUEST_URI: ${REQUEST_URI:-}"
    echo "WORK_DIR: ${WORK_DIR:-}"
    echo "QUERY_STRING: ${QUERY_STRING:-}"
    exit 1
}

pass() {
    MESSAGE=${1:-Tests passed!}
    echo "${MESSAGE}"
    exit 0
}

cp .env /src/
cp _ss_environment.php /src/

chown -R www-data:www-data /src

echo " - Checking database connection..."
retry 5 ./wait-for database:3306 --quiet --timeout=5
echo " - Good"
echo ""

case "${DISTRO}" in
    apache)
        try_curl
        
        if [[ "${RESULT}" =~ "Database build completed!" ]]; then
            pass
        fi
        ;;
    fpm)
        WORK_DIR=${MOUNT_DIR:-/var/www/html}
        [ -d "/src/public" ] && WORK_DIR="${WORK_DIR}/public"
        
        try_cgi
        # Check if 302 and for devbuildtoken and retry
        if [[ "${RESULT}" =~ "Status: 302" ]]; then
            TOKEN=$(echo "${RESULT}" | sed -nr 's/.*devbuildtoken=([a-z0-9]+).*/\1/p')
            QUERY_STRING="devbuildtoken=${TOKEN}"
            try_cgi
        fi

        if [[ "${RESULT}" =~ "Database build completed!" ]]; then
            pass
        fi
        ;;
    cli)
        pass "Skipping CLI tests"
        ;;
esac

# If we get here. Tests failed.
fail