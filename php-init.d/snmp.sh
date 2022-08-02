#!/bin/sh

apt-get update && \
apt-get install -y libsnmp-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) snmp
