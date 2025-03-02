data "archive_file" "lambda_presigned_url_generator_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/s3_presigned_url_generator.py"
  output_path = "${path.module}/../infra/lambda_function.zip"
}