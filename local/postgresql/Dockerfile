FROM centos:7

MAINTAINER everis

ENV TERM xterm \
	container docker

COPY /root /

RUN yum -q -y update && yum install -q -y wget nano dbus && \
		rm -f /etc/localtime && \
		ln -s /usr/share/zoneinfo/America/Lima /etc/localtime && \
		sed -i -e "s/OOMScoreAdjust/# OOMScoreAdjust/" /usr/lib/systemd/system/dbus.service && \
		sed -ir "s/#SystemMaxUse=.*/SystemMaxUse=50M/" /etc/systemd/journald.conf && \
		rpm -iUvh https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm && \
		yum -q -y update && yum -q -y install postgresql96 postgresql96-server postgresql96-contrib

VOLUME ["/var/lib/pgsql", "/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]

STOPSIGNAL "RTMIN+3"
