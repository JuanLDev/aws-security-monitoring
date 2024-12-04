import json
import boto3

def lambda_handler(event, context):
    records = event['Records']
    for record in records:
        payload = json.loads(record['kinesis']['data'])
        print(f"Processed record: {json.dumps(payload, indent=2)}")
    return {"statusCode": 200}
