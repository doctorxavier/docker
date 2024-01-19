FROM oracle-jdk/ver:8
MAINTAINER Jesus Alberto Sanchez Arrieta <sanchezajesus@gmail.com>

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.9

LABEL name="zookeeper" version=$VERSION

RUN apk add --no-cache wget bash \
    && mkdir -p /opt \
    && wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$VERSION /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]

#docker build -t apache-zookeeper/ver:3.4.9 -f Dockerfile .
#docker run -d --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888  apache-zookeeper/ver:3.4.9
