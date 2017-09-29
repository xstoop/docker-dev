FROM php:7.1-fpm

RUN curl -o /etc/apt/sources.list http://mirrors.163.com/.help/sources.list.jessie \
        && apt-get update \
        && apt-get install -y libmcrypt-dev \
        libmemcached-dev \
        zlib1g-dev \
        libpq-dev \
        libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
        && pecl install redis-3.1.4 \
        && pecl install memcached-3.0.3 \
        && pecl install xdebug-2.5.5 \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install -j$(nproc) mcrypt \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install pdo_pgsql \
        && docker-php-ext-install gettext \
        && docker-php-ext-enable memcached redis xdebug
