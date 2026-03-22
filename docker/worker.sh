#!/bin/bash
set -e

cd /var/www/html

echo "Starting Queue Worker..."

php artisan config:clear || true
php artisan cache:clear || true

while true; do
  php artisan queue:work --tries=3 --timeout=90
  echo "Worker crashed. Restarting in 5 seconds..."
  sleep 5
done