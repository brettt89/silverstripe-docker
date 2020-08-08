#!/bin/bash
set -euo pipefail

try_curl() {
    local -i max_attempts=5
    local -i attempt_num=1

    until RESULT=$(lynx -dump http://silverstripe/dev/build)
    do
        if ((attempt_num==max_attempts))
        then
            echo "Attempt $attempt_num failed and there are no more attempts left!"
            return 1
        else
            echo "Attempt $attempt_num failed! Trying again in $attempt_num seconds..."
            sleep $((attempt_num++))
        fi
    done

    echo "${RESULT}"
}

cp .env /src/
cp _ss_environment.php /src/

chown -R www-data:www-data /src

./wait-for database:3306 --quiet --timeout=20

if [ "${DISTRO}" == "apache" ]; then
    try_curl
    if [[ "${RESULT}" =~ "Database build completed!" ]]; then
        echo "Tests passed!"
        exit 0
    else
        echo "Tests failed!"
        exit 1
    fi
elif [ "${DISTRO}" == "fpm" ]; then
    SCRIPT_NAME=/dev/build \
    SCRIPT_FILENAME=/dev/build \
    REQUEST_METHOD=GET \
    ./wait-for silverstripe:9000 --quiet --timeout=20 -- cgi-fcgi -bind -connect silverstripe:9000

    echo "Tests passed!"
    exit 0
fi
echo "Tests skipped!"
exit 0