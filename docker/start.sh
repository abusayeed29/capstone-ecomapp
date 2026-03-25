#!/bin/bash
set -e

cd /var/www/html

echo "Starting Laravel App..."

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_USERNAME="${DB_USERNAME:-root}"
DB_PASSWORD="${DB_PASSWORD:-root123}"
DB_WAIT_TIMEOUT="${DB_WAIT_TIMEOUT:-120}"

wait_for_mysql() {
  local waited=0

  echo "Waiting for MySQL at ${DB_HOST}:${DB_PORT} for up to ${DB_WAIT_TIMEOUT}s..."

  until mysqladmin ping \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    --silent; do
    waited=$((waited + 2))
    if [ "${waited}" -ge "${DB_WAIT_TIMEOUT}" ]; then
      echo "MySQL did not become reachable within ${DB_WAIT_TIMEOUT}s."
      exit 1
    fi
    sleep 2
  done
}

wait_for_mysql

echo "Clearing Laravel caches..."
php artisan optimize:clear

echo "Ensuring storage link exists..."
php artisan storage:link || true

echo "Running pending migrations..."
php artisan migrate --force

echo "Caching Laravel config/routes/views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Fix permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

echo "Starting Apache..."
exec apache2-foreground
