#!/bin/bash

set -e

source ./.env


build_base() {
    NAME=$1
    IMAGE=ansjin/spark-$NAME:${SPARK_VERSION}
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE . --build-arg SPARK_VERSION=${SPARK_VERSION}
    cd -
}

build() {
    NAME=$1
    IMAGE=ansjin/spark-$NAME:${SPARK_VERSION}
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE . --build-arg FROM_IMAGE=ansjin/spark-base:${SPARK_VERSION}
    cd -
}

build_base base
build master
build worker

