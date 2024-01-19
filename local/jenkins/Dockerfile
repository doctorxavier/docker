FROM centos-java:8-jdk

MAINTAINER everis

COPY /root /

RUN yum -q -y update && yum install -q -y wget nano bzip2 initscripts build-essential gcc-c++ make gettext-devel openssl-devel openssh-server sudo zlib-devel curl-devel expat-devel  unzip perl-ExtUtils-MakeMaker
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum -q -y install jenkins

usermod -s /bin/bash jenkins

http://apache.uniminuto.edu/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz

ln -s apache-maven-3.5.0 apache-maven

#/etc/profile.d/global.sh
export MVN_HOME=/opt/apache-maven
export PATH=$PATH:$MVN_HOME/bin

curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum -y install nodejs

npm install -g jshint
npm install -g bower
npm install -g grunt-cli
npm install -g protractor
npm install -g gulp

yum install -y device-mapper-persistent-data
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install -y docker-ce
sudo nano /etc/docker/daemon.json 
{
  "storage-driver": "devicemapper"
}

https://www.kernel.org/pub/software/scm/git/git-2.9.4.tar.gz
tar zxvf git-2.9.4.tar.gz
cd git-2.9.4
make prefix=/usr/local/git all
make prefix=/usr/local/git install
cd ..
rm -Rf git-2.9.4*

--------------------------------------------------------------------------------------------
IN HOST
sudo semanage port -a -t mongod_port_t -p tcp 27017

--------------------------------------------------------------------------------------------

nano /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc

yum update -y
yum install -y mongodb-org

mongod run --quiet -f /etc/mongod.conf

--------------------------------------------------------------------------------------------
/etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://www.apache.org/dist/cassandra/KEYS

yum update -y
yum install -y cassandra

nano /etc/security/limits.d/cassandra.conf
cassandra soft memlock unlimited
cassandra soft nofile 100000
cassandra soft nproc 32768
cassandra soft as unlimited

cqlsh
CREATE KEYSPACE my_keyspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE my_keyspace;
CREATE TABLE audit (id text, uuid text, dateTime timestamp, elapsed bigint, complextype text, PRIMARY KEY (id));
CREATE INDEX ON audit (uuid);
--------------------------------------------------------------------------------------------

openssl s_client -connect 66.70.207.142:443 <<<'' | openssl x509 -out server.crt
sudo cp ~/server.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust enable
sudo update-ca-trust extract
keytool -import -no-prompt -alias everis -file /etc/pki/ca-trust/source/anchors/server.crt -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit
