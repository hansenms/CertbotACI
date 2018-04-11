#!/bin/sh

#
#  ENVIRONMENT VARIABLES:
#  godaddykey="KEY-VALUE"
#  godaddysecret="SECRET-VALUE"

# Strip only the top domain to get the zone id
DOMAIN=$(echo -n $CERTBOT_DOMAIN | rev | cut -d"." -f1,2 | rev)
SITE=$(expr match "$CERTBOT_DOMAIN" '\*\?\.\?\(.*\)\..*\..*')

if [ -n "$SITE" ]; then
   CREATESITE="_acme-challenge.${SITE}"
else
   CREATESITE="_acme-challenge"
fi

OUT=$(curl -s -X PUT https://api.godaddy.com/v1/domains/${DOMAIN}/records/TXT/${CREATESITE} \
           -H "Authorization: sso-key ${godaddykey}:${godaddysecret}" \
           -H "Content-Type: application/json" \
           -H "Accept: application/json" \
           --data '{"data": "'"$CERTBOT_VALIDATION"'", "ttl":3600}')

sleep 25