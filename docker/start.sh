#!/bin/bash
set -e

cd /var/www/html

echo "Starting Laravel App..."

# Clear caches
php artisan config:clear || true
php artisan cache:clear || true
php artisan route:clear || true
php artisan view:clear || true

# Storage link
php artisan storage:link || true

# Run migrations (safe)
php artisan migrate --force || true

# Cache for production
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

# Fix permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

echo "Starting Apache..."
apache2-foreground