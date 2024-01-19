sudo docker build --no-cache=true -t artifactory-dev:centos .
sudo docker run -dti --network=host --name artifactory-dev artifactory-dev:centos
sudo docker exec -it artifactory-dev /bin/bash

createuser --pwprompt --encrypted --no-createrole --no-createdb artifactory
createdb --owner artifactory --encoding UTF8 --lc-ctype en_US.UTF8 --lc-collate en_US.UTF8 --template template0 artifactory

postgres=# GRANT ALL PRIVILEGES ON DATABASE artifactory to artifactory

/etc/opt/jfrog/artifactory/artifactory.system.properties
artifactory.jcr.configPath=repo/mysql

firewall-cmd --get-active-zones
firewall-cmd --permanent --zone=public --add-port=8081/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --list-ports
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
firewall-cmd --list-all
