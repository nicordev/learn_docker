FROM php:7.4-fpm

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

RUN apt-get update && \
    apt-get install -y \
        curl \
        zip \
        unzip \
        wget && \
  docker-php-ext-install pdo pdo_mysql
