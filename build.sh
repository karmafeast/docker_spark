#!/bin/bash

set -e

source ./.env


build_base() {
    NAME=$1
    IMAGE=karmaterminal/spark-$NAME:${SPARK_VERSION}
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build --no-cache --squash -t $IMAGE . --build-arg SPARK_VERSION=${SPARK_VERSION}
    cd -
}

build() {
    NAME=$1
    IMAGE=karmaterminal/spark-$NAME:${SPARK_VERSION}
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build --no-cache --squash -t $IMAGE . --build-arg FROM_IMAGE=karmaterminal/spark-base:${SPARK_VERSION}
    cd -
}

build_base base
build master
build worker

#docker push karmaterminal/spark-base:${SPARK_VERSION}
#docker push karmaterminal/spark-master:${SPARK_VERSION}
#docker push karmaterminal/spark-worker:${SPARK_VERSION}

