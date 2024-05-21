#!/bin/bash
set -euo pipefail

REQUEST_URI="/dev/build"
IMAGE_TAG=${IMAGE_TAG:-8.3-apache-bookworm}

# Options

while getopts "d" opt; do
  case $opt in
    d)
      DEBUG=d
      ;;
    *)
      ;;
  esac
done

# Retries a command on failure.
# $1 - the max number of attempts
# $2... - the command to run
error() {
    MESSAGE=${1:-Unknown error}
    echo "[ERROR] ${MESSAGE}"
    exit 1
}

warn() {
    MESSAGE=$1
    if [ -n "$DEBUG" ]; then
        echo "[WARNING] ${MESSAGE}"
    fi
}

info() {
    MESSAGE=$1
    if [ -n "$DEBUG" ]; then
        echo "[INFO] ${MESSAGE}"
    fi
}

retry() {
    local -r -i max_attempts=$1; shift
    local -r cmd=$*
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
    info "Attempting to try cgi connection"
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

failure() {
    MESSAGE="Unknown failure"
    echo "[FAULT] ${MESSAGE}"
}

info "Test Runner"
info " - Arguments"
info "    - REQUEST_URI=${REQUEST_URI}"
info "    - IMAGE_TAG=${IMAGE_TAG}"
info " - Copying Environment files"
cp _ss_environment.php /src/
info " - Changing ownership of codebase to 'www-data'"

if [[ "${IMAGE_TAG}" =~ "alpine" ]]; then
    chown -R 82:82 /src
else
    chown -R www-data:www-data /src
fi

info " - Checking database connection..."
retry 5 ./wait-for database:3306 --quiet --timeout=30
info "   - Good"
info ""
info "Running tests"
if [[ "${IMAGE_TAG}" =~ "-apache-" ]]; then
    info " - Detected apache in image tag, trying test via curl"
    try_curl
        
    if [[ "${RESULT}" =~ "Database build completed!" ]]; then
        pass
    fi
elif [[ "${IMAGE_TAG}" =~ "-fpm-" ]]; then
    info " - Detected fpm in image tag, trying test via cgi"
    WORK_DIR=${MOUNT_DIR:-/var/www/html}
    [ -d "/src/public" ] && WORK_DIR="${WORK_DIR}/public"
    
    try_cgi
    # Check if 302 and for devbuildtoken and retry
    if [[ "${RESULT}" =~ "Status: 302" ]]; then
        info "   - '302' response received, attempting to follow redirect"
        TOKEN=$(echo "${RESULT}" | sed -nr 's/.*devbuildtoken=([a-z0-9]+).*/\1/p')
        QUERY_STRING="devbuildtoken=${TOKEN}"
        try_cgi
    fi

    if [[ "${RESULT}" =~ "Database build completed!" ]]; then
        pass
    fi
elif [[ "${IMAGE_TAG}" =~ "-cli-" ]]; then
    pass "Skipping CLI test"
fi

# If we get here. Tests failed.
fail

trap failure EXIT