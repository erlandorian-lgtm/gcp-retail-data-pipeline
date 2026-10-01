#!/bin/bash
# Phase 1: Batch extract/load — NYC Taxi data from Cloud Storage into BigQuery

export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-central1

gcloud storage buckets create gs://$PROJECT_ID-raw --location=$REGION

gcloud storage cp gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_2.csv gs://$PROJECT_ID-raw/

bq mk --location=$REGION nyc_taxi_raw

bq load \
  --source_format=CSV \
  --autodetect \
  --skip_leading_rows=1 \
  nyc_taxi_raw.trips_2018 \
  gs://$PROJECT_ID-raw/nyc_tlc_yellow_trips_2018_subset_2.csv
