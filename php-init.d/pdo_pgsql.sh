#!/bin/sh

apt-get update && \
apt-get install -y libpq-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) pdo_pgsql
