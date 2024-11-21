#!/bin/bash

mkdir -p /var/www/html

cd /var/www/html

rm -rf *

curl -O https://wordpress.org/latest.tar.gz

tar -xvf latest.tar.gz

rm -rf latest.tar.gz

mv wordpress/* .

rm -rf wordpress

# mv /wp-config.php .

echo "Wordpress installed"

cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
sed -i "s/localhost/mariadb/g" wp-config.php

echo "Wordpress configured"

/usr/sbin/php-fpm7.3 -R -F
