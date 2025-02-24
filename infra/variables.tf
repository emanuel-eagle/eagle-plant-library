variable web_display_bucket_name  {
    type = string
    default = "web-displays-plant-bucket"
}

variable generated_qr_code_storage_bucket_name  {
    type = string
    default = "qr-codes-plant-database-bucket"
}

variable dynamodb_name  {
    type = string
    default = "sensor-data-plant-database"
}

variable apigateway_name  {
    type = string
    default = "api-gateway-plant-database"
}