import functions_framework
import requests
from google.cloud import bigquery
from datetime import datetime, timezone

@functions_framework.http
def fetch_exchange_rate(request):
    response = requests.get('https://api.exchangerate-api.com/v4/latest/USD')
    data = response.json()

    client = bigquery.Client()
    table_id = "project-3019d9bd-acee-4029-ab1.retail_raw.exchange_rates"

    row = {
        "fetch_timestamp": datetime.now(timezone.utc).isoformat(),
        "base_currency": "USD",
        "target_currency": "IDR",
        "rate": data["rates"]["IDR"]
    }

    errors = client.insert_rows_json(table_id, [row])
    if errors:
    	return f"Errors: {errors}", 500
    return "Success", 200
