#!/bin/bash
set -e
if [ ! -e /etc/.firsttime ]; then
cat << EOF >> /etc/my.cnf.d/mariadb-server.cnf
[mysqld]
bind-address=0.0.0.0
skip-networking=0
EOF
#  cuz the default is 127.0.0.1 (local connection)
#  to not skipping remote connections
touch /etc/.firsttime
fi

if [ ! -e /var/lib/mysql/.firstime ]; then
mysql_install_db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql 
	--auth-root-authentication-method=socket >/dev/null 2>/dev/null
	mysqld_safe &
	#used to start the MariaDB or MySQL database server
	mysqld_pid=$!
	#to get id of last execute process to use it later (not necessary)
until mysqladmin ping -u root --silent --wait=30; do
      sleep 1
    done
#manually enter each SQL command directly into the MariaDB 
#command-line client we automated it by writing command into clinet mariadb 
#interface directly by "mariadb -u root --password="${DB_ROOT_PASSWORD}"
cat << EOF | mariadb -u root --password="${DB_ROOT_PASSWORD}"
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
EOF

mysqladmin shutdown
#The mysqld_safe & command starts a MariaDB server instance in the background. 
#This server is only running temporarily to allow the script to perform the initial 
#setup tasks, like creating the database and user. Once those tasks are complete, 
#this temporary process needs to be stopped for a few reasons
touch /var/lib/mysql/.firstime
fi
exec mysqld_safe