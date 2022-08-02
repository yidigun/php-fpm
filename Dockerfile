ARG IMG_TAG
FROM docker.io/library/php:${IMG_TAG}-fpm

ARG IMG_NAME
ARG IMG_TAG
ARG LANG=en_US.UTF-8
ARG TZ=Etc/UTC

ENV IMG_NAME=$IMG_NAME
ENV IMG_TAG=$IMG_TAG
ENV LANG=$LANG
ENV TZ=$TZ
ENV PHP_EXTENSTIONS="opcache"

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get -y install locales tzdata iproute2 net-tools telnet \
                         traceroute iputils-ping lsof psmisc procps curl && \
    apt-get clean

RUN sed -i -e "/${LANG}/s/^# *//" /etc/locale.gen && locale-gen && \
    update-locale LANG=$LANG && \
    [ -n "$TZ" -a -f /usr/share/zoneinfo/$TZ ] && \
      ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

COPY entrypoint.sh /entrypoint.sh
COPY php-init.d /usr/local/bin/php-init.d

EXPOSE 9000/tcp
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "php-fpm" ]
