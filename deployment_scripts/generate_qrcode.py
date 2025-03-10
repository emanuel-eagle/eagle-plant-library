import boto3
import io
import qrcode
import os
import uuid

def push_qr_code_to_s3(filename):
    random_id = uuid.uuid4()
    file_ext_stripped = filename.replace(".html", "")
    crafted_url = f"{URL}?filename={file_ext_stripped}_{random_id}.html"
    image_name = f"api_gateway_qrcode_{file_ext_stripped}_{random_id}.png"
    img = qrcode.make(crafted_url)
    img_byte_arr = io.BytesIO()
    img.save(img_byte_arr, format='PNG')
    img_byte_arr.seek(0)
    s3_client = boto3.client('s3', aws_access_key_id=AWS_ACCESS_KEY_ID, aws_secret_access_key=AWS_SECRET_ACCESS_KEY, region_name='us-east-2')
    s3_client.upload_fileobj(img_byte_arr, QR_CODES_S3_BUCKET_NAME, image_name, ExtraArgs={'ContentType': 'image/png'})

QR_CODES_S3_BUCKET_NAME = os.environ["QR_CODES_S3_BUCKET_NAME"]
AWS_ACCESS_KEY_ID = os.environ["AWS_ACCESS_KEY_ID"]
AWS_SECRET_ACCESS_KEY = os.environ["AWS_SECRET_ACCESS_KEY"]
URL = os.environ["API_GATEWAY_URL"]
files = os.listdir("plant_page_templates")

[push_qr_code_to_s3(file) for file in files]

