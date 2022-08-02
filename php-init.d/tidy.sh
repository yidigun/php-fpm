#!/bin/sh

apt-get update && \
apt-get install -y libtidy-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) tidy
