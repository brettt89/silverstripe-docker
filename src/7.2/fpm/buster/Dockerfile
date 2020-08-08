FROM php:7.2-fpm-buster
MAINTAINER Brett Tasker "<brett@silverstripe.com>"
ENV DEBIAN_FRONTEND=noninteractive

# Install components
RUN apt-get update -y && apt-get install -y \
		curl \
		git-core \
		gzip \
		openssh-client \
		unzip \
		zip \
	--no-install-recommends && \
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/*

# Install default PHP Extensions
RUN docker-php-ext-install -j$(nproc) \
		bcmath \
		mysqli \
		pdo \
		pdo_mysql
		 

# Install Intl, LDAP, GD, SOAP, Tidy, XSL, Zip PHP Extensions
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
    --no-install-recommends && \
    apt-mark auto \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libldap2-dev \
        libxml2-dev \
        libxslt-dev && \
    docker-php-ext-configure intl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
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

RUN echo "date.timezone = Pacific/Auckland" > /usr/local/etc/php/conf.d/timezone.ini && \
	echo "log_errors = On\nerror_log = /dev/stderr" > /usr/local/etc/php/conf.d/errors.ini