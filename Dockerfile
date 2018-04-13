FROM certbot/certbot

WORKDIR /opt/certbot

ADD go_daddy_dns_authenticator.sh /opt/certbot/

RUN chmod +x ./go_daddy_dns_authenticator.sh

RUN apk add --no-cache --virtual .build-deps \
    bash \
    curl


