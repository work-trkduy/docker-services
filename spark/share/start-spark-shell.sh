export HADOOP_USER_NAME=hadoop

export AWS_ACCESS_KEY_ID="yYLlvNZLztLDEg0undwj"
export AWS_SECRET_ACCESS_KEY="K86aIE3bTxzK1vh4wBBHtP34sTjkKGyluGhGfoZu"
export AWS_REGION="us-west-2"
s3a_endpoint="http://192.168.1.9:9001"
warehouse="s3a://bucket1/warehouse"
hive_uri="thrift://192.168.1.9:9083"
# warehouse="/hive/warehouse"

hive_uri="thrift://192.168.1.9:9083"

spark-shell --master yarn \
    --deploy-mode client \
    --packages org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.4.2,org.apache.iceberg:iceberg-hive-runtime:1.4.2,org.apache.iceberg:iceberg-aws-bundle:1.4.2,org.apache.hadoop:hadoop-aws:3.3.4,com.amazonaws:aws-java-sdk-bundle:1.12.626 \
    --repositories https://packages.confluent.io/maven \
    --conf spark.yarn.queue=root.default \
    --conf spark.yarn.appMasterEnv.AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --conf spark.yarn.appMasterEnv.AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --conf spark.yarn.appMasterEnv.AWS_REGION=$AWS_REGION \
    --conf spark.executorEnv.AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --conf spark.executorEnv.AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --conf spark.executorEnv.AWS_REGION=$AWS_REGION \
    --conf spark.hadoop.hive.metastore.uris=$hive_uri \
    --conf spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions \
    --conf spark.sql.catalog.iceberg=org.apache.iceberg.spark.SparkCatalog \
    --conf spark.sql.catalog.iceberg.s3.endpoint=$s3a_endpoint \
    --conf spark.sql.catalog.iceberg.type=hive \
    --conf spark.sql.catalog.iceberg.uri=$hive_uri \
    --conf spark.sql.catalog.iceberg.warehouse=$warehouse \
    --conf spark.sql.catalog.iceberg.io-impl=org.apache.iceberg.aws.s3.S3FileIO \
    --conf spark.sql.defaultCatalog=iceberg \
    --conf spark.sql.warehouse.dir=$warehouse \
    --conf spark.dynamicAllocation.enabled=true \
    --conf spark.driver.cores=1 \
    --conf spark.driver.memory=1g \
    --conf spark.driver.maxResultSize=0 \
    --conf spark.executor.instances=2 \
    --conf spark.executor.cores=1 \
    --conf spark.executor.memory=1g \
    --conf spark.dynamicAllocation.minExecutors=2 \
    --conf spark.dynamicAllocation.maxExecutors=4 \
    --conf spark.yarn.historyServer.allowTracking=true \
    --conf spark.yarn.historyServer.address=192.168.1.9:18080 \
    --conf spark.hadoop.fs.s3a.endpoint=$s3a_endpoint \
    --conf spark.hadoop.fs.s3a.access.key=$AWS_ACCESS_KEY_ID \
    --conf spark.hadoop.fs.s3a.secret.key=$AWS_SECRET_ACCESS_KEY \
    --conf spark.hadoop.fs.s3a.path.style.access=true \
    --conf spark.hadoop.fs.s3a.ssl.enabled=false \
    --conf spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem \
    --conf spark.hadoop.fs.s3a.aws.credentials.provider=org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider