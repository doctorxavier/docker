FROM ubuntu:xenial
MAINTAINER Jesus Alberto Sanchez Arrieta <sanchezajesus@gmail.com>


# Install Oracle Java 8
RUN apt-get update && apt-get install -y wget unzip software-properties-common \
    && add-apt-repository ppa:webupd8team/java && apt-get update \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get -y install oracle-java8-installer  \
    && /bin/bash -c "source /etc/profile.d/jdk.sh" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists  \
    && rm -rf /var/cache/oracle-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH /usr/lib/jvm/java-8-oracle/bin:$PATH

# Public to Registry
# docker build -t ubuntu-xenial/java-ver:1.8  -f Dockerfile.dockerfile .