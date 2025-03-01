resource "aws_api_gateway_rest_api" "api_gateway_plant_database" {
  name = var.apigateway_name
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id

  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_usage_plan" "api_gateway_plant_database_usage_plan" {
  name = "${var.apigateway_name}-usage-plan"
  

  api_stages {
    api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id
    stage  = aws_api_gateway_stage.api_gateway_plant_database_stage.stage_name
  }

  quota_settings {
    limit  = 10
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 100
    rate_limit  = 50
  }
}

resource "aws_api_gateway_stage" "api_gateway_plant_database_stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_plant_database.id
  stage_name    = "prod"
}

resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_plant_database.id
  resource_id   = aws_api_gateway_resource.presigned_url_resource.id
  http_method   = "GET"
  authorization = "NONE"
  api_key_required = false  
}

resource "aws_api_gateway_resource" "presigned_url_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_plant_database.root_resource_id
  path_part   = "get-s3-object"
}

# Create a mock integration
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_plant_database.id
  resource_id = aws_api_gateway_resource.presigned_url_resource.id
  http_method = aws_api_gateway_method.api_gateway_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.presigned_url_lambda.invoke_arn
}