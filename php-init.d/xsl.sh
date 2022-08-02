#!/bin/sh

apt-get update && \
apt-get install -y libxslt-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) xsl
