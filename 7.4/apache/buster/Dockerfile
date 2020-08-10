ARG TAG

FROM php:$TAG
MAINTAINER Brett Tasker "<brett@silverstripe.com>"
ENV DEBIAN_FRONTEND=noninteractive
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
# Apache configuration
ENV DOCUMENT_ROOT /var/www/html
RUN { \
                echo '<VirtualHost *:80>'; \
                echo '  DocumentRoot ${DOCUMENT_ROOT}'; \
                echo '  LogLevel warn'; \
                echo '  ServerSignature Off'; \
                echo '  <Directory ${ENVVAR}>'; \
                echo '    Options +FollowSymLinks'; \
                echo '    Options -ExecCGI -Includes -Indexes'; \
                echo '    AllowOverride all'; \
                echo; \
                echo '    Require all granted'; \
                echo '  </Directory>'; \
                echo '  <LocationMatch assets/>'; \
                echo '    php_flag engine off'; \
                echo '  </LocationMatch>'; \
                echo; \
                echo '  IncludeOptional sites-available/000-default.local*'; \
                echo '</VirtualHost>'; \
	} | tee /etc/apache2/sites-available/000-default.conf && \
    echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf && \
    a2enmod rewrite expires remoteip cgid headers
