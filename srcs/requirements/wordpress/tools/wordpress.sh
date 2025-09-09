#!/bin/bash

#when i will run the container i will search for the conf file for PHP-FPM to convert the 
#127.0.0.1:9000 to 0.0.0.0:9000 
#i will use sed -i to replace the specific info about ip:port
# by what i want the prototype
#sed -i 's/old_text/new_text/' file.txt


set -e
if [ ! -e .firstime ]; then
    sleep 10 #i will modified it later
    if [ ! -f wp-config.php]
    # diffrence between -e -f and why : 
    wp config create --allow-root
        --dbhost=mariadb \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbname="$DB_NAME"

#"$table_prefix" maybe i will change it from default state

    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL"
    fi
    touch .firstime
fi

#Without exec, your script would launch php-fpm82 as a child process, 
#and the script itself would keep running as PID 1.
#With exec, php-fpm82 becomes PID 1 inside the container → 
#this is important for signal handling (Docker needs to send 
#SIGTERM, SIGINT, etc. to the main process for clean shutdowns).

exec /usr/sbin/php-fpm82 -F