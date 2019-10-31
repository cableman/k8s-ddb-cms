#!/bin/bash
set -e  

## Run templates with configuration.
/usr/local/bin/confd --onetime --backend env --confdir /etc/confd

## Start the php FPM process.
echo "Starting PHP 7.0 FPM - II"
php-fpm7.0 -F --pid /var/run/php/php-fpm7.0.pid -y /etc/php/7.0/fpm/php-fpm.conf