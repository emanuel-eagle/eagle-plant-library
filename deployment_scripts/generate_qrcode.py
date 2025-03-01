import boto3
import io
import qrcode
import os

QR_CODES_S3_BUCKET_NAME = os.environ["QR_CODES_S3_BUCKET_NAME"]
AWS_ACCESS_KEY_ID = os.environ["AWS_ACCESS_KEY_ID"]
AWS_SECRET_ACCESS_KEY = os.environ["AWS_SECRET_ACCESS_KEY"]

url = "www.google.com"
img = qrcode.make(rf"https://{url}")
img_byte_arr = io.BytesIO()
img.save(img_byte_arr, format='PNG')
img_byte_arr.seek(0)  # Move to the beginning of BytesIO object

s3_client = boto3.client('s3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name='us-east-2'
)

s3_client.upload_fileobj(
    img_byte_arr,
    QR_CODES_S3_BUCKET_NAME,
    url,
    ExtraArgs={'ContentType': 'image/png'}
)