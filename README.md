# Spark docker
Docker images to:
* Setup a standalone [Apache Spark](https://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently version:
* Spark 2.4.3 for Hadoop 2.7.0 with OpenJDK 8

## Using Docker Compose
```sh
$ sudo bash build.sh
$ sudo docker-compose up &
```

## Launch a Spark Notebook
```
$ sudo docker run -it --rm --net host jupyter/pyspark-notebook
```
Then test in jupyter notebook :
```py
from pyspark import SparkConf, SparkContext
conf = SparkConf().setAppName('hello').setMaster('spark://<MASTER_NODE_PUBLIC_IP>:7077').setSparkHome('/opt/spark/') 
sc = SparkContext(conf=conf)
x = ['spark', 'rdd', 'example', 'sample', 'example'] 
y = sc.parallelize(x)
y.collect()
```
