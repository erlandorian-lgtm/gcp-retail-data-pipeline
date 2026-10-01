-- Phase 2: Schema setup for Datastream CDC (run inside psql connected to retail-db)

CREATE SCHEMA IF NOT EXISTS retail;

CREATE TABLE retail.customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date TIMESTAMP
);

CREATE TABLE retail.products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

CREATE TABLE retail.orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES retail.customers(customer_id),
    product_id INT REFERENCES retail.products(product_id),
    quantity INT,
    order_date TIMESTAMP,
    total_amount NUMERIC(10,2)
);

-- Enable logical replication (run via gcloud, not inside psql):
-- gcloud sql instances patch retail-db --database-flags=cloudsql.logical_decoding=on

CREATE PUBLICATION retail_publication FOR TABLES IN SCHEMA retail;
ALTER USER postgres WITH REPLICATION;
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT('retail_replication_slot', 'pgoutput');
