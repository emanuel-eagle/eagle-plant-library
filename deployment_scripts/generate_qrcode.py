import qrcode
import boto3

url = "www.google.com"
img = qrcode.make(rf"https://{url}")
print(url)

