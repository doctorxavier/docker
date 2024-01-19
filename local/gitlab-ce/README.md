sudo docker build --no-cache=true -t gitlab-ce-dev:centos .
sudo docker run -dti --network=host --name gitlab-ce-dev gitlab-ce-dev:centos
sudo docker exec -it gitlab-ce-dev /bin/bash

createuser --pwprompt --encrypted --no-createrole --no-createdb git
createdb --owner git --encoding UTF8 --lc-ctype en_US.UTF8 --lc-collate en_US.UTF8 --template template0 gitlabhq_production

postgres=# GRANT ALL PRIVILEGES ON DATABASE gitlabhq_production to git
postgres=# ALTER ROLE git CREATEROLE SUPERUSER;

**** /opt/gitlab/embedded/bin/runsvdir-start
cd /opt/gitlab/embedded/service/gitlab-rails
/opt/gitlab/embedded/bin/./bundle install
gitlab-ctl reconfigure
gitlab-rake gitlab:setup

gitlab-ctl restart
gitlab-ctl status

#chown git:git /var/opt/gitlab

firewall-cmd --get-active-zones
firewall-cmd --permanent --zone=public --add-port=8083/tcp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --list-ports
firewall-cmd --reload
firewall-cmd --zone=public --list-ports
firewall-cmd --list-all
