#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

ARG PHP_VERSION
FROM laradock/php-fpm:latest-${PHP_VERSION}

LABEL maintainer="João Prado <contato@joaoprado.com.br>"

ARG PHP_VERSION

ENV DEBIAN_FRONTEND noninteractive

RUN set -xe; \
    apt-get update -yqq && \
    pecl channel-update pecl.php.net && \
    apt-get install -yqq zlib1g-dev libicu-dev g++ jpegoptim optipng pngquant gifsicle libmagickwand-dev imagemagick \
    apt-utils \
    libzip-dev zip unzip && \
    docker-php-ext-configure zip && \
    docker-php-ext-configure  intl && \
    docker-php-ext-install zip bcmath opcache mysqli intl && \
    pecl install -o -f redis \
    && pecl install imagick \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis imagick &&  \
    php -m | grep -q 'zip'

RUN set -xe; php -v | head -n 1 | grep -q "PHP ${PHP_VERSION}."

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

USER root

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN groupmod -o -g 1000 www-data && \
    usermod -o -u 1000 -g www-data www-data

ENV LC_ALL POSIX

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
