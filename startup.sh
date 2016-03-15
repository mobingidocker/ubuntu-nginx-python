#!/bin/bash

echo "installing" > /var/log/container_status

echo "Running init script"
bash /tmp/init/init.sh

mkdir -p /srv/python
cp -r /srv/code /srv/python/app
chown -R www-data:www-data /srv/python/app

echo "Running Pip..."
cd /srv/python/app
pip install -r requirements.txt | tee /var/log/pip.log

if [ -f manage.py ]; then
  echo "Migrate database"
  python manage.py migrate | tee /var/log/migrate.log
fi
PYTHON_APP=${MOCLOUD_PYTHON_APP:-'myapp:app'}
sed -i -e "s@REPLACE_PYTHON_APPLICATION@${PYTHON_APP}@" /opt/uwsgi/uwsgi.ini

echo "complete" > /var/log/container_status

/usr/bin/supervisord
