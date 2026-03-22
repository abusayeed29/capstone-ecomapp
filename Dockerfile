# -----------------------------
# Stage 1: PHP dependencies
# -----------------------------
FROM composer:2 AS vendor

WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts

COPY . .
RUN composer dump-autoload --optimize


# -----------------------------
# Stage 2: Frontend build
# -----------------------------
FROM node:20-alpine AS frontend

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build


# -----------------------------
# Stage 3: Final app image
# -----------------------------
FROM php:8.2-apache

WORKDIR /var/www/html

# Install PHP extensions + system deps
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl gd \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# Set Apache to Laravel public
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy app
COPY . /var/www/html

# Copy dependencies
COPY --from=vendor /app/vendor /var/www/html/vendor

# Copy built frontend
COPY --from=frontend /app/public/build /var/www/html/public/build

# Copy scripts
COPY docker/start.sh /usr/local/bin/start.sh
COPY docker/worker.sh /usr/local/bin/worker.sh

RUN chmod +x /usr/local/bin/start.sh /usr/local/bin/worker.sh \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 80

CMD ["/usr/local/bin/start.sh"]