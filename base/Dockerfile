FROM ubuntu:16.04

LABEL maintainer="karmaterminal<karmafeast@gmail.com>"

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /
COPY requirements.txt /

#COPY bde-spark.css /css/org/apache/spark/ui/static/timeline-view.css
USER root

RUN echo "user      soft      nofile      500000" >> /etc/security/limits.conf && \
    echo "user      hard      nofile      500000" >> /etc/security/limits.conf && \
    echo "root      soft      nofile      500000" >> /etc/security/limits.conf && \
    echo "root      hard      nofile      500000" >> /etc/security/limits.conf && \
    echo "session required                        pam_limits.so" >> /etc/pam.d/common-session

# Spark dependencies
ENV APACHE_SPARK_VERSION 2.4.4
ENV HADOOP_VERSION 2.7

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java wget && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install -y curl unzip \
    build-essential libpq-dev libssl-dev openssl libffi-dev zlib1g-dev ssh rsync

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa -y

RUN apt-get update \
 && apt-get install -y python3-pip python3.7-dev python3.7 \
 && ln -s /usr/bin/python3.7 /usr/bin/python \
 && easy_install3 pip py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*




ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

RUN cd /tmp && \
    wget -q http://mirrors.ukfast.co.uk/sites/ftp.apache.org/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    echo "2E3A5C853B9F28C7D4525C0ADCB0D971B73AD47D5CCE138C85335B9F53A6519540D3923CB0B5CEE41E386E49AE8A409A51AB7194BA11A254E037A848D0C4A9E5 *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local --owner root --group root --no-same-owner && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

#
# Spark and Mesos config
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip
ENV MESOS_NATIVE_LIBRARY /usr/local/lib/libmesos.so
ENV SPARK_OPTS --driver-java-options=-Xms4G --driver-java-options=-Xmx128G --driver-java-options=-Dlog4j.logLevel=info

RUN pip3 install -r /requirements.txt -t /usr/lib/python3/dist-packages --upgrade

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh


