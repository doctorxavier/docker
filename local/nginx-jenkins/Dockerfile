FROM nginx:1.13.1-alpine

MAINTAINER everis

COPY /root /

RUN apk upgrade --update && \
        apk add --update tzdata curl wget bash nano openssl && \
        cp /usr/share/zoneinfo/America/Bogota /etc/localtime && \
        echo "America/Bogota" > /etc/timezone && \
        echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
		openssl genrsa -des3 -rand /dev/urandom -out /etc/ssl/private/server.key.encrypted 4096 && \
		chmod 600 /etc/ssl/private/server.key.encrypted && \
		openssl req -config /etc/ssl/private/openssl.cnf -new -key /etc/ssl/private/server.key.encrypted -out /etc/ssl/private/server.csr && \
		openssl rsa -in /etc/ssl/private/server.key.encrypted -out /etc/ssl/private/server.key && \
		openssl x509 -req -days 365 -in /etc/ssl/private/server.csr -signkey /etc/ssl/private/server.key.encrypted -out /etc/ssl/private/server.crt

EXPOSE 80 443
