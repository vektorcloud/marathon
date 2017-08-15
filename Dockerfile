FROM quay.io/vektorcloud/mesos:1.3.0 AS mesos

FROM frolvlad/alpine-oraclejdk8:slim

RUN apk add --no-cache \
  bash \
  binutils \
  coreutils \
  curl \
  fts \
  libstdc++ \
  openssl \
  subversion \
  tar 

COPY --from=mesos /usr/local/lib/libmesos-1.3.0.so /usr/lib

RUN mkdir /opt \ 
  && curl http://downloads.mesosphere.com/marathon/v1.4.6/marathon-1.4.6.tgz -o /tmp/marathon.tgz \
  && tar -C /opt -xvf /tmp/marathon.tgz \
  && ln -sv /opt/marathon-* /opt/marathon \
  && rm -rf /tmp/*

ENV MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos-1.3.0.so \
  PATH=$PATH:/opt/marathon/bin

ENTRYPOINT ["/opt/marathon/bin/start"]
