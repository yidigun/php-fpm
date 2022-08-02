#!/bin/sh

apt-get update && \
apt-get install -y libicu-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) intl
