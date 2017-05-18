# Supported tags and respective `Dockerfile` links

 - [`platform`, `ssp`, `latest` (*platform/Dockerfile*)](https://github.com/brettt89/silverstripe-web/blob/master/platform/Dockerfile)

[Travis CI:
        ![Build Status](https://travis-ci.org/brettt89/silverstripe-web.svg?branch=master)](https://travis-ci.org/brettt89/silverstripe-web) 

# How to use this image.

## Requirements

 - [*Docker Compose*](https://docs.docker.com/compose/install/)
 - [*Composer*](https://getcomposer.org/)
 - [*docker-compose.yml*](#examples)
 - [*\_ss\_environment.php*](#examples)

## Info

This image comes pre-packaged with a the default php extensions and configurations found on [SilverStripe Platform](https://platform.silverstripe.com). It also comes with some tooling pre-installed for ease-of-use.

**Installed:**

 - [xdebug](https://xdebug.org/)
 - [sspak](https://github.com/silverstripe/sspak)

## Create using Docker Compose

Compose is a tool for defining and running multi-container Docker applications. To learn more about Compose refer to the [Compose Documentation](https://docs.docker.com/compose/overview/)

### Create a `docker-compose.yml` in your SilverStripe project

```yml
version: '3'
services:
  web:
    image: brettt89/silverstripe-web
    working_dir: /var/www
    volumes:
      - .:/var/www/html

  database:
    image: mysql
    volumes:
      - db-data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ALLOW_EMPTY_PASSWORD=true

volumes:
  db-data:
```

### Create an `_ss_environment.php` in your SilverStripe project

This defines default settings like database values, however you can add custom environment variables to this file.

```php
<?php

/* Change this from 'dev' to 'live' for a production environment. */
define('SS_ENVIRONMENT_TYPE', 'dev');

/* This defines a default database user */
define('SS_DATABASE_SERVER', 'database');
define('SS_DATABASE_NAME', 'SS_mysite');
define('SS_DATABASE_USERNAME', 'root');
define('SS_DATABASE_PASSWORD', '');

/* Configure a default username and password to access the CMS on all sites in this environment. */
define('SS_DEFAULT_ADMIN_USERNAME', 'admin');
define('SS_DEFAULT_ADMIN_PASSWORD', 'password');

// This is used by sake to know which directory points to which URL
global $_FILE_TO_URL_MAPPING;
$_FILE_TO_URL_MAPPING['/var/www/html'] = 'http://localhost';
```

### Create development environment using `docker-compose`

Run the command to build and run the Docker images:

```console
$ docker-compose up -d
```

## Adding nginx-proxy (multi-server)

More commonly, you will probably want to run silverstripe-web in conjunction with nginx-proxy so you can run multiple environments. This can be achieved by following these steps.

> NOTE: A clone of jwilder/nginx-proxy is used [https://github.com/brettt89/nginx-proxy](https://github.com/brettt89/nginx-proxy) for additional configuration options

### Create a `docker network` for your projects

```console
$ docker network create my-network
```

This will act as a global network for each of your projects to run in simultaniously

### Run `nginx-proxy` in your network

```console
$ docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --net my-network --name nginx-proxy brettt89/nginx-proxy
```

Nginx proxy will act as a gateway for all the project environments. For best results it is recommended to use a shared root domain for each project. E.g. `dev`

#### Get IP of Host

Windows: 
![alt text](https://raw.githubusercontent.com/brettt89/silverstripe-web/master/examples/docker-windows.png "Docker for Windows Network")

Mac OSX / Linux:
Use `127.0.0.1` (localhost)

#### Point root domain at `nginx-proxy`

 - For Linux / OSX based environments, we recommend the use of `dnsmasq`
 - For Windows based environments, we recommend the use of [Acrylic DNS](http://mayakron.altervista.org/wikibase/show.php?id=AcrylicHome)

NOTE: Use the IP address obtained from the previous step (Get IP of Host).

 ```dnsmasq
 address=/dev/10.0.75.0
 ```
 
 This will point any website ending in .dev to your nginx proxy so you don't have to keep setting up records for each project.

### Add my-network and VIRTUAL_HOST to your `docker-compose.yml` file/s

```yml
version: '3'
services:
  web:
    image: brettt89/silverstripe-web
    working_dir: /var/www
    volumes:
      - .:/var/www/html
    environment:
      - VIRTUAL_HOST=project1.dev

  database:
    image: mysql
    volumes:
      - db-data:/var/lib/mysql
    restart: always
    environment:
      - MYSQL_ALLOW_EMPTY_PASSWORD=true

volumes:
  db-data:
  
networks:
  default:
    external:
      name: my-network
```

Then, run the command to build and run the Docker images on each of your projects:

```console
$ docker-compose up -d
```

## <a name="examples"></a>Example config files

 - Single-server config: [docker-compose.yml](https://github.com/brettt89/silverstripe-web/blob/master/examples/example.yml)
 - Multi-server config: [docker-compose.yml](https://github.com/brettt89/silverstripe-web/blob/master/examples/multi-environment.example.yml)
 - Environment config: [\_ss\_environment.php](https://github.com/brettt89/silverstripe-web/blob/master/examples/_ss_environment.php)

## Console access

```console
$ docker-compose exec web /bin/bash
```

### Common Folders

 - **Web directory:** `/var/www/html`
 - **Logs:** `/var/logs/apache2/`

### Using SSPAK

SSPAK is loaded onto the web container by default. You can mount an sspak or sspak directory directly onto the ***web*** box by adding additional [*volume's*](https://docs.docker.com/compose/compose-file/#volumes) to your `docker-compose.yml`.

```yml
    volumes:
      - .:/var/www/html
      - ~/sspaks:/var/www/sspaks
```

Then you can run your `sspak` commands on the ***web*** container.

```console
$ sspak load /var/www/sspaks/project1-db-assets.sspak /var/www/html 
```

```console
$ sspak save /var/www/html /var/www/sspaks/project1-db-assets.sspak
```

### Other Commands

Other `docker-compose` commands can be found here: [https://docs.docker.com/compose/reference/overview/](https://docs.docker.com/compose/reference/overview/)

## Running directly with Docker

This image can also be run directly with docker. However it will need to be linked with a database in order for SilverStripe to successfully build.

```console
$ docker run -p 3306:3306 --name database mysql
$ docker run -p 80:80 -v /path/to/project:/var/www/html --link database --name project1 brettt89/silverstripe-web
```

## Connecting with xdebug

*(Coming Soon)*

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
