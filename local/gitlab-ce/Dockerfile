FROM centos:7

MAINTAINER everis

COPY /root /

RUN yum -q -y update && yum install -q -y wget unzip nano which cmake php-mysql curl-devel postgresql-devel policycoreutils-python \
	expat-devel gettext-devel openssl-devel zlib-devel make gcc perl-ExtUtils-MakeMaker patch libicu-devel gcc-c++ libstdc++-devel && \
	rm -f /etc/localtime && \
	ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && \
	cd /tmp && wget https://www.kernel.org/pub/software/scm/git/git-2.9.4.tar.gz && \
	tar zxvf git-2.9.4.tar.gz && cd git-2.9.4 && \
	make prefix=/usr/local/git all && make prefix=/usr/local/git install && \
	cd /tmp && rm -Rf git-2.9.4* && \
	yum -q -y install gitlab-ce && \
	mv /tmp/config /opt/gitlab/embedded/service/gitlab-rails/.bundle/ && \
	mv /tmp/gitlab.rb /etc/gitlab/ && cd /opt/gitlab/embedded/service/gitlab-rails && \
	/opt/gitlab/embedded/bin/bundle install
	
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
