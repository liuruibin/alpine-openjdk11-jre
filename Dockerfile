FROM alpine:3.16.2

USER root

COPY run-java.sh /tmp/

RUN apk add --update --no-cache tzdata curl fontconfig ttf-dejavu openjdk11-jre nss \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone \
 && echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/default-jvm/jre/lib/security/java.security \
 && curl -L https://fit2cloud-support.oss-cn-beijing.aliyuncs.com/xpack-license/get-validator-linux | sh \
 && mkdir -p /deployments && mv /tmp/run-java.sh /deployments && chmod 755 /deployments/run-java.sh \
 && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ENV JAVA_APP_DIR=/deployments \
    JAVA_MAJOR_VERSION=11 \
    JAVA_OPTIONS="-Dfile.encoding=utf-8" \
    LOG4J_FORMAT_MSG_NO_LOOKUPS=true

CMD [ "/deployments/run-java.sh" ]
