# PHP-FPM

PHP base image for ```php-fpm``` fast cgi daemon.

## PHP License

See https://www.php.net/license/index.php

## Dockerfile License

It's just free. (Public Domain)

See https://github.com/yidigun/php-fpm

## Use Image

Prepare document root. PHP worker process is run as www-data. (uid=33, gid=33)

```shell
sudo chown -R 33:33 /data/wordpress/html/wp-content/uploads
```

Create container. To install or enable PHP extensions, use ```PHP_EXTENSIONS``` environment variable.
And you can install [PEAR](https://pear.php.net/) module, using ```PHP_PEAR```.

```yaml
version: '3'

services:
  wordpress:
    container_name: wordpress
    image: docker.io/yidigun/php-fpm:8.1
    restart: unless-stopped
    environment:
      - LANG=ko_KR.UTF-8
      - TZ=Asia/Seoul
      - PHP_EXTENSIONS="pdo_mysql mysqli gd opcache"
      - PHP_PEAR="Mail_Mime Var_Dump"
    volumes:
      - /data/wordpress/html:/var/www/html
      - /data/wordpress/etc/my-php.ini:/usr/local/etc/php/conf.d/my-php.ini
  nginx:
    image: docker.io/library/nginx:latest
    container_name: nginx-wordpress
    restart: unless-stopped
    environment:
      - LANG=ko_KR.UTF-8
      - TZ=Asia/Seoul
    ports:
      - "80:80/tcp"
      - "443:443/tcp"
    volumes:
      - /data/wordpress/html:/var/www/html
      - /data/wordpress/etc/default.conf:/etc/nginx/conf.d/default.conf
```

Here is default.conf example.

```
server {
    listen       80;
    listen  [::]:80;
    server_name  your.domain.com;

    root   /var/www/html;
    location / {
        index index.php index.html;
        try_files $uri $uri/ /index.php?$args;
    }
    location ~ '\.php$' {
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        #fastcgi_split_path_info ^(/w)(/.*)$;
        include fastcgi_params;
    }
}
```

## TODO

### Database Connectivity

Install script for following extensions are in progress:

* oci8
* pdo_oci
* odbc
* pdo_odbc
* pdo_dblib
* pdo_firebird

### Sending mail

How to install ```/usr/sbin/sendmail``` for ```mail()``` function.
