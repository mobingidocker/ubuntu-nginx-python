#!/bin/bash

echo "installing" > /var/log/container_status

echo "Running init script"
bash /tmp/init/init.sh

mkdir -p /srv/django
cp -r /srv/code /srv/django/app
chown -R www-data:www-data /srv/django/app

pushd /srv/django/app
	pip install -r requirements.txt
popd

echo "complete" > /var/log/container_status

/usr/bin/supervisord
