# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name = var.dynamodb_name
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 1000
#   write_capacity = 50
# }