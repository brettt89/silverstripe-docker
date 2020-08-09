# Install default PHP Extensions
RUN docker-php-ext-install -j$(nproc) \
		bcmath \
		mysqli \
		pdo \
		pdo_mysql

# Install Intl, LDAP, GD, SOAP, Tidy, XSL, Zip PHP Extensions
ARG GD_BUILD_ARGS="--with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/"
RUN apt-get update -y && apt-get install -y \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libldap2-dev \
        libgd-dev \
        libzip-dev \
        libtidy-dev \
        libxml2-dev \
        libxslt-dev \
        zip \
    --no-install-recommends && \
    apt-mark auto \
        zlib1g-dev \
        g++ \
        libldap2-dev \
        libxml2-dev \
        libxslt-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-configure gd ${GD_BUILD_ARGS:-}&& \
    docker-php-ext-install -j$(nproc) \
        intl \
        ldap \
        gd \
        soap \
        tidy \
        xsl \
        zip && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
	rm -rf /var/lib/apt/lists/*

# Pipe errors to stdErr
RUN echo "date.timezone = Pacific/Auckland" > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "log_errors = On\nerror_log = /dev/stderr" > /usr/local/etc/php/conf.d/errors.ini