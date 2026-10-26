variable "aws_region" {
  description = "AWS region for the serverless API"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Prefix used to name project resources"
  type        = string
  default     = "serverless-api"
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "serverless-api-tasks"
}