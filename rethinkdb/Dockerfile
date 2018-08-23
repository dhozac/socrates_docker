FROM centos:7
RUN yum install -y openssl-devel libcurl-devel wget tar m4 git-core \
                 boost-static m4 gcc-c++ npm ncurses-devel which \
                 make ncurses-static zlib-devel zlib-static \
                 bzip2 patch epel-release \
                 python-devel \
                 && yum clean all && rm -fr /var/cache/yum
RUN yum install -y protobuf-devel protobuf-static jemalloc-devel \
                 && yum clean all && rm -fr /var/cache/yum && \
    git clone https://github.com/dhozac/rethinkdb.git /usr/src/rethinkdb && \
    cd /usr/src/rethinkdb && \
    git checkout ip-address-v2.3.x && \
    ./configure --allow-fetch --dynamic jemalloc && \
    make && \
    make install && \
    rm -fr /usr/src/rethinkdb && \
    useradd -r rethinkdb -d /srv/rethinkdb
USER rethinkdb
VOLUME /srv/rethinkdb
CMD rethinkdb -d /srv/rethinkdb --bind all --runuser rethinkdb --rungroup rethinkdb
EXPOSE 28015
