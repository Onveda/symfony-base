FROM php:7.1

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

RUN apt-get update \
    && apt-get install -y \
        bash \
        build-essential \
        curl \
        git \
        mercurial \
        subversion \
        openssl \
        unzip \
        wget \
        yarn \
        zlib1g-dev \
        zip

ENV PHPREDIS_VERSION php7

RUN docker-php-ext-install pdo_mysql mbstring zip bcmath

RUN pecl install redis && docker-php-ext-enable redis

ENV DOCKERIZE_VERSION v0.4.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Install composer
RUN mkdir /composer && chmod 777 /composer

RUN echo "memory_limit=-1" > "$PHP_INI_DIR/conf.d/memory-limit.ini"

COPY install_composer.sh /tmp/install_composer.sh

RUN chmod +x /tmp/install_composer.sh

RUN /tmp/install_composer.sh \
    && rm /tmp/install_composer.sh \
    && composer global require hirak/prestissimo

# Install application
ARG SYMFONY_ENV
ENV SYMFONY_ENV prod

RUN mkdir /app
WORKDIR /app
