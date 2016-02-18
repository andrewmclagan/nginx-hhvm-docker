#!/bin/bash

set -e

cd /var/www

composer install --prefer-dist --no-interaction -vvv 

php artisan migrate

exec "$@"
