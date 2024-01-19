sudo docker build --no-cache=true -t jenkins-dev:centos .
sudo docker run -dti -v /var/run/docker.sock:/var/run/docker.sock --network=host --name jenkins-dev jenkins-dev:centos
sudo docker exec -it jenkins-dev /bin/bash

sudo /etc/sysconfig/jenkins
JENKINS_ARGS="--prefix=/jenkins"

firewall-cmd --get-active-zones
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --list-ports
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
firewall-cmd --list-all