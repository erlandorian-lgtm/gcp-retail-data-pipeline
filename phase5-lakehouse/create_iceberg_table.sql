-- Phase 5: Lakehouse (Iceberg) table creation via BigQuery native support
-- Note: originally planned via Serverless Spark (see taxi_to_iceberg.py),
-- pivoted to this approach after hitting a free-tier CPU quota limit.

CREATE TABLE `retail_lakehouse.taxi_trips_iceberg`
(
    vendor_id INTEGER,
    pickup_datetime TIMESTAMP,
    dropoff_datetime TIMESTAMP,
    passenger_count INTEGER,
    trip_distance FLOAT64,
    fare_amount FLOAT64,
    total_amount FLOAT64
)
WITH CONNECTION DEFAULT
OPTIONS (
    file_format = 'PARQUET',
    table_format = 'ICEBERG',
    storage_uri = 'gs://project-3019d9bd-acee-4029-ab1-lakehouse/taxi_trips_iceberg'
);

INSERT INTO `retail_lakehouse.taxi_trips_iceberg`
SELECT vendor_id, pickup_datetime, dropoff_datetime, passenger_count, trip_distance, fare_amount, total_amount
FROM `nyc_taxi_raw.trips_2018`;
