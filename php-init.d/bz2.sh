#!/bin/sh

apt-get update && \
apt-get install -y libbz2-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) bz2
