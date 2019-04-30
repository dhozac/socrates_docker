FROM centos:7
RUN yum install -y epel-release python-devel dmidecode gcc git openldap-devel \
                 && yum clean all && rm -fr /var/cache/yum
RUN yum install -y python-pip nginx nodejs mysql-devel \
                 && yum clean all && rm -fr /var/cache/yum
RUN sed -i -e '47,48d' /etc/nginx/nginx.conf
RUN pip --no-cache-dir install socrates_api bonk socrates_gui Django==1.11.15 \
        gunicorn mysqlclient django-auth-ldap pyvmomi ansible && \
    rm -fr /tmp/pip-build*
RUN cd /srv && django-admin startproject socrates
VOLUME /srv/socrates/socrates_local
VOLUME /srv/socrates/playbooks
ADD settings.py /srv/socrates/socrates/settings.py
ADD urls.py /srv/socrates/socrates/urls.py
ADD start.sh /srv/socrates/start.sh
ADD nginx.conf /etc/nginx/default.d/socrates.conf
RUN cd `python -c 'import socrates_gui, os; print(os.path.dirname(socrates_gui.__file__))'` && \
    npm install && \
    NODE_PATH=$PWD/node_modules PATH=$PWD/node_modules/.bin:$PATH /srv/socrates/manage.py collectstatic --noinput
EXPOSE 80
CMD /srv/socrates/start.sh
