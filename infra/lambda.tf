# # Lambda function
# resource "aws_lambda_function" "presigned_url_lambda" {
#   filename      = "lambda_function.zip" # You'll need to create this ZIP file with your Lambda code
#   function_name = "s3_presigned_url_generator"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "lambda_function.lambda_handler"
#   runtime       = "python3.9"
#   timeout       = 10

#   environment {
#     variables = {
#       BUCKET_NAME = aws_s3_bucket.content_bucket.bucket
#       OBJECT_KEY  = "path/to/your/file.pdf" # Change to your object key
#     }
#   }
# }
