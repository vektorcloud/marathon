FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -yyq wget \
  openjdk-8-jre \
  curl \
  subversion \
  libcurlpp-dev \
  openssl && \
  wget "https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb" -O /tmp/dumb_init.deb && \
  dpkg --install /tmp/dumb_init.deb && \
  rm /tmp/dumb* && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Mesos
RUN VERSION="1.1.x" && \
  PACKAGE="mesos-$VERSION-glibc.tar.gz" && \
  wget "https://github.com/vektorlab/mesos-packaging/releases/download/$VERSION/$PACKAGE" -O "/tmp/$PACKAGE" && \
  wget "https://github.com/vektorlab/mesos-packaging/releases/download/$VERSION/$PACKAGE.md5" -O "/tmp/$PACKAGE.md5" && \
  cd /tmp && \
  md5sum -c "$PACKAGE.md5" && \
  mkdir /tmp/mesos && \
  tar xvf "/tmp/$PACKAGE" -C / && \
  rm -rvf /tmp/*

# Marathon
RUN VERSION="1.3.5" && \
  wget http://downloads.mesosphere.com/marathon/v$VERSION/marathon-$VERSION.tgz -O /tmp/marathon.tgz && \
  tar xvf /tmp/marathon.tgz -C /opt && \
  ln -sv /opt/marathon-* /opt/marathon && \
  rm -v /tmp/*

ENV MARATHON_MASTER="zk://localhost:2181/mesos"

ENTRYPOINT ["/usr/bin/dumb-init", "/opt/marathon/bin/start"]
