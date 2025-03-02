# Lambda function
resource "aws_lambda_function" "presigned_url_lambda" {
  filename      = "lambda_function.zip" 
  function_name = "s3_presigned_url_generator"
  role          = aws_iam_role.lambda_role.arn
  handler       = "s3_presigned_url_generator.lambda_handler"
  runtime       = "python3.11"
  timeout       = 10
  source_code_hash = data.archive_file.lambda_presigned_url_generator_zip.output_base64sha256
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.web_display_bucket.bucket
      OBJECT_KEY  = "test.txt" 
    }
  }
}