from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("TaxiToIceberg") \
    .getOrCreate()

df = spark.read.format("bigquery") \
    .option("table", "project-3019d9bd-acee-4029-ab1.nyc_taxi_raw.trips_2018") \
    .load()

df.write.format("iceberg") \
    .mode("overwrite") \
    .save("gs://project-3019d9bd-acee-4029-ab1-lakehouse/trips_iceberg")

print("Done writing Iceberg table")
