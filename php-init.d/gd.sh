#!/bin/sh

apt-get update && \
apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
/usr/local/bin/docker-php-ext-configure gd --with-freetype --with-jpeg && \
/usr/local/bin/docker-php-ext-install -j$(nproc) gd
