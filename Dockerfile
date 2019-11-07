FROM openjdk:8-alpine

LABEL maintainer="karmaterminal<karmafeast@gmail.com>"

RUN apk add --no-cache --virtual .build-deps
RUN apk --update add wget tar bash
RUN apk add make && apk add curl && apk add openssh
RUN apk add git

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Install aws-cli
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

# install spark
RUN wget http://apache.mirror.anlx.net/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.4.4-bin-hadoop2.7.tgz && \
    mv spark-2.4.4-bin-hadoop2.7 /spark && \
    rm spark-2.4.4-bin-hadoop2.7.tgz
COPY start-master.sh /start-master.sh
COPY start-worker.sh /start-worker.sh
