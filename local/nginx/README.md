sudo docker build --no-cache=true -t nginx-dev:1.13.1 .
sudo docker run -dti -p 80:80 -p 443:443 --name nginx-dev nginx-dev:1.13.1
sudo docker run -dti --network=host --name nginx-dev nginx-dev:1.13.1
sudo docker exec -it nginx-dev /bin/sh

nginx -t
nginx -s reload
 
curl -O http://dl-cdn.alpinelinux.org/alpine/v3.4/main/x86_64/APKINDEX.tar.gz