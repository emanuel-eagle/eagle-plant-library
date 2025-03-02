output "api_gateway_url" {
  value = "${aws_api_gateway_deployment.api_gateway_deployment.invoke_url}prod/${aws_api_gateway_resource.presigned_url_resource.path_part}"
}

output "website_display_s3_bucket_url" {
  value = aws_s3_bucket.web_display_bucket.bucket_domain_name
}

output "generated_qr_code_s3_bucket_name" {
  value = aws_s3_bucket.generated_qr_code_storage_bucket.bucket_domain_name
}