FROM php:8.3-cli

RUN apt-get update && apt-get install -y \
    git unzip libpq-dev libzip-dev curl \
 && docker-php-ext-install pdo pdo_pgsql zip

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . /app

RUN composer install --no-dev --optimize-autoloader

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs \
 && npm install \
 && npm run build

RUN php artisan config:cache && php artisan route:cache

EXPOSE 10000

CMD php -S 0.0.0.0:${PORT:-10000} -t public