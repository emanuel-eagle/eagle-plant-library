import boto3
import io
import qrcode
import os

QR_CODES_S3_BUCKET_NAME = os.environ["QR_CODES_S3_BUCKET_NAME"]

print(QR_CODES_S3_BUCKET_NAME)

url = "www.google.com"
img = qrcode.make(rf"https://{url}")
img_byte_arr = io.BytesIO()
img.save(img_byte_arr, format='PNG')
img_byte_arr.seek(0)  # Move to the beginning of BytesIO object

# s3_client = boto3.client('s3',
#     aws_access_key_id='YOUR_ACCESS_KEY',
#     aws_secret_access_key='YOUR_SECRET_KEY',
#     region_name='YOUR_REGION'
# )

# s3_client.upload_fileobj(
#     img_byte_arr,
#     bucket_name,
#     object_key,
#     ExtraArgs={'ContentType': 'image/png'}
# )