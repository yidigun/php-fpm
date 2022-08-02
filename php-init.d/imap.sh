#!/bin/sh

apt-get update && \
apt-get install -y libc-client2007e-dev libkrb5-dev && \
/usr/local/bin/docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
/usr/local/bin/docker-php-ext-install -j$(nproc) imap
