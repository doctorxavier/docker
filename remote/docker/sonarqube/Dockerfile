FROM centos-java:8-jre

MAINTAINER everis

ENV SONAR_VERSION=6.4 \
    SONARQUBE_HOME=/opt/sonarqube

COPY /root /

RUN yum -q -y update && yum install -q -y wget nano unzip \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
	&& cd /opt \
	&& curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
	&& curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
	&& gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    	&& unzip sonarqube.zip \
    	&& mv sonarqube-$SONAR_VERSION sonarqube \
    	&& rm sonarqube.zip*

VOLUME "$SONARQUBE_HOME/data"
