#!/bin/bash

set -e

source ./.env

docker pull karmaterminal/spark-base:${SPARK_VERSION}
docker pull karmaterminal/spark-master:${SPARK_VERSION}
docker pull karmaterminal/spark-worker:${SPARK_VERSION}
docker pull karmaterminal/zeppelin:latest

