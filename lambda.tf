data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/app.py"
  output_path = "${path.module}/lambda/function.zip"
}

resource "aws_lambda_function" "api" {
  function_name = "${var.project_name}-lambda"
  role          = aws_iam_role.lambda_role.arn

  runtime = "python3.13"
  handler = "app.lambda_handler"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout     = 10
  memory_size = 128

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.tasks.name
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_permissions,
    aws_cloudwatch_log_group.lambda_logs
  ]

  tags = {
    Project = var.project_name
  }
}