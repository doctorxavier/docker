**********************************************************************************************************************
**********************************************************************************************************************
**********************************************************************************************************************
sudo docker build --no-cache=true -t rsaauthtoken:1.1.1 .
sudo docker tag rsaauthtoken:1.1.1 localhost:5000/rhel/rsaauthtoken:1.1.1
sudo docker push localhost:5000/rhel/rsaauthtoken:1.1.1

sudo docker run -d --name rsaauthtoken -p 9280:8080 rhel/rsaauthtoken:1.1.1
**********************************************************************************************************************
http://10.80.133.17:9180/tokenrsa (dev01)
http://10.80.197.73:9180/tokenrsa (dev02)

http://10.80.134.170:9180/tokenrsa (cert01)
http://10.80.198.212:9180/tokenrsa (cert02)
POST
{
	"cic": "10257501",
	"tokenNumber": "222222"
}

http://10.80.129.59:9180/tokenrsa (pro01)
http://10.80.193.234:9180/tokenrsa (pro02)
POST
{
	"cic": "12100975",
	"tokenNumber": "222222"
}
**********************************************************************************************************************
RESPONSE
{"statusCod": "MB0000"}
**********************************************************************************************************************
**********************************************************************************************************************
