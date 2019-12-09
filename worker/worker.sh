#!/bin/bash

. "/usr/local/spark/sbin/spark-config.sh"

. "/usr/local/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG

export SPARK_HOME=/usr/local/spark

/usr/local/spark/sbin/start-shuffle-service.sh

/usr/local/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER
