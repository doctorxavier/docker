#Construir imagenes base
#ubuntu java 8 base
docker build -t ubuntu-xenial/java-ver:1.8  -f \Ubuntu\\xenial\\Java8\\Dockerfile.dockerfile .
#Alpine Java 8 base
docker build -t oracle-jdk/ver:8  -f \Alpine\\oracle-jdk-8\\Dockerfile.dockerfile .
#Zookeper
docker build -t apache-zookeeper/ver:3.4.9 -f \docker-zk\\Dockerfile.dockerfile .
#Cassandra
docker pull luketillman/datastax-enterprise:5.0.6
#spark hadoop
docker pull bde2020/spark-master:2.0.0-hadoop2.7-hive-java8
#kafka
docker build -t apache-kafka/ver:0.10.0.2 -f \docker-kafka-0.10\\Dockerfile .
#Flume
docker build -t apache-flume/ver:1.7  -f \docker_flume\\Dockerfile.dockerfile .
#Pull imagenes containers 
#Hdps/spark 
docker pull bde2020/hadoop-namenode:1.1.0-hadoop2.7.1-java8



#Recrear el ambiente de pruebas
#Levantar contenedor de cassadra
docker run --name cassandra -v /Docker/Volumes/Cassandra:/var/lib/cassandra -v /Docker/Volumes/Cassandra/Logs:/var/log/cassandra -d -p9042:9042 luketillman/datastax-enterprise:5.0.6

#Levantar contenedor de zookeeper
docker run --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888 -d apache-zookeeper/ver:3.4.9

#Levantar contenedor de kafka 
docker run --name kafka -p 9092:9092 --link zookeeper:zookeeper --link cassandra:cassandra -e KAFKA_ADVERTISED_HOST_NAME=192.168.99.100 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_CREATE_TOPICS="vplusTopic:1:1:compact" -e KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" -v /var/run/docker.sock:/var/run/docker.sock -d apache-kafka/ver:0.10.0.2

#spark master
docker run --name spark-master --link cassadra:cassadra --link kafka:kafka -p 8080:8080 -p 7077:7077 -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.0.0-hadoop2.7-hive-java8
#spark slave
docker run --name spark-worker-1 --link spark-master:spark-master --link cassadra:cassadra --link kafka:kafka -p 4040:4040 -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.0.0-hadoop2.7-hive-java8
# Flume 
docker run --name flume --link kafka:kafka -p 44444:44444 -e FLUME_CONF_DIR=/opt/flume/conf -e FLUME_AGENT_NAME=plotAgent -e FLUME_CONF_FILE=/opt/flume/conf/plot.conf -d apache-flume/ver:1.7


#Para Levantar el ambiente completo de desarrollo dentro de la carpeta Docker Ambiente de prueba existe un archivo docker-compose.yaml
#usando el comando docker-compose levantamos el ambiente
docker-compose up -d

#Pasados unos segundos verificamos nuestro ambiente de pruebas
docker ps

#Comando para crear directorios
mkdir -p /Docker/Volumes/Cassandra
mkdir -p /Docker/Volumes/Cassandra/Logs

