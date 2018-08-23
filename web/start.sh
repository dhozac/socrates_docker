#!/bin/bash -ex

cd /srv/socrates
# Give RethinkDB and MySQL time to start
sleep 5
/srv/socrates/manage.py migrate
/srv/socrates/manage.py syncrethinkdb
nginx
export DJANGO_SETTINGS_MODULE=socrates.settings
celery worker -A socrates.celery:app -D -l info -P gevent
gunicorn \
	--bind 127.0.0.1:8000 \
	--workers 3 \
	--access-logfile '-' \
	--user nobody \
	--group nobody \
	socrates.wsgi:application
