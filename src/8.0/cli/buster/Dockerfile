FROM php:8.0-cli-buster
MAINTAINER Brett Tasker '<brett@silverstripe.com>'

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/install-php-extensions

# Install default PHP Extensions
RUN install-php-extensions \
        bcmath \
        mysqli \
        pdo \
        pdo_mysql \
        intl \
        ldap \
        gd \
        soap \
        tidy \
        xsl \
        zip \
        exif \
        gmp \
        opcache

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN set -eux; \
	docker-php-ext-enable opcache; \
	{ \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
	} > "$PHP_INI_DIR/conf.d/opcache-recommended.ini"

# Set error handling
RUN echo 'date.timezone = Pacific/Auckland' > "$PHP_INI_DIR/conf.d/timezone.ini" && \ 
    { \
        echo 'log_errors = On'; \
        echo 'error_log = /dev/stderr'; \
    } > "$PHP_INI_DIR/conf.d/errors.ini"

