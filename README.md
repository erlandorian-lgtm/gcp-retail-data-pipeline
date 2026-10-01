# Google Cloud Platform — Retail Data Pipeline

An end-to-end retail data engineering pipeline built on Google Cloud Platform. The project covers data ingestion, change data capture, API-based data collection, transformation, analytics, and a lakehouse layer using Apache Iceberg.

## Pipeline Phases

### Phase 1 — Data Extraction & Cloud Storage

Extract the initial data sources and configure Google Cloud Storage buckets for raw data storage.

The loaded data is then validated to ensure that the files and records have been successfully ingested and are available for downstream processing.

### Phase 2 — Change Data Capture with Datastream

Google Cloud Datastream is used to capture changes from the source database and replicate them into BigQuery.

This allows the pipeline to continuously propagate new and updated source data rather than relying solely on a one-time batch ingestion.

### Phase 3 — API Data Ingestion with Cloud Run Functions

Cloud Run Functions are used to retrieve data from external APIs on a scheduled basis.

For example, exchange-rate data can be collected periodically and made available for downstream analysis alongside the retail data.

### Phase 4 — Data Transformation & Analytics with Dataform

Dataform is used to transform the ingested data into analytics-ready datasets.

This phase contains the SQL transformations and analytical models required to prepare the data for downstream reporting and heavy analytical workloads.

### Phase 5 — Lakehouse & Apache Iceberg

The final phase was designed to introduce a lakehouse architecture using Apache Iceberg, with the underlying table data stored in Google Cloud Storage and managed through BigLake.

Due to resource/quota limitations on the Google Cloud trial/free account, the complete Iceberg lakehouse implementation could not be executed and validated end-to-end.

The project setup and architecture were explored, including:

* Google Cloud Storage lakehouse bucket
* BigLake Iceberg catalog
* Iceberg table storage location
* Lakehouse architecture and integration with the existing pipeline

The implementation is therefore documented as a **planned/partially implemented phase**, rather than a fully completed production workflow.

## Architecture

```text
                 Retail Data Sources
                        │
              ┌─────────┴─────────┐
              │                   │
         Source Database       External APIs
              │                   │
              ▼                   ▼
         Datastream        Cloud Run Functions
              │                   │
              └─────────┬─────────┘
                        ▼
                     BigQuery
                        │
                        ▼
                    Dataform
                        │
                        ▼
               Analytics Layer
                        │
                        ▼
              BigLake / Iceberg
                        │
                        ▼
               Google Cloud Storage
```

## Technologies

* Google Cloud Platform
* Google Cloud Storage
* BigQuery
* Datastream
* Cloud Run Functions
* Dataform
* BigLake
* Apache Iceberg
* SQL
* Python
