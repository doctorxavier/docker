sudo docker build --no-cache=true -t sonarqube-dev:centos .
sudo docker run -dti --network=host --name sonarqube-dev sonarqube-dev:centos
sudo docker exec -it sonarqube-dev /bin/bash

createuser --pwprompt --encrypted --no-createrole --no-createdb sonarqube;
createdb --owner sonarqube --encoding UTF8 --lc-ctype en_US.UTF8 --lc-collate en_US.UTF8 --template template0 sonar

firewall-cmd --get-active-zones
firewall-cmd --permanent --zone=public --add-port=8084/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --list-ports
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
firewall-cmd --list-all
