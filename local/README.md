sudo yum update
sudo yum install -y nano net-tools telnet yum-utils device-mapper-persistent-data lvm2 wget curl
sudo rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
sudo localectl set-keymap es
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install -y docker-ce
sudo nano /etc/docker/daemon.json 
{
  "storage-driver": "devicemapper"
}
sudo systemctl start docker
sudo systemctl enable docker


--------------------------------------------------------------------------------------------------
git

git clone http://66.70.207.142:8083/bcp/bcp-arch

sudo docker volume rm $(sudo docker volume ls -qf dangling=true)

ssh
/usr/sbin/sshd-keygen
/usr/lib/systemd/system
/usr/sbin/sshd
/bin/kill -HUP $MAINPID

ssh-keygen -t dsa -b 1024
cat id_dsa.pub >> authorized_keys
chmod 600 authorized_keys


firewall-cmd --permanent --zone=public --add-port=9042/tcp
firewall-cmd --permanent --zone=public --add-port=9160/tcp
firewall-cmd --permanent --zone=public --add-port=9000-9999/tcp
firewall-cmd --permanent --zone=public --add-port=7000-7999/tcp

sudo firewall-cmd --permanent --zone=public --remove-port=7000/tcp
firewall-cmd --list-ports
sudo firewall-cmd --reload
firewall-cmd --zone=public --list-ports
firewall-cmd --list-all

mysqladmin -u root -p -h localhost flush-hosts

nmap -sT -O localhost
