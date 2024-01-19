FROM centos:7

MAINTAINER everis

ENV JAVA_HOME=/usr/java/java-8-oracle \
    PATH=${PATH}:/usr/java/java-8-oracle/bin \
	JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=131 \
    JAVA_VERSION_BUILD=11 \
    JAVA_PACKAGE=server-jre \
    JVM_OPTS="" \
	LANG=en_US.utf8
	
COPY /root /tmp

RUN yum -q -y update && install -q -y wget unzip && \
		rm -f /etc/localtime && \
		ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && \
		mkdir -p /usr/java && \
		wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/d54c1d3a095b4ff2b6607d096fa80163/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
		tar --no-overwrite-dir --skip-old-files -zxvf ${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz -C /usr/java && \
		ln -s /usr/java/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} ${JAVA_HOME} && \
        update-alternatives --install "/usr/bin/java" "java" "/usr/java/java-${JAVA_VERSION_MAJOR}-oracle/bin/java" 1 && \
        update-alternatives --install "/usr/bin/javac" "javac" "/usr/java/java-${JAVA_VERSION_MAJOR}-oracle/bin/javac" 1 && \
		wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip && \
		unzip -j -o -d ${JAVA_HOME}/jre/lib/security/ jce_policy-${JAVA_VERSION_MAJOR}.zip && \
		wget --no-check-certificate https://www.bouncycastle.org/download/bcprov-ext-jdk15on-157.jar -P ${JAVA_HOME}/jre/lib/ext/ && \
		mv -f /tmp/java.security ${JAVA_HOME}/jre/lib/security/ && \
		find /usr/java/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} -maxdepth 1 -mindepth 1 | grep -v jre | xargs rm -rf && \
		cd ${JAVA_HOME} && ln -s ./jre/bin ./bin && cd / && \
		mv /tmp/certs/ /etc/pki/ca-trust/source/anchors/ && \
		update-ca-trust enable && \
		update-ca-trust extract && \
		rm -rf ${JAVA_HOME}/*src.zip \
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
			/tmp/* \
			${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz jce_policy-${JAVA_VERSION_MAJOR}.zip && \
		yum remove -y wget unzip && \
		yum clean all
