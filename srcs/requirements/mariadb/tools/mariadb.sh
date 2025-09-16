#!/bin/bash
set -e
if [ ! -e /etc/.firsttime ]; then
cat << EOF >> /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
bind-address=0.0.0.0
EOF
touch /etc/.firsttime
fi

if [ ! -e /var/lib/mysql/.firstime ]; then
mysql_install_db
mysqld_safe &
mysqladmin ping -u root --silent --wait=30 >/dev/null 2>/dev/null
cat << EOF | mariadb -u root --password="${DB_ROOT_PASSWORD}"
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
mysqladmin -u root -p"$DB_ROOT_PASSWORD"  shutdown
touch /var/lib/mysql/.firstime
fi
exec mysqld_safe -u mysql

