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
        gmp

# Pipe errors to stdErr
RUN echo "date.timezone = Pacific/Auckland" > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "log_errors = On\nerror_log = /dev/stderr" > /usr/local/etc/php/conf.d/errors.ini