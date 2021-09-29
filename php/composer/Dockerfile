FROM php:7.4

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

ENV COMPOSER_HOME /var/www/.composer
VOLUME /var/www/.composer

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get install -y libzip-dev && \
    docker-php-ext-install zip
