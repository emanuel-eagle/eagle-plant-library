# resource "aws_api_gateway_rest_api" "api_gateway_plant_database" {
#   name = var.apigateway_name
# }

# resource "aws_api_gateway_deployment" "api_gateway_deployment" {
#   rest_api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id

#   depends_on = [
#     aws_api_gateway_integration.example_get
#   ]

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_usage_plan" "api_gateway_plant_database_usage_plan" {
#   name = "${var.apigateway_name}-usage-plan"

#   api_stages {
#     api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id
#     stage  = aws_api_gateway_stage.api_gateway_plant_database_stage.stage_name
#   }

#   quota_settings {
#     limit  = 10
#     period = "DAY"
#   }

#   throttle_settings {
#     burst_limit = 100
#     rate_limit  = 50
#   }
# }

# resource "aws_api_gateway_api_key" "api_gateway_plant_database_api_key" {
#   name = "test-key"
# }

# resource "aws_api_gateway_stage" "api_gateway_plant_database_stage" {
#   deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
#   rest_api_id   = aws_api_gateway_rest_api.api_gateway_plant_database.id
#   stage_name    = "dev"
# }

# resource "aws_api_gateway_method" "example_get" {
#   rest_api_id   = aws_api_gateway_rest_api.api_gateway_plant_database.id
#   resource_id   = aws_api_gateway_resource.example.id
#   http_method   = "GET"
#   authorization = "NONE"
#   api_key_required = true
# }

# # Create a mock integration
# resource "aws_api_gateway_integration" "example_get" {
#   rest_api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id
#   resource_id = aws_api_gateway_resource.example.id
#   http_method = aws_api_gateway_method.example_get.http_method
#   type        = "MOCK"

#   request_templates = {
#     "application/json" = jsonencode({
#       statusCode = 200
#     })
#   }
# }