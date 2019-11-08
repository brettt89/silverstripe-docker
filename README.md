# Supported tags and respective `Dockerfile` links

- [`7.3-debian-buster`, `7.3-debian` `7.3` `latest` (*7.3/debian/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.3/debian/buster/Dockerfile)
- [`7.3-debian-stretch` (*7.3/debian/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.3/debian/stretch/Dockerfile)
- [`7.2-debian-buster`, `7.2-debian` `7.2` (*7.2/debian/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.2/debian/buster/Dockerfile)
- [`7.2-debian-stretch` (*7.2/debian/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.2/debian/stretch/Dockerfile)
- [`7.1-debian-buster`, `7.1-debian` `7.1` (*7.1/debian/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/debian/buster/Dockerfile)
- [`7.1-debian-stretch` (*7.1/debian/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/debian/stretch/Dockerfile)
- [`7.1-debian-jessie` (*7.1/debian/jessie/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/debian/jessie/Dockerfile)
- [`5.6-debian-stretch`, `5.6-debian` `5.6` (*5.6/debian/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/debian/stretch/Dockerfile)
- [`5.6-debian-jessie` (*5.6/debian/jessie/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/debian/jessie/Dockerfile)

[![Build Status](https://travis-ci.org/brettt89/silverstripe-web.svg?branch=master)](https://travis-ci.org/brettt89/silverstripe-web)

# What is SilverStripe Web

SilverStripe Web is a Debian Docker container which comes pre-installed with Apache, PHP and a other common components used to run SilverStripe websites. This is designed to be light weight so it can cater to many. We recommend using your own `Dockerfile` and extending from this image (See: [Installing additional dependancies](#installing-additional-dependancies)).

## Requirements

- [Docker](https://docs.docker.com/)

## Build names

Each build is prefixed with a version (e.g. `5.6` / `7.1` / `7.2` / `7.3`). This denotes the PHP version this build is built from.

There are multiple available for each PHP version, E.g. `7.1-debian-stretch`. Take a look at the available tags to pick what is most appropriate for you.

## Environment Info

This image comes pre-packaged with the following additional PHP Extensions

 - `bcmath`
 - `mysql`
 - `pdo`
 - `intl`
 - `ldap`
 - `gd`
 - `tidy`
 - `xsl`
 - `zip`

# How to use this image.

## Install SilverStripe CMS 4.x (Optional)

_If you already have a silverstripe installation, skip this step and use the directory of your installation instead of `/path/to/project`_

### Requirements

 - [Composer](https://getcomposer.org/)
 - [PHP](https://www.php.net/manual/en/install.php) - _(PHP 7.3 Recommended)_

Install the latest version of Silverstripe 4 to `/path/to/project` or a directory of your choosing.

```bash
composer create-project silverstripe/installer /path/to/project ^4
```

## Start a `mysql` server instance

We name our database `database` so we can link our web container to it.

Start a `mysql` container for our web server to connect to.

```bash
docker run -d -p 3306:3306 --name database --env MYSQL_ALLOW_EMPTY_PASSWORD=1 mysql
```

_If using for sensitive data, we recommend replacing `MYSQL_ALLOW_EMPTY_PASSWORD=1` with `MYSQL_ROOT_PASSWORD=my-secret-pw`, where `my-secret-pw` is the password to be set for `SS_DATABASE_PASSWORD` in your `_ss_environment.php` or `.env` file._

## Start a `brettt89/silverstripe-web` server instance

Start a `brettt89/silverstripe-web` container mounting the folder of your SilverStripe installation (e.g. `/path/to/project`) to `/var/www/html` and linking the `database` container using `--link database`.

```bash
docker run -d -p 80:80 -v /path/to/project:/var/www/html --link database --name project1  brettt89/silverstripe-web
```

_You will require an `_ss_environment.php` or `.env` file to tell the environment which database to connect to. Examples have been provided in `./example` folder [example](./example/_ss_environment.php)_

_By linking the database via `--link database`, we can connect to it from the web server using `database` as the hostname (e.g. `SS_DATABASE_SERVER=database`)._

## Build the database

Run a dev buid via http://localhost/dev/build for via CLI by using `docker exec`

```bash
docker exec project1 php ./vendor/silverstripe/framework/cli-script.php dev/build
```

## Access your website

You should then be able to access your installation via http://localhost/. 

# Installing additional dependancies

If you are wanting to add additional PHP extensions or other changes, we recommend using a `Dockerfile` to extend this image and customize to suit.

```Dockerfile
FROM brettt89/silverstripe-web:7.3

# Adding Xdebug
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# Replace current php.ini with custom version of php.ini
COPY php.ini /usr/local/etc/php/
# Copy current directory (website) directly to /var/www/html
#     This can sometimes provide a performance improvement over mounting with volumes.
COPY . /var/www/html/
```

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 19.03.2.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues). 

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.

# Credits

 - Franco Springveldt - [https://github.com/fspringveldt](https://github.com/fspringveldt)
