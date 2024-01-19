![everis](http://www.everis.com/peru/Style%20Library/Images/General/logo_everis.png "www.everis.com/peru")

# Docker Ubuntu: Uso Básico de Contenedores para ambiente de prueba

- Autor : Jesus Sanchez
- Fecha : 13-03-2017
- Ultima modificación : 17-03-2017
- Autor de modificación : Franco Cano Erazo

Pasos a seguir para desplegar el ambiente:

  - Iniciar la máquina virtual que tiene por nombre **Docker-Ubuntu** dentro de **Virtualbox**.
  - Para la autenticación dentro de la máquina virtual  via ssh ,debe usar los siguientes datos de conexion : **Usuario:** root **Password:** casa1234 
  - Todas las imagenes base ya han sido previamente construidas y descargadas en el Docker Registry Local.

# Verificación de imágenes disponibles 

  - Para visualizar las imágenes disponibles ejecutamos el comando: 
  ```docker images```
  
# Verificación de contenedores 
  - Para visualizar los contenedores que se estan ejecutando:

  ```shell
  docker ps
  ```

  - En caso de fallo se puede verificar que contenedores  estan ejecutandose y cuales no. Para verificar el estados de todos los contenedores ejecutamos:
  
  ```shell
  docker ps -a
  ```

# Ejecución de contenedores :

> Es importante destacar que la ejecución de los contenedores estan relacionadas entre si por
> el orden que se disponen estos,  esto se debe a que están entrelazados 
> mediante el parámetro ```--link``` que les garantiza directa comununicación. Todos aquellos contenedores que no esten entrelazados no podran establecer comunicación.

# Cassandra

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name cassandra --network=repo_default -v /Docker/Volumes/Cassandra:/var/lib/cassandra -v /Docker/Volumes/Cassandra/Logs:/var/log/cassandra -d -p9042:9042 luketillman/datastax-enterprise:5.0.6
```

Puertos expose:
- 9042

# Zookeeper

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name zookeeper  --network=repo_default -p 2181:2181 -p 2888:2888 -p 3888:3888 --network=repo_default -d apache-zookeeper/ver:3.4.9
```

Puertos expose:
- 2181
- 2888
- 3888

# Kafka

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name kafka --network=repo_default -p 9092:9092 --link zookeeper:zookeeper -e KAFKA_ADVERTISED_HOST_NAME=192.168.99.100 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_CREATE_TOPICS="vplusTopic:1:1" -e KAFKA_HEAP_OPTS="-Xmx256M -Xms128M" -v /var/run/docker.sock:/var/run/docker.sock -d apache-kafka/ver:0.10.0.2
```
Puertos expose:
- 9092

> Nota: 
```
KAFKA_CREATE_TOPICS=”<nombre-topic>:<numero-particiones><numero-replica>”
```
# Spark-master

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name spark-master --network=repo_default --link cassandra:cassandra --link kafka:kafka -p 8080:8080 -p 7077:7077 -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.0.0-hadoop2.7-hive-java8
```

Puertos expose:
- 8080 # Web Access
- 7077 #Jobs

# Spark-slave

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name spark-worker-1 --network=repo_default --link spark-master:spark-master --link cassandra:cassandra --link kafka:kafka -p 4040:4040 -e ENABLE_INIT_DAEMON=false -d bde2020/spark-master:2.0.0-hadoop2.7-hive-java8
```


Puertos expose:
- 8081 # Web Access
- 7077 #Jobs

# Lanzar cluster para hdfs 
Para levantar el cluster de HDFS  ejecutamos los siguientes comandos:

```shell
cd /REPO/docker-hadoop
docker-compose up -d
```

Puertos expose:
datanode1:
- 50075

historyserver:
- 8188

resourcemanager:
- 8088

namenode
- 50070
- 8020

Luego de levantar el cluster de hdfs debe ingresar al contenedor y crear las siguientes carpetas:

```shell
hdfs dfs -mkdir /VP
hdfs dfs -mkdir /VP/historical
```

# Flume

Para levantar este contenedor ejecutamos el siguiente comando:

```shell
docker run --name flume-mq-servidor --link kafka:kafka --link namenode:namenode --network=repo_default -p 44444:44444 -e FLUME_CONF_DIR=/opt/flume/conf -e FLUME_AGENT_NAME=plotAgent -e FLUME_CONF_FILE=/opt/flume/conf/plot.conf -d apache-flume/ver:1.7
```

Puertos expose:
- 44444 # Solo cuando se use un source externo
> Nota: Si se requiere cambiar el config de flume , se debe reconstruir la imagen base,
> para ello debe ejecutarse dentro del directorio /REPO los siguientes comandos:

```shell
cd /REPO
docker build -t apache-flume/ver:1.7  -f docker_flume/Dockerfile.dockerfile .
```

# Lanzar todo el ambiente
Para levantar todo el ambiente que compone la prueba de concepto para el proyecto  ejecutamos los siguientes comandos:

```shell
cd /REPO
docker-compose up -d
```





