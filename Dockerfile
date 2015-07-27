FROM ubuntu:14.04
MAINTAINER david.siaw@mobingi.com

RUN apt-get update --fix-missing
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

RUN apt-get install -y nginx

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential git python python-dev python-setuptools sqlite3 supervisor
RUN easy_install pip
RUN pip install uwsgi

RUN rm /etc/nginx/sites-enabled/default

RUN mkdir -p /opt/django/app
ADD uwsgi_params /opt/uwsgi/uwsgi_params
ADD uwsgi.ini /opt/uwsgi/uwsgi.ini

COPY config /config
COPY nginx.conf /etc/nginx/sites-enabled/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sudoers /etc/sudoers

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD run.sh /run.sh
ADD startup.sh /startup.sh
RUN chmod 755 /*.sh

EXPOSE 22 80
CMD ["/run.sh"]
