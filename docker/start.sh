#!/bin/bash
set -e

cd /var/www/html

echo "Starting Laravel App..."

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_DATABASE="${DB_DATABASE:-ecom-app}"
DB_USERNAME="${DB_USERNAME:-root}"
DB_PASSWORD="${DB_PASSWORD:-root123}"
DEMO_SQL_PATH="${DEMO_SQL_PATH:-/var/www/html/demodata.sql}"

wait_for_mysql() {
  echo "Waiting for MySQL at ${DB_HOST}:${DB_PORT}..."

  until mysqladmin ping \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    --silent; do
    sleep 2
  done
}

database_has_migrations() {
  local migration_count

  migration_count=$(mysql \
    -N \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    "${DB_DATABASE}" \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '${DB_DATABASE}' AND table_name = 'migrations';" 2>/dev/null || echo "0")

  [ "${migration_count}" -gt 0 ]
}

database_has_demo_orders() {
  local order_count

  order_count=$(mysql \
    -N \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    "${DB_DATABASE}" \
    -e "SELECT COUNT(*) FROM orders WHERE order_number LIKE 'ORD-DEMO-%';" 2>/dev/null || echo "0")

  [ "${order_count}" -gt 0 ]
}

database_has_catalog_seed_data() {
  local category_count
  local brand_count

  category_count=$(mysql \
    -N \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    "${DB_DATABASE}" \
    -e "SELECT COUNT(*) FROM categories;" 2>/dev/null || echo "0")

  brand_count=$(mysql \
    -N \
    -h"${DB_HOST}" \
    -P"${DB_PORT}" \
    -u"${DB_USERNAME}" \
    -p"${DB_PASSWORD}" \
    "${DB_DATABASE}" \
    -e "SELECT COUNT(*) FROM brands;" 2>/dev/null || echo "0")

  [ "${category_count}" -gt 0 ] && [ "${brand_count}" -gt 0 ]
}

wait_for_mysql

echo "Clearing Laravel caches..."
php artisan optimize:clear

echo "Ensuring storage link exists..."
php artisan storage:link || true

if database_has_migrations; then
  echo "Existing database detected. Running pending migrations only..."
  php artisan migrate --force
else
  echo "Fresh database detected. Running migrations and seeders..."
  php artisan migrate --seed --force
fi

if database_has_catalog_seed_data; then
  echo "Base catalog data already exists. Skipping Laravel seeder replay."
else
  echo "Base catalog data missing. Running Laravel seeders..."
  php artisan db:seed --force
fi

if [ -f "${DEMO_SQL_PATH}" ]; then
  if database_has_demo_orders; then
    echo "Demo SQL already imported. Skipping ${DEMO_SQL_PATH}."
  else
    echo "Importing demo data from ${DEMO_SQL_PATH}..."
    mysql \
      -h"${DB_HOST}" \
      -P"${DB_PORT}" \
      -u"${DB_USERNAME}" \
      -p"${DB_PASSWORD}" \
      "${DB_DATABASE}" < "${DEMO_SQL_PATH}"
  fi
else
  echo "No demo SQL file found at ${DEMO_SQL_PATH}; skipping SQL import."
fi

echo "Caching Laravel config/routes/views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Fix permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

echo "Starting Apache..."
exec apache2-foreground
