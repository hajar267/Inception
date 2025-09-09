#!/bin/bash
set -e
if [ ! -e /etc/.firsttime ]; then
cat << EOF >> /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF
#  cuz the default is 127.0.0.1 (local connection)
#  to not skipping remote connections
touch /etc/.firsttime
fi

if [ ! -e /var/lib/mysql/.firstime ]; then


mysql_install_db
# Creates the system database called mysql
#Stores users, privileges, internal metadata, system tables.
#Creates default accounts like root@localhost.
#Sets up the directory structure where all future databases and 
#tables will be stored (usually /var/lib/mysql).

# (skip test db) The test database is publicly accessible by default — any user 
#(even anonymous) could connect and create tables

	mysqld_safe &
#used to start mysqld (server) &: runs it in the background

sleep 10

cat << EOF | mariadb -u root --password="${DB_ROOT_PASSWORD}"
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
EOF

mysqladmin -u root -p"$DB_ROOT_PASSWORD"  shutdown
#mysqladmin it's a operating and controlling the server like pinging or check server status or shutdown a running server ....
touch /var/lib/mysql/.firstime
fi
exec mysqld_safe -u mysql

#

#try bootstrap

