FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

COPY tools/nginx.sh /usr/local/bin

# COPY tools/wrdpss.conf /etc/nginx/conf.d

# WORKDIR /etc/nginx/ssl 

RUN chmod +x /usr/local/bin/nginx.sh

ENTRYPOINT [ "nginx.sh" ]