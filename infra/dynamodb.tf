resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name = var.dynamodb_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1000
  write_capacity = 50
  hash_key = "plant_id"
  range_key = "plant_name"
  attribute {
    name = "plant_id"
    type = "S"
  }
  attribute {
    name = "plant_name"
    type = "S"
  }
}