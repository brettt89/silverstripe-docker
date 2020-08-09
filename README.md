# Supported tags and respective `Dockerfile` links
- [`7.4-apache-buster`, `7.4-apache`, `7.4`, `latest` (*7.4/apache/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.4/apache/buster/Dockerfile)
- [`7.3-apache-buster`, `7.3-apache`, `7.3` (*7.3/apache/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.3/apache/buster/Dockerfile)
- [`7.3-apache-stretch` (*7.3/apache/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.3/apache/stretch/Dockerfile)
- [`7.2-apache-buster`, `7.2-apache`, `7.2` (*7.2/apache/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.2/apache/buster/Dockerfile)
- [`7.2-apache-stretch` (*7.2/apache/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.2/apache/stretch/Dockerfile)
- [`7.1-apache-buster`, `7.1-apache`, `7.1` (*7.1/apache/buster/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/apache/buster/Dockerfile)
- [`7.1-apache-jessie` (*7.1/apache/jessie/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/apache/jessie/Dockerfile)
- [`7.1-apache-stretch` (*7.1/apache/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/apache/stretch/Dockerfile)
- [`5.6-apache-jessie`, `5.6-apache`, `5.6` (*5.6/apache/jessie/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/apache/jessie/Dockerfile)
- [`5.6-apache-stretch` (*5.6/apache/stretch/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/apache/stretch/Dockerfile)

## Depreciated tags (still available, but not updated)
- `7.3-debian-buster`, `7.3-debian`
- `7.3-debian-stretch`
- `7.2-debian-buster`, `7.2-debian`
- `7.2-debian-stretch`
- `7.1-debian-buster`, `7.1-debian`
- `7.1-debian-stretch`
- `7.1-debian-jessie`
- `5.6-debian-stretch`, `5.6-debian`
- `5.6-debian-jessie`

# What is SilverStripe Web

SilverStripe Web is a Docker container which comes pre-installed with requirements to run a Silverstripe application, such as PHP. This is designed to be light weight so it can cater to many. We recommend using your own `Dockerfile` and extending from this image (See: [Installing additional dependancies](#installing-additional-dependancies)).

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

## Start a `brettt89/silverstripe-web` apache container

Start a `brettt89/silverstripe-web` container mounting the folder of your SilverStripe installation (e.g. `/path/to/project`) to `/var/www/html` and linking the `database` container using `--link database`.

```bash
docker run -d -p 80:80 -v /path/to/project:/var/www/html --link database --name project1  brettt89/silverstripe-web:7.3-apache-buster
```

_You will require an `_ss_environment.php` or `.env` file to tell the environment which database to connect to. Examples have been provided in `./example` folder [example](./example/_ss_environment.php)_

_By linking the database via `--link database`, we can connect to it from the web server using `database` as the hostname (e.g. `SS_DATABASE_SERVER=database`)._

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
#
#     $DOCUMENT_ROOT by default = /var/www/html. You can change this ENV variable to change the mount on the image
COPY . $DOCUMENT_ROOT
```

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 19.03.12.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues). 

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/brettt89/silverstripe-web/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
