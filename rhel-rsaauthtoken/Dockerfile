FROM rhel/8-jre:7.2

MAINTAINER everis

ARG APP_CERT_ALIAS
ARG APP_CERT_NAME

ENV VAR_ACE=/var/ace

COPY /root /

EXPOSE 8080

RUN mv /tmp/${APP_CERT_NAME} /etc/pki/ca-trust/source/anchors/ && \
        keytool -import -no-prompt -alias ${APP_CERT_ALIAS} -file /etc/pki/ca-trust/source/anchors/${APP_CERT_NAME} -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit && \
        update-ca-trust enable && \
        update-ca-trust extract

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-Dfile.encoding=UTF-8", "-Xms384m", "-Xmx384m", "-XX:NewSize=256m", \
        "-XX:MaxNewSize=384m", "-XX:MaxMetaspaceSize=256m", "-XX:+UseG1GC", "-XX:+DisableExplicitGC", \
        "-Xcheck:jni", "-Xrs", "-Djava.library.path=/opt/authtoken", "-cp", "/opt/tokenRSA/lib/bcpauthtoken.jar", \
        "-jar", "-Dserver.port=8080", "/opt/java/bcp-mbrk-token-rsa.jar"]
