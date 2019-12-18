FROM php:7.2-apache
RUN apt-get update -y && \
    apt-get install -y \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxpm-dev \
        libfreetype6-dev \
        zlib1g-dev \
        libzip-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-webp-dir=/usr/include/  --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install mysqli pdo pdo_mysql mbstring zip gd exif
RUN pecl install xdebug-2.7.0
RUN docker-php-ext-enable xdebug
RUN a2enmod rewrite
