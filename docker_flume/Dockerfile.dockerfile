FROM ubuntu-xenial/java-ver:1.8

MAINTAINER Jesus Alberto Sanchez Arrieta <sanchezajesus@gmail.com>

RUN apt-get update && apt-get install -y wget unzip software-properties-common \
    && mkdir -p /opt/flume && mkdir -p /opt/flume/data && mkdir -p /opt/flume/conf \
    && wget -qO- http://www-us.apache.org/dist/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz | tar zxvf - -C /opt/flume --strip 1 
    
ADD docker_flume/config/plot.conf /opt/flume/conf
ADD docker_flume/scripts/start-flume.sh /opt/flume/bin
ADD docker_flume/lib/hadoop-common-2.7.1.jar /opt/flume/lib
ADD docker_flume/lib/commons-configuration-1.6.jar /opt/flume/lib
ADD docker_flume/lib/hadoop-auth-2.7.1.jar /opt/flume/lib
ADD docker_flume/lib/hadoop-hdfs-2.7.1.jar /opt/flume/lib
ADD docker_flume/lib/htrace-core-3.1.0-incubating.jar /opt/flume/lib
ADD docker_flume/lib/commons-io-2.4.jar /opt/flume/lib

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH /opt/flume/bin:/usr/lib/jvm/java-8-oracle/bin:$PATH

RUN sed -i -e 's/\r$//' /opt/flume/bin/start-flume.sh && chmod +x /opt/flume/bin/start-flume.sh
CMD [ "/opt/flume/bin/start-flume.sh" ]

#Build images base on Custom ubuntu-xenial/java-ver:1.8
#docker build -t apache-flume/ver:1.7  -f Dockerfile.dockerfile .
#To Run 
#docker run --name flume-fraco  -e FLUME_CONF_DIR=/opt/flume/conf -e FLUME_AGENT_NAME=plotAgent -e FLUME_CONF_FILE=/opt/flume/conf/plot.conf -d apache-flume/ver:1.7 
