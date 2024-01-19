FROM centos:7

MAINTAINER everis

COPY /root /

RUN yum -q -y update && yum install -q -y nano wget unzip && \
        rm -f /etc/localtime && \
        ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
