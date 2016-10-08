#!/usr/bin/env sh

NGINX_CONF=/etc/nginx/conf.d

DIR=/tmp/letsencrypt-auto
SUBDOMAINS=`ls -1 $NGINX_CONF | sed 's/\.conf//g' | ag '[a-z]*\.[a-z]*\.' | sed 's/^/ -d /g' | tr '\n' ' '`
DOMAINS=`ls -1 $NGINX_CONF | sed 's/\.conf//g' | ag '^[a-z]*\.[a-z]{2,3}$' | sed -E 's/(.*)/\1 -d www\.\1/g' | sed 's/^/ -d /g' | tr '\n' ' '`


mkdir -p $DIR
certbot certonly \
    --webroot \
    -w $DIR \
    --agree-tos \
    --expand \
    --keep \
    -m kradalby@kradalby.no \
    --rsa-key-size 4096 \
    $DOMAINS $SUBDOMAINS
