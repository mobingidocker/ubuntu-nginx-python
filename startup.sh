#!/bin/bash

echo "installing" > /var/log/container_status

echo "Running init script"
bash /tmp/init/init.sh

mkdir -p /srv/django
cp -r /srv/code /srv/django/app
chown -R www-data:www-data /srv/django/app

echo "Running Pip..."
cd /srv/django/app
pip install -r requirements.txt | tee /var/log/pip.log

if [ -f manage.py ]; then
  echo "Migrate database"
  python manage.py migrate | tee /var/log/migrate.log
fi

echo "complete" > /var/log/container_status

/usr/bin/supervisord
