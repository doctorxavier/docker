sudo docker run -d --network=host --restart=always --name registry registry:latest
sudo docker run --entrypoint htpasswd registry:latest -Bbn testuser testpassword > auth/htpasswd

sudo docker stop registry && sudo docker rm -v registry

sudo docker run -d --network=host --restart=always --name registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -v `pwd`/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:latest
  
sudo docker run -d --network=host --restart=always --name registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  registry:latest

firewall-cmd --permanent --zone=public --add-port=5000/tcp
firewall-cmd --reload

curl -X GET http://<user>:<password>@localhost:5000/v2/_catalog
