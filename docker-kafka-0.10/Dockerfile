FROM oracle-jdk/ver:8

ARG kafka_version=0.10.2.0
ARG scala_version=2.12

MAINTAINER Jesus Alberto Sanchez Arrieta

RUN apk add --update unzip wget curl docker jq coreutils

ENV KAFKA_VERSION=$kafka_version SCALA_VERSION=$scala_version
ADD docker-kafka-0.10/download-kafka.sh /tmp/download-kafka.sh
RUN chmod a+x /tmp/download-kafka.sh && sync && /tmp/download-kafka.sh && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka
ENV PATH ${PATH}:${KAFKA_HOME}/bin
ADD docker-kafka-0.10/start-kafka.sh /usr/bin/start-kafka.sh
ADD docker-kafka-0.10/broker-list.sh /usr/bin/broker-list.sh
ADD docker-kafka-0.10/create-topics.sh /usr/bin/create-topics.sh
# The scripts need to have executable permission
RUN chmod a+x /usr/bin/start-kafka.sh && \
    chmod a+x /usr/bin/broker-list.sh && \
    chmod a+x /usr/bin/create-topics.sh
# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]

#To Build
#docker build -t apache-kafka/ver:0.10.0.2 -f Dockerfile .
#To run
