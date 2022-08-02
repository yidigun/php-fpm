#!/bin/sh

apt-get update && \
apt-get install -y libldap2-dev && \
/usr/local/bin/docker-php-ext-install -j$(nproc) ldap
