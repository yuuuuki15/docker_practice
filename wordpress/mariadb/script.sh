#!/bin/bash

service mysql start

# Create database and user
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
# mysql -u root << EOF
# CREATE DATABASE IF NOT EXISTS 'wordpress';
# CREATE USER IF NOT EXISTS 'ykawakit'@'%' IDENTIFIED BY 'Kyuki-86340616';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'ykawakit'@'%';
# FLUSH PRIVILEGES;
# EOF

# Import WordPress data
mysql -u root $MYSQL_DATABASE < /wordpress.sql
# mysql -u root wordpress < /wordpress.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
