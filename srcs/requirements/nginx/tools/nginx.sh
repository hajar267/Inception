#!/bin/bash

set -e

openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/private/nginx.key \
-out /etc/ssl/certs/nginx.crt \
-subj "/CN=${DOMAIN_NAME}" > /dev/null 2>/dev/null

cat << EOF >> /etc/nginx/conf.d/wordpress.conf

server {
    listen 443 ssl;

    server_name $DOMAIN_NAME;
    root /var/www/html;
    index index.php index.html;

    ssl_certificate /etc/ssl/certs/nginx.crt;
    ssl_certificate_key /etc/ssl/private/nginx.key;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

exec nginx -g 'daemon off;'