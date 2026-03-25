#!/bin/bash
set -e

cd /var/www/html

echo "Starting Queue Worker..."

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_USERNAME="${DB_USERNAME:-root}"
DB_PASSWORD="${DB_PASSWORD:-root123}"
DB_WAIT_TIMEOUT="${DB_WAIT_TIMEOUT:-120}"

echo "Waiting for MySQL at ${DB_HOST}:${DB_PORT} before starting queue worker..."
waited=0
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

while true; do
  php artisan queue:work --tries=3 --timeout=90
  echo "Worker crashed. Restarting in 5 seconds..."
  sleep 5
done
