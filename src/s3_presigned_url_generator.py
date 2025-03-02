import boto3
import json
import os
import urllib.parse

def lambda_handler(event, context):

    query_params = event.get('queryStringParameters', {}) or {}

    bucket_name = os.environ['BUCKET_NAME']
    object_key = query_params.get('filename')
    
    object_key = urllib.parse.unquote(object_key)

    # Create S3 client
    s3_client = boto3.client('s3')
    
    # Generate a fresh presigned URL (valid for 1 hour)
    presigned_url = s3_client.generate_presigned_url('get_object',
        Params={'Bucket': bucket_name, 'Key': object_key},
        ExpiresIn=3600
    )
    
    # Return an HTTP redirect to the presigned URL
    return {
        'statusCode': 302,
        'headers': {
            'Location': presigned_url
        }
    }