# Spark docker
Docker images to:
* Setup a standalone [Apache Spark](https://spark.apache.org/) cluster running one Spark Master and multiple Spark workers
* Build Spark applications in Java, Scala or Python to run on a Spark cluster

Currently version:
* Spark 2.4.3 for Hadoop 2.7.0 with OpenJDK 8
* Spark Driver should be installed with python 3.7 as the spark executor uses python 3.7

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

import pyspark
from pyspark import SparkContext
from pyspark.sql import SQLContext, Row

conf = pyspark.SparkConf()
conf.set("spark.driver.memory", "11g")
conf.setMaster("spark://<MASTER_IP>:7077")

from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("task usage") \
    .config(conf=conf) \
    .getOrCreate()
    
sc = spark.sparkContext
#creates sql context
sqlContext = SQLContext(sc)

x = ['spark', 'rdd', 'example', 'sample', 'example'] 
y = sc.parallelize(x)
y.collect()
```
