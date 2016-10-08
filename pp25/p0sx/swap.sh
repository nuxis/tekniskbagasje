#!/usr/bin/env bash

FROM="p0sx1"
TO="p0sx2"
VHOST=/etc/nginx/conf.d/p0sx.pp25.polarparty.no.conf

if grep --quiet "uwsgi_pass $TO" $VHOST; then
	FROM="p0sx2"
	TO="p0sx1"
fi	

echo "Changing from $FROM to $TO"

perl -pi -e "s#uwsgi_pass $FROM#uwsgi_pass $TO#g" $VHOST
if [ $? -ne 0 ]; then
  echo "Failed to update nginx configuration"
  exit 2
fi

echo "Starting a new docker container"
docker-compose up -d $TO
if [ $? -ne 0 ]; then
  echo "Failed to start new docker container"
  exit 13
fi

echo "Sleeps until container starts"
sleep 15

echo "Reloading nginx"
service nginx reload

echo "Stopping old container"
docker-compose stop $FROM
