FROM quay.io/vektorcloud/mesos:1.3.0 AS mesos

FROM quay.io/vektorcloud/scala AS marathon

ENV VERSION v1.4.5 \
  MAX_HEAP 3072m

RUN cd /tmp \
  && apk add --no-cache git \
  && git clone https://github.com/mesosphere/marathon.git \
  && cd marathon \
  && git checkout "$VERSION" \
  && SBT_OPTS="-Xmx$MAX_HEAP" sbt 'universal:packageBin'

# TODO: SHOULD be able to run this with our
# glibc + openjdk image but Marathon depends
# a Scala lib called Kamon which in turn
# depends on some other c lib called sigar.
# Alpine has a Sigar library but it doesn't 
# seem to work. 
# It sounds like you can also disable https://github.com/kamon-io/Kamon/issues/234
# Sigar but it's really beyond me at this point. 
# There is a relevant stack trace that is produced in ./trace.log

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
COPY --from=marathon /tmp/marathon/target/universal/ /tmp/

RUN mkdir /opt \
  && unzip -d /opt /tmp/marathon-*.zip \
  && ln -sv /opt/marathon-* /opt/marathon \
  && rm -rf /tmp/*

ENV MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos-1.3.0.so \
  PATH=$PATH:/opt/marathon/bin

ENTRYPOINT ["/opt/marathon/bin/marathon"]
