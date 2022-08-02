#!/bin/sh

apt-get update && \
apt-get install -y libenchant-2-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) enchant
