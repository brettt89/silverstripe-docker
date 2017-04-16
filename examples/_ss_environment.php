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
