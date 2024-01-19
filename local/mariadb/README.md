sudo docker build --no-cache=true -t mariadb-dev:centos .
sudo docker run -dti --network=host --name mariadb-dev mariadb-dev:centos
sudo docker exec -it mariadb-dev /bin/bash


docker run --cap-add=SYS_ADMIN -ti -e "container=docker" -v /sys/fs/cgroup:/sys/fs/cgroup --name mariadb-dev mariadb-dev:centos /usr/sbin/init