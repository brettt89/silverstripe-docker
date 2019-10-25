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

# How to use this image.

## Requirements

- [*Docker*](https://docs.docker.com/)

## Builds

### Versions

Each build is prefixed with a version (e.g. 5.6 / 7.1 / 7.2 / 7.3). This denotes the PHP version this build is built from.

### Build names

There are multiple available for each PHP version, E.g. `7.1-debian-stretch`. Take a look at the available tags to pick what is most appropriate for you..

## Environment Info

This image comes pre-packaged with the following additional PHP Extensions

 - bcmath
 - mysql
 - pdo
 - intl
 - ldap
 - gd
 - tidy
 - xsl
 - zip

## Running with Docker

This image can also be run directly with docker. However it will need to be linked with a database in order for SilverStripe to successfully build.

```bash
docker run -d -p 3306:3306 --name database --env MYSQL_ALLOW_EMPTY_PASSWORD=1 mysql
docker run -d -p 80:80 -v /path/to/project:/var/www/html --link database --name project1 brettt89/silverstripe-web
```

NOTE: You will require an `_ss_environment.php` or `.env` file to tell the environment which database to connect to. Examples have been provided in `./example` folder [example](./example/_ss_environment.php)

You should then be able to access run a dev buid via http://localhost/dev/build.

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
