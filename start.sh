#!/bin/bash
set -e

echo "Running standard Laravel setup..."
php artisan storage:link --force || true
php artisan migrate --force
php artisan optimize:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "Starting Apache..."
exec apache2-foreground
