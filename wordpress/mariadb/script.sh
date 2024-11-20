#!/bin/bash

# Signal handling function
cleanup() {
    echo "Stopping MariaDB..."
    mysqladmin -u root shutdown
    exit 0
}

# Register signal handlers
trap cleanup SIGTERM SIGINT

# Ensure directories exist with correct permissions
mkdir -p /var/run/mysqld /var/lib/mysql /var/log/mysql
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mysql
chmod 755 /var/run/mysqld

# Initialize MariaDB if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB temporarily for initialization
mysqld_safe --user=mysql --datadir=/var/lib/mysql &
MYSQL_PID=$!

# Wait for MariaDB to be ready
for i in {1..30}; do
    if mysqladmin ping -h localhost --silent; then
        echo "MariaDB is ready!"
        break
    fi
    echo "Waiting for MariaDB to start... ($i/30)"
    sleep 2
    if [ $i -eq 30 ]; then
        echo "MariaDB failed to start within 60 seconds"
        exit 1
    fi
done

# Create database and user
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'wordpress_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';
FLUSH PRIVILEGES;
EOF

# Wait for MySQL process while allowing signal handling
wait $MYSQL_PID
