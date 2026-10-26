output "api_url" {
  description = "Base URL of the deployed HTTP API"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "tasks_endpoint" {
  description = "Endpoint for GET and POST task requests"
  value       = "${aws_apigatewayv2_api.http_api.api_endpoint}/tasks"
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB tasks table"
  value       = aws_dynamodb_table.tasks.name
}

output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = aws_lambda_function.api.function_name
}