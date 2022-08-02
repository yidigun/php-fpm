#!/bin/sh

apt-get update && \
apt-get install -y libpspell-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) pspell
