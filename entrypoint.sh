#!/bin/sh

# try to set locale and timezone
if locale -a 2>/dev/null | grep -q "$LANG"; then :
else
  sed -i -e "/${LANG}/s/^# *//" /etc/locale.gen && locale-gen
  update-locale LANG=$LANG 2>/dev/null
fi
if [ -n "$TZ" ] && [ -f /usr/share/zoneinfo/$TZ ]; then
  ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
fi

# initialize php
init_dir=/usr/local/bin/php-init.d
extension_dir=$(php -r 'echo ini_get("extension_dir")."\n";')
for module in $PHP_EXTENSIONS; do
  if php -m | grep -qi $module 2>/dev/null; then
    echo "php-init: ${module} is installed and activated."
  else
    if [ -f $extension_dir/$module.so ]; then
      echo -n "php-init: ${module} is installed. Ativating..."
      /usr/local/bin/docker-php-ext-enable $module || exit 1
    elif [ -x $init_dir/$module.sh ]; then
      echo -n "php-init: ${module} is not installed. Installing..."
      /usr/local/bin/php-init.d/$module.sh || exit 1
    else
      echo -n "php-init: ${module} is not installed. Installing..."
      /usr/local/bin/docker-php-ext-install -j$(nproc) $module || exit 1
    fi
  fi
done
for pear in $PHP_PEAR; do
  pear install $pear || exit 1
done

php -i
pear list
echo "php-init: PHP initialized."

CMD=$1; shift
case $CMD in
  start|run|php-fpm|/usr/local/sbin/php-fpm)
    exec /usr/local/sbin/php-fpm "$@"
    ;;

  php)
    exec php "$@"
    ;;

  phpinfo|-i)
    exec php -i "$@"
    ;;

  sh|bash|/bin/sh|/bin/bash)
    exec /bin/bash "$@"
    ;;

  *)
    echo "usage: $0 { run [ ARGS ... ] | sh [ ARGS ... ] | php [ ARGS ... ] | phpinfo }"
    ;;
esac
