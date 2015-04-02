#!/bin/bash

echo "installing" > /var/log/container_status

echo "Running init script"
bash /tmp/init/init.sh

sed -i "s#module=website.wsgi:application#module=${MODULE}.wsgi:application#g" /opt/django/uwsgi.ini

if [ ! -f "/srv/django/app/manage.py" ]
then
	echo "creating basic django project (module: ${MODULE})"
	django-admin.py startproject ${MODULE} /opt/django/app/
fi

mkdir -p /srv/django
cp -r /srv/code /srv/django/app
chown -R www-data:www-data /srv/django/app

echo "complete" > /var/log/container_status

/usr/bin/supervisord
