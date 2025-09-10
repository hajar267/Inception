#!/bin/bash

#when i will run the container i will search for the conf file for PHP-FPM to convert the 
#127.0.0.1:9000 to 0.0.0.0:9000 
#i will use sed -i to replace the specific info about ip:port
# by what i want the prototype
#sed -i 's/old_text/new_text/' file.txt

sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
# echo "---> $PWD"

set -e
if [ ! -e .firstime ]; then

    sleep 10 #i will modified it later
    if [ ! -f wp-config.php ]; then
    # echo "heere"
    # diffrence between -e -f and why :
    # cp wp-config-sample.php wp-config.php

    # sed -i "s/database_name_here/$DB_NAME/" wp-config.php
    # sed -i "s/username_here/$DB_USER/" wp-config.php
    # sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
    # sed -i "s/localhost/mariadb:3306/" wp-config.php

    wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost=mariadb

#"$table_prefix" maybe i will change it from default state

    wp core install --allow-root --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER"  --admin_password="$WORDPRESS_ADMIN_PASSWORD"        --admin_email="$WORDPRESS_ADMIN_EMAIL"
    fi
    touch .firstime
fi

#Without exec, your script would launch php-fpm82 as a child process, 
#and the script itself would keep running as PID 1.
#With exec, php-fpm82 becomes PID 1 inside the container → 
#this is important for signal handling (Docker needs to send 
#SIGTERM, SIGINT, etc. to the main process for clean shutdowns).

exec php-fpm8.2 -F
# exec /usr/sbin/php-fpm8.2 -F



#PS C:\Users\DELL\OneDrive\Desktop\incpt\srcs\requirements> docker logs wordpress
#Error: Database connection error (2002) Connection refused
#Error: 'wp-config.php' not found.
#Either create one manually or use `wp config create`.