resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.project_name}-lambda"
  retention_in_days = 7

  tags = {
    Project = var.project_name
  }
}