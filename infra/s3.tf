resource "aws_s3_bucket" "web_display_bucket_template" {
  bucket = var.web_display_bucket_name_templates
}

resource "aws_s3_bucket" "web_display_bucket" {
  bucket = var.web_display_bucket_name
  
}

resource "aws_s3_bucket" "generated_qr_code_storage_bucket" {
  bucket = var.generated_qr_code_storage_bucket_name
}
