FROM centos-java:8-jdk

MAINTAINER everis

ENV ARTIFACTORY_HOME=/var/opt/jfrog/artifactory

COPY /root /

RUN yum -q -y update && yum -q -y install wget nano && cd /tmp && \ 
	wget https://bintray.com/jfrog/artifactory-rpms/rpm -O bintray-jfrog-artifactory-rpms.repo && \
	mv bintray-jfrog-artifactory-rpms.repo /etc/yum.repos.d/ && yum -q -y install jfrog-artifactory-oss && \
	wget https://jdbc.postgresql.org/download/postgresql-42.1.1.jar && mv postgresql-42.1.1.jar $ARTIFACTORY_HOME/tomcat/lib/ && \
	chmod 774 $ARTIFACTORY_HOME/tomcat/lib/postgresql-42.1.1.jar && \
	mv /tmp/postgresql.properties $ARTIFACTORY_HOME/etc/db.properties && mv/tmp/default /etc/opt/jfrog/artifactory/ && \
	/etc/init.d/artifactory start
	
VOLUME ["/var/opt/jfrog"]
