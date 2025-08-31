FROM alpine:3.19.2

RUN apk update && apk add mariadb mariadb-client bash

COPY tools/mariadb.sh /usr/local/bin

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT [ "mariadb.sh" ]