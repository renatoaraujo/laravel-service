FROM php:8.1-fpm

RUN apt-get update && apt-get install -y libpng-dev libonig-dev libxml2-dev zip unzip git && \
    docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

WORKDIR /var/www/html

COPY ./src/composer.lock ./src/composer.json /var/www/html/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-scripts --no-autoloader --no-dev

COPY ./src /var/www/html/

RUN chown -R www-data:www-data /var/www/html && \
    composer dump-autoload --optimize && \
    composer run-script post-autoload-dump
