sudo docker build --no-cache=true -t postgresql-dev:centos .
sudo docker run -dti --network=host --name postgresql-dev postgresql-dev:centos
sudo docker exec -it postgresql-dev /bin/bash

sudo docker run -dti --network=host --cap-add=SYS_ADMIN --tmpfs /tmp --tmpfs /run --name postgresql-dev postgresql-dev:centos
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6.service
systemctl start postgresql-9.6

firewall-cmd --permanent --zone=public --add-port=5432/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --list-ports
firewall-cmd --reload
