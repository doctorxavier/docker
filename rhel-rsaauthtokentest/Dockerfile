FROM rhel/8-jre:7.2

MAINTAINER everis

ARG APP_CERT_ALIAS
ARG APP_CERT_NAME

ENV VAR_ACE=/var/ace/ \
    AUTHTOKEN_CP=config:/opt/authtoken/bcpauthtoken.jar:/opt/authtoken/commons-logging-1.0.4.jar:/opt/authtoken/log4j-1.2.9.jar:/opt/authtoken/junit.jar

COPY /root /

RUN mv /tmp/${APP_CERT_NAME} /etc/pki/ca-trust/source/anchors/ && \
        keytool -import -no-prompt -alias ${APP_CERT_ALIAS} -file /etc/pki/ca-trust/source/anchors/${APP_CERT_NAME} -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit && \
        update-ca-trust enable && \
        update-ca-trust extract
