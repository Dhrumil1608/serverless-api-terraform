resource "aws_dynamodb_table" "tasks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "taskId"

  attribute {
    name = "taskId"
    type = "S"
  }

  tags = {
    Project     = var.project_name
    Environment = "learning"
  }
}