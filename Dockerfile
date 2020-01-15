FROM php:7.2-apache
RUN apt-get update -y && \
    apt-get install -y \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxpm-dev \
        libfreetype6-dev \
        zlib1g-dev \
        libzip-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-webp-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure bcmath --enable-bcmath \
    && docker-php-ext-install mysqli pdo pdo_mysql mbstring zip gd exif bcmath \
    && pecl install xdebug-2.7.0 \
    && docker-php-ext-enable xdebug \
    && a2enmod rewrite \

# Composer
ENV COMPOSER_HOME /var/www/.composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer
RUN mkdir -p $COMPOSER_HOME/cache
