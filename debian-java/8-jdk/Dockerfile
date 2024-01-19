FROM debian:jessie

MAINTAINER everis

ENV http_proxy=http://10.80.193.115:8080 \
    https_proxy=https://10.80.193.115:8080 \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
	PATH=${PATH}:/usr/lib/jvm/java-8-oracle/bin \
	JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=102 \
    JAVA_VERSION_BUILD=14 \
    JAVA_PACKAGE=jdk \
    JVM_OPTS="" \
	LANG=C.UTF-8

COPY /root /

RUN apt-get update -q && apt-get install -q -y --no-install-recommends wget unzip ca-certificates \
		&& echo "America/Lima"  > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
        && mkdir -p /usr/lib/jvm \
        && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
        && tar --no-overwrite-dir --skip-old-files -zxvf ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz -C /usr/lib/jvm \
        && ln -s /usr/lib/jvm/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} \
        && update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-8-oracle/bin/java" 1 \
        && update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/java-8-oracle/bin/javac" 1 \
        && update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/java-8-oracle/bin/javaws" 1 \
        && update-alternatives --set java ${JAVA_HOME}/bin/java \
        && update-alternatives --set javac ${JAVA_HOME}/bin/javac \
        && update-alternatives --set javaws ${JAVA_HOME}/bin/javaws \
		&& mv -f /java.security ${JAVA_HOME}/jre/lib/security/ \
        && keytool -import -no-prompt -alias BCPEnterprise -file /usr/local/share/ca-certificates/BCP_Enterprise_Certification_Authority.crt -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit \
        && keytool -import -no-prompt -alias Credicorp -file /usr/local/share/ca-certificates/Credicorp_Root_Certification_Authority.crt -keystore ${JAVA_HOME}/jre/lib/security/cacerts -storepass changeit \
        && update-ca-certificates \
        && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip \
        && unzip -j -o -d ${JAVA_HOME}/jre/lib/security/ jce_policy-${JAVA_VERSION_MAJOR}.zip \
        && wget --no-check-certificate https://www.bouncycastle.org/download/bcprov-ext-jdk15on-154.jar -P ${JAVA_HOME}/jre/lib/ext/ \
        && rm -rf ${JAVA_HOME}/*src.zip \
                ${JAVA_HOME}/lib/missioncontrol \
                ${JAVA_HOME}/lib/visualvm \
                ${JAVA_HOME}/lib/*javafx* \
                ${JAVA_HOME}/jre/plugin \
                ${JAVA_HOME}/jre/bin/javaws \
                ${JAVA_HOME}/jre/bin/jjs \
                ${JAVA_HOME}/jre/bin/orbd \
                ${JAVA_HOME}/jre/bin/pack200 \
                ${JAVA_HOME}/jre/bin/policytool \
                ${JAVA_HOME}/jre/bin/rmid \
                ${JAVA_HOME}/jre/bin/rmiregistry \
                ${JAVA_HOME}/jre/bin/servertool \
                ${JAVA_HOME}/jre/bin/tnameserv \
                ${JAVA_HOME}/jre/bin/unpack200 \
                ${JAVA_HOME}/jre/lib/javaws.jar \
                ${JAVA_HOME}/jre/lib/deploy* \
                ${JAVA_HOME}/jre/lib/desktop \
                ${JAVA_HOME}/jre/lib/*javafx* \
                ${JAVA_HOME}/jre/lib/*jfx* \
                ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
                ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
                ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
                ${JAVA_HOME}/jre/lib/amd64/libglass.so \
                ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
                ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
                ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
                ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
                ${JAVA_HOME}/jre/lib/ext/nashorn.jar \
                ${JAVA_HOME}/jre/lib/oblique-fonts \
				${JAVA_HOME}/jre/lib/plugin.jar \
                ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz jce_policy-${JAVA_VERSION_MAJOR}.zip \
        && apt-get remove --purge -y wget ca-certificates unzip \
        && apt-get autoremove --purge -y \
        && apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /var/cache/apk/* /tmp/* /var/tmp/*
