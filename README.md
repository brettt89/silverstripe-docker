# Supported tags and respective `Dockerfile` links

- [`7.1-platform`, `7.1-ssp` (*7.1/platform/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/platform/Dockerfile)
- [`7.1-alpine` (*7.1/alpine/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/7.1/alpine/Dockerfile)
- [`5.6-platform`, `5.6-ssp`, `latest`, `platform` (*5.6/platform/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/platform/Dockerfile)
- [`5.6-alpine`, `alpine` (*5.6/alpine/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/5.6/alpine/Dockerfile)

[Travis CI:
        ![Build Status](https://travis-ci.org/brettt89/silverstripe-web.svg?branch=master)](https://travis-ci.org/brettt89/silverstripe-web) 

# How to use this image.

## Requirements

- [*Docker*](https://docs.docker.com/)

## Builds

### Versions

Each build is prefixed with a version (e.g. 5.6 / 7.1). This denotes the PHP version this build is built from.

### Build names

There are 2 builds currently available, `alpine` and `platform`. These builds are almost identical except the `alpine` release does not include the Build Tools listed below.

## Environment Info

This image comes pre-packaged with a the default php extensions and configurations found on [SilverStripe Platform](https://platform.silverstripe.com). It also comes with some tooling pre-installed for ease-of-use.

### Build Tools

- [xdebug](https://xdebug.org/)
- [sspak](https://github.com/silverstripe/sspak)
- [composer](https://getcomposer.org/)

## Running with Docker

This image can also be run directly with docker. However it will need to be linked with a database in order for SilverStripe to successfully build.

```bash
docker run -p 3306:3306 --name database mysql
docker run -p 80:80 -v /path/to/project:/var/www/html --link database --name project1 brettt89/silverstripe-web
```

NOTE: You will require an `_ss_environment.php` file to tell the environment which database to connect to. An example one has been provided in `./example` folder [example](./example/_ss_environment.php)

You should then be able to access run a dev buid via http://localhost/dev/build.

# License

View [license information](http://php.net/license/) for the software contained in this image.

# Supported Docker versions

This image is officially supported on Docker version 17.04.0-ce.

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
