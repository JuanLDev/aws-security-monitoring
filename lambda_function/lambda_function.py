import json
import boto3
import os
import logging
from datetime import datetime

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize clients
s3 = boto3.client("s3")
cloudwatch = boto3.client("cloudwatch")

# Get environment variable
BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")

if not BUCKET_NAME:
    raise ValueError("Environment variable S3_BUCKET_NAME is not set.")

def publish_metric(severity):
    """
    Publish a custom metric to CloudWatch.
    """
    try:
        cloudwatch.put_metric_data(
            Namespace='Custom/GuardDuty',
            MetricData=[
                {
                    'MetricName': 'HighSeverityFindings',
                    'Dimensions': [
                        {'Name': 'Severity', 'Value': 'High'}
                    ],
                    'Value': severity,
                    'Unit': 'Count'
                }
            ]
        )
        logger.info(f"Published custom metric: HighSeverityFindings with value {severity}")
    except Exception as e:
        logger.error(f"Error publishing custom metric: {str(e)}")

def lambda_handler(event, context):
    """
    Process S3 event notifications and publish findings to CloudWatch.
    """
    # Check for records in the event
    records = event.get('Records', [])
    if not records:
        logger.info("No records found in the event.")
        return {"statusCode": 400, "body": "No records to process"}

    for record in records:
        try:
            # Extract the bucket and object key from the event
            bucket_name = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']

            logger.info(f"Processing object: {object_key} in bucket: {bucket_name}")

            # Skip processing if the object is in the findings folder
            if object_key.startswith("findings/"):
                logger.info(f"Skipping processing for object in findings folder: {object_key}")
                continue

            # Read the S3 object
            response = s3.get_object(Bucket=bucket_name, Key=object_key)
            file_content = response['Body'].read().decode('utf-8')

            # Parse JSON content
            payload = json.loads(file_content)

            # Extract severity and publish metric if high severity
            severity = payload.get('severity', 0)
            if severity >= 7:  # Assuming severity >= 7 is high
                publish_metric(severity)

            # Generate a unique timestamped file name
            timestamp = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
            file_name = f"findings/{timestamp}.json"

            # Save the processed record to S3
            s3.put_object(
                Bucket=BUCKET_NAME,
                Key=file_name,
                Body=json.dumps(payload, indent=2)
            )
            logger.info(f"Processed record saved to S3: {file_name}")

        except Exception as e:
            # Log any errors during processing
            logger.error(f"Error processing record: {str(e)}")
            logger.error(traceback.format_exc())

    return {"statusCode": 200, "body": "Processing complete"}
