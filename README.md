 - ![GitHub CI](https://github.com/brettt89/silverstripe-docker/workflows/GitHub%20CI/badge.svg?branch=master)
 - ![Release](https://github.com/brettt89/silverstripe-docker/workflows/Release/badge.svg?branch=master)

# Quick reference

-	**Where to file issues**:  
	[https://github.com/brettt89/silverstripe-docker/issues](https://github.com/brettt89/silverstripe-docker/issues)

-	**Supported architectures**: ([more info](https://github.com/docker-library/official-images#architectures-other-than-amd64))  
	`amd64`, `arm64v8`

# Supported Tags and respective `Dockerfile` links

> Due to [Silverstripe's supported php versions](https://docs.silverstripe.org/en/4/getting_started/server_requirements/#php-support) not including 8.2 for current release, PHP 8.1 Apache is still tagged as `latest` and PHP 8.2 images are tested using 5.x-dev branch at time of test execution (This will be updated to tagged 5.x release at later date).

- [`8.3-apache-bookworm`, `8.3-apache`, `8.3`, `latest`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/apache/bookworm/Dockerfile)
- [`8.3-apache-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/apache/bullseye/Dockerfile)
- [`8.3-fpm-bookworm`, `8.3-fpm`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/fpm/bookworm/Dockerfile)
- [`8.3-fpm-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/fpm/bullseye/Dockerfile)
- [`8.3-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/fpm/alpine/Dockerfile)
- [`8.3-cli-bookworm`, `8.3-cli`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/cli/bookworm/Dockerfile)
- [`8.3-cli-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/cli/bullseye/Dockerfile)
- [`8.3-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.3/cli/alpine/Dockerfile)
- [`8.2-apache-bookworm`, `8.2-apache`, `8.2`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/apache/bookworm/Dockerfile)
- [`8.2-apache-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/apache/bullseye/Dockerfile)
- [`8.2-fpm-bookworm`, `8.2-fpm`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/fpm/bookworm/Dockerfile)
- [`8.2-fpm-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/fpm/bullseye/Dockerfile)
- [`8.2-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/fpm/alpine/Dockerfile)
- [`8.2-cli-bookworm`, `8.2-cli`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/cli/bookworm/Dockerfile)
- [`8.2-cli-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/cli/bullseye/Dockerfile)
- [`8.2-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.2/cli/alpine/Dockerfile)
- [`8.1-apache-bookworm`, `8.1-apache`, `8.1`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/apache/bookworm/Dockerfile)
- [`8.1-apache-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/apache/bullseye/Dockerfile)
- [`8.1-fpm-bookworm`, `8.1-fpm`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/fpm/bookworm/Dockerfile)
- [`8.1-fpm-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/fpm/bullseye/Dockerfile)
- [`8.1-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/fpm/alpine/Dockerfile)
- [`8.1-cli-bookworm`, `8.1-cli`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/cli/bookworm/Dockerfile)
- [`8.1-cli-bullseye`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/cli/bullseye/Dockerfile)
- [`8.1-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/master/src/8.1/cli/alpine/Dockerfile)

# Legacy Tags and respective `Dockerfile` links

Legacy Tags are PHP versions which are no longer directly supported by PHP. As the underlying PHP images are no longer updated, new builds for these legacy tags will not be released.

- [`8.2-apache-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.2/apache/Dockerfile)
- [`8.2-fpm-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.2/fpm/buster/Dockerfile)
- [`8.2-cli-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.2/cli/buster/Dockerfile)
- [`8.1-apache-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.1/apache/Dockerfile)
- [`8.1-fpm-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.1/fpm/buster/Dockerfile)
- [`8.1-cli-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.1/cli/buster/Dockerfile)
- [`8.0-apache-bullseye`, `8.0-apache`, `8.0`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/apache/bullseye/Dockerfile)
- [`8.0-apache-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/apache/Dockerfile)
- [`8.0-fpm-bullseye`, `8.0-fpm`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/fpm/bullseye/Dockerfile)
- [`8.0-fpm-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/fpm/buster/Dockerfile)
- [`8.0-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/fpm/alpine/Dockerfile)
- [`8.0-cli-bullseye`, `8.0-cli`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/cli/bullseye/Dockerfile)
- [`8.0-cli-buster`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/cli/buster/Dockerfile)
- [`8.0-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/f417a6e165ef89613b50e65845cdaccd121073be/src/8.0/cli/alpine/Dockerfile)
- [`7.4-apache-bullseye`, `7.4-apache`, `7.4`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/apache/bullseye/Dockerfile)
- [`7.4-apache-buster`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/apache/Dockerfile)
- [`7.4-fpm-bullseye`, `7.4-fpm`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/fpm/bullseye/Dockerfile)
- [`7.4-fpm-buster`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/fpm/buster/Dockerfile)
- [`7.4-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/fpm/alpine/Dockerfile)
- [`7.4-cli-bullseye`, `7.4-cli`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/cli/bullseye/Dockerfile)
- [`7.4-cli-buster`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/cli/buster/Dockerfile)
- [`7.4-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/50d2451a2e055774dca9444fc939dd0aae4316df/src/7.4/cli/alpine/Dockerfile)
- [`7.3-apache-buster`, `7.3-apache`, `7.3`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/apache/buster/Dockerfile)
- [`7.3-fpm-buster`, `7.3-fpm`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/fpm/buster/Dockerfile)
- [`7.3-cli-buster`, `7.3-cli`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/cli/buster/Dockerfile)
- [`7.3-apache-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/apache/stretch/Dockerfile)
- [`7.3-fpm-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/fpm/stretch/Dockerfile)
- [`7.3-cli-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/cli/stretch/Dockerfile)
- [`7.3-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/fpm/alpine/Dockerfile)
- [`7.3-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.3/cli/alpine/Dockerfile)
- [`7.2-apache-buster`, `7.2-apache`, `7.2`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/apache/buster/Dockerfile)
- [`7.2-fpm-buster`, `7.2-fpm`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/fpm/buster/Dockerfile)
- [`7.2-cli-buster`, `7.2-cli`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/cli/buster/Dockerfile)
- [`7.2-apache-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/apache/stretch/Dockerfile)
- [`7.2-fpm-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/fpm/stretch/Dockerfile)
- [`7.2-cli-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/cli/stretch/Dockerfile)
- [`7.2-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/fpm/alpine/Dockerfile)
- [`7.2-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.2/cli/alpine/Dockerfile)
- [`7.1-apache-buster`, `7.1-apache`, `7.1`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/apache/buster/Dockerfile)
- [`7.1-fpm-buster`, `7.1-fpm`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/fpm/buster/Dockerfile)
- [`7.1-cli-buster`, `7.1-cli`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/cli/buster/Dockerfile)
- [`7.1-apache-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/apache/stretch/Dockerfile)
- [`7.1-fpm-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/fpm/stretch/Dockerfile)
- [`7.1-cli-stretch`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/cli/stretch/Dockerfile)
- [`7.1-apache-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/apache/jessie/Dockerfile)
- [`7.1-fpm-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/fpm/jessie/Dockerfile)
- [`7.1-cli-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/cli/jessie/Dockerfile)
- [`7.1-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/fpm/alpine/Dockerfile)
- [`7.1-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/7.1/cli/alpine/Dockerfile)
- [`5.6-apache-stretch`, `5.6-apache`, `5.6`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/apache/stretch/Dockerfile)
- [`5.6-fpm-stretch`, `5.6-fpm`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/fpm/stretch/Dockerfile)
- [`5.6-cli-stretch`, `5.6-cli`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/cli/stretch/Dockerfile)
- [`5.6-apache-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/apache/jessie/Dockerfile)
- [`5.6-fpm-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/fpm/jessie/Dockerfile)
- [`5.6-cli-jessie`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/cli/jessie/Dockerfile)
- [`5.6-fpm-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/fpm/alpine/Dockerfile)
- [`5.6-cli-alpine`](https://github.com/brettt89/silverstripe-docker/blob/631689ae1a11d900cb9b949884ed955a86bf0cf5/src/5.6/cli/alpine/Dockerfile)


# What is Silverstripe CMS

Silverstripe CMS is a free and open source Content Management System (CMS) and Framework for creating and maintaining websites and web applications. It provides an out of the box web-based administration panel that enables users to make modifications to parts of the website, which includes a WYSIWYG website editor. The core of the software is Silverstripe Framework, a PHP Web application framework.

https://en.wikipedia.org/wiki/Silverstripe_CMS

![Silverstripe CMS](docs/logo.png "Logo Title Text 1")

# How to use this image

### Basic usage

Running the `brettt89/silverstripe-web` image with Apache is as simple as

```shell
$ docker run -d \
  --volume $PWD:/app \
  brettt89/silverstripe-web:8.1-apache
```

### Create a Dockerfile in your PHP project

```Dockerfile
FROM brettt89/silverstripe-web:8.1-apache
ENV DOCUMENT_ROOT /usr/src/myapp

COPY . $DOCUMENT_ROOT
WORKDIR $DOCUMENT_ROOT
```

### Create a `docker-compose.yml` in your PHP project

```yaml
version: "3.8"
services:
  silverstripe:
    image: brettt89/silverstripe-web:8.1-apache
    volumes:
       - .:/var/www/html
    depends_on:
       - database
    environment:
       - DOCUMENT_ROOT=/var/www/html/public
       - SS_TRUSTED_PROXY_IPS=*
       - SS_ENVIRONMENT_TYPE=dev
       - SS_DATABASE_SERVER=database
       - SS_DATABASE_NAME=SS_mysite
       - SS_DATABASE_USERNAME=root
       - SS_DATABASE_PASSWORD=
       - SS_DEFAULT_ADMIN_USERNAME=admin
       - SS_DEFAULT_ADMIN_PASSWORD=password

  database:
    image: mysql:5.7
    environment:
       - MYSQL_ALLOW_EMPTY_PASSWORD=yes
    volumes:
       - db-data:/var/lib/mysql
volumes:
     db-data:
```

# Environment Variables

Environment variables can be used to assist with configuration of your container. Below lists the exiting Environment variables that can be used to customize your container.

 - `DOCUMENT_ROOT` - Apache's document root location. (For SilverStripe 4 installations, you will want to set this to your `/public` directory. E.g. `/var/www/html/public`)

# How to install more PHP extensions

Many extensions are already compiled into the image, so it's worth checking the output of `php -m` or `php -i` before going through the effort of compiling more.

We provide the helper scripts [`docker-php-extension-installer`](https://hub.docker.com/r/mlocati/php-extension-installer) to more easily install PHP extensions.

```Dockerfile
FROM brettt89/silverstripe-web:8.1-apache
RUN install-php-extensions xdebug
```

### Default extensions

The following extensions are installed by default on top of the default PHP image.

- `bcmath`
- `mysqli`
- `pdo`
- `pdo_mysql`
- `intl`
- `ldap`
- `gd`
- `soap`
- `tidy`
- `xsl`
- `zip`
- `exif`
- `gmp`

# Image Variants

The `php` images come in many flavors, each designed for a specific use case.

Some of these tags may have names like `bullseye` or `buster` in them. These are the suite code names for releases of [Debian](https://wiki.debian.org/DebianReleases) and indicate which release the image is based on. If your image needs to install any additional packages beyond what comes with the image, you'll likely want to specify one of these explicitly to minimize breakage when there are new releases of Debian.

## `brettt89/silverstripe-web:<version>-apache`

This image contains Debian's Apache httpd in conjunction with PHP (as mod_php) and uses mpm_prefork by default. See Basic Usage for examples on how to use.

## `brettt89/silverstripe-web:<version>-cli`

This variant contains the [PHP CLI](https://secure.php.net/manual/en/features.commandline.php) tool with default mods. If you need a web server, this is probably not the image you are looking for. It is designed to be used both as a throw away container (mount your source code and start the container to start your app), as well as a base from which to build other images.

It also is the only variant which contains the (not recommended) `php-cgi` binary, which is likely necessary for some things like [PPM](https://github.com/php-pm/php-pm).

Note that *all* variants of `php` contain the PHP CLI (`/usr/local/bin/php`).

## `brettt89/silverstripe-web:<version>-fpm`

This variant contains PHP-FPM, which is a FastCGI implementation for PHP. See the PHP-FPM website for more information about PHP-FPM.

In order to use this image variant, some kind of reverse proxy (such as NGINX, Apache, or other tool which speaks the FastCGI protocol) will be required.

Some potentially helpful resources:

- [PHP-FPM.org](https://php-fpm.org/)
- [simplified example by @md5](https://gist.github.com/md5/d9206eacb5a0ff5d6be0)
- [very detailed article by Pascal Landau](https://www.pascallandau.com/blog/php-php-fpm-and-nginx-on-docker-in-windows-10/)
- [Stack Overflow discussion](https://stackoverflow.com/q/29905953/433558)
- [Apache httpd Wiki example](https://wiki.apache.org/httpd/PHPFPMWordpress)

## `brettt89/silverstripe-web:<version>-alpine`

This image is based on the popular [Alpine Linux project](https://alpinelinux.org), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is useful when final image size being as small as possible is your primary concern. The main caveat to note is that it does use [musl libc](https://musl.libc.org) instead of [glibc and friends](https://www.etalabs.net/compare_libcs.html), so software will often run into issues depending on the depth of their libc requirements/assumptions. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as `git` or `bash`) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [`alpine` image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).

# License

View [license information](http://php.net/license/) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

### Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues). 

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
