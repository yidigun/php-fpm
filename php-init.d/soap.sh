#!/bin/sh

apt-get update && \
apt-get install -y libxml2-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) soap
