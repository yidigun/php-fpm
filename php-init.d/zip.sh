#!/bin/sh

apt-get update && \
apt-get install -y libzip-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) zip
