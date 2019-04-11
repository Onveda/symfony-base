# symfony-base Builder Debian

#################
# BUILD STAGE 1 #
#################

# get composer for further usage
FROM composer AS composer

#################
# BUILD STAGE 2 #
#################

FROM php:7.2-fpm

# copy Composer files from Composer image
COPY --from=composer /usr/bin/composer /usr/bin/composer


# Install recommended extensions for Symfony
RUN apt-get update && apt-get install -y \
        libicu-dev zip unzip zlib1g-dev libpng-dev git \
        libxrender1 libfontconfig1 libfreetype6 \
    && docker-php-ext-install \
        intl \
        opcache \
        pdo \
        pdo_mysql \
        mysqli \
        zip \
        gd

RUN pecl install -o -f redis && docker-php-ext-enable redis