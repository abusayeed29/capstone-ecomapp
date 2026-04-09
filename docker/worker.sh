#!/bin/bash
set -e

cd /var/www/html

echo "Starting Queue Worker..."

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_WAIT_TIMEOUT="${DB_WAIT_TIMEOUT:-300}"

echo "Waiting for MySQL TCP at ${DB_HOST}:${DB_PORT}..."
waited=0
until timeout 2 bash -c "</dev/tcp/${DB_HOST}/${DB_PORT}" 2>/dev/null; do
  waited=$((waited + 2))
  if [ "${waited}" -ge "${DB_WAIT_TIMEOUT}" ]; then
    echo "MySQL did not become reachable within ${DB_WAIT_TIMEOUT}s."
    exit 1
  fi
  sleep 2
done

echo "MySQL is reachable. Starting worker..."

while true; do
  php artisan queue:work \
    --tries=3 \
    --timeout=60 \
    --sleep=3 \
    --max-time=3600
  echo "Worker stopped. Restarting in 5 seconds..."
  sleep 5
done
