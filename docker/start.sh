#!/bin/bash
set -e

cd /var/www/html

echo "Starting Laravel App..."

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_DATABASE="${DB_DATABASE:-}"
DB_USERNAME="${DB_USERNAME:-root}"
DB_PASSWORD="${DB_PASSWORD:-root123}"
DB_WAIT_TIMEOUT="${DB_WAIT_TIMEOUT:-300}"

wait_for_mysql() {
  local waited=0

  echo "Resolving DB host: ${DB_HOST}"
  getent hosts "${DB_HOST}" || true

  echo "Waiting for MySQL TCP at ${DB_HOST}:${DB_PORT} for up to ${DB_WAIT_TIMEOUT}s..."

  until timeout 2 bash -c "</dev/tcp/${DB_HOST}/${DB_PORT}" 2>/dev/null; do
    waited=$((waited + 2))
    if [ "${waited}" -ge "${DB_WAIT_TIMEOUT}" ]; then
      echo "MySQL TCP port did not become reachable within ${DB_WAIT_TIMEOUT}s."
      exit 1
    fi
    sleep 2
  done

  echo "MySQL TCP is reachable.."
}

wait_for_mysql

echo "Fixing permissions..."
mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

echo "Ensuring storage link exists..."
php artisan storage:link || true

echo "Running pending migrations..."
php artisan migrate --force

echo "Running Database seeder... "
php artisan db:seed --force

# echo "Running user seeder..."
# php artisan db:seed --class=Database\\Seeders\\UserSeeder --force

# echo "Running brand seeder..."
# php artisan db:seed --class=Database\\Seeders\\BrandSeeder --force

# echo "Running category seeder..."
# php artisan db:seed --class=Database\\Seeders\\CategorySeeder --force

# echo "Running customer seeder..."
# php artisan db:seed --class=Database\\Seeders\\CustomerSeeder --force

# echo "Running coupon seeder..."
# php artisan db:seed --class=Database\\Seeders\\CouponSeeder --force

# echo "Running database seeder..."
# php artisan db:seed --class=Database\\Seeders\\DatabaseSeeder --force

# echo "Running environment seeder..."
# php artisan db:seed --class=Database\\Seeders\\EnvironmentBootstrapperSeeder --force

# echo "Running product seeder..."
# php artisan db:seed --class=Database\\Seeders\\ProductSeeder --force

# echo "Running random seeder..."
# php artisan db:seed --class=Database\\Seeders\\RandomSeeder --force

# echo "Running setting seeder..."
# php artisan db:seed --class=Database\\Seeders\\SettingSeeder --force

# echo "Running Filament"
# php artisan make:filament-resource Category --generate

echo "Clearing Laravel caches..."
php artisan optimize:clear || true

echo "Caching Laravel config..."
php artisan config:cache

echo "Caching Laravel routes..."
php artisan route:cache || true

echo "Caching Laravel views..."
php artisan view:cache

echo "Starting Apache..."
exec apache2-foreground
