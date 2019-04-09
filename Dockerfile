# symfony-base Builder

#################
# BUILD STAGE 1 #
#################

# get composer for further usage
FROM composer AS composer

#################
# BUILD STAGE 1 #
#################

FROM php:7.2-fpm-alpine

# copy Composer files from Composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer


## Install Redis
ENV REDIS_VERSION 4.3.0

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$REDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-* /usr/src/php/ext/redis

RUN docker-php-ext-install redis

# Install recommended extensions for Symfony
RUN apk update && apk add \
        icu-dev zip unzip libzip-dev libpng-dev git libxrender fontconfig freetype
        
RUN docker-php-ext-install zip pdo_mysql intl opcache pdo mysqli gd
