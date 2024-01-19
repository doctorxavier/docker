# Para descargar y configurar JFrog Artifactory - https://www.jfrog.com/confluence/display/RTF/Installing+with+Docker

# Hacer Pull de la imagen - Pulling the Artifactory Pro Docker Image
docker pull docker.bintray.io/jfrog/artifactory-pro:latest

# Correr la imagen
docker run --name artifactory -d -p 8081:8081 docker.bintray.io/jfrog/artifactory-pro:latest

# La imagen de Docker se puede correr para gestionar la pesistencia en directorios del hot o en Docker Named Volume, en este caso crearemos un volumen
docker volume create --name artifactory5_data

# Correr la imagen
docker run --name artifactory-pro -d -v artifactory5_data:/var/opt/jfrog/artifactory -p 8081:8081 docker.bintray.io/jfrog/artifactory-pro:latest

# Ingresar a la imagen
docker exec -it  artifactory-pro /bin/bash

