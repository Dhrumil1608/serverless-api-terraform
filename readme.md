\# Serverless REST API with Terraform
\## Project Overview

This project demonstrates how to build and deploy a serverless REST API on AWS using Terraform. The API supports creating tasks and retrieving saved tasks through HTTP endpoints.

All application infrastructure is defined as code and deployed using Terraform.

\## Architecture

Client (curl / Postman)  
→ Amazon API Gateway HTTP API  
→ AWS Lambda (Python 3.13)  
→ Amazon DynamoDB

Supporting services:

\- IAM execution role and least-privilege permissions
\- Amazon CloudWatch Logs
\- Terraform AWS and Archive providers

\## AWS Services Used

| Service | Purpose |

|---|---|
| Terraform | Infrastructure as Code |
| API Gateway HTTP API | Exposes GET and POST endpoints |
| AWS Lambda | Executes Python application code |
| Amazon DynamoDB | Stores task records |
| AWS IAM | Controls Lambda permissions |
| Amazon CloudWatch Logs | Captures application logs |
\## Region


`ap-south-1` — Asia Pacific (Mumbai)
\## API Endpoints

Replace 'https://w8jvp902aa.execute-api.ap-south-1.amazonaws.com/tasks' with the API URL printed by Terraform.

| Method | Endpoint | Description |
|---|---|---|
| POST | 'https://w8jvp902aa.execute-api.ap-south-1.amazonaws.com/tasks' | Creates a task |
| GET | 'https://w8jvp902aa.execute-api.ap-south-1.amazonaws.com/tasks' | Retrieves tasks |

\## Example POST Request

```json
{
&#x20; "task": "Learn Terraform",
&#x20; "status": "pending"
}
```

Example successful response:

```json

{
&#x20; "message": "Task created",
&#x20; "task": {
&#x20;   "taskId": "generated-uuid",
&#x20;   "task": "Learn Terraform",
&#x20;   "status": "pending"
&#x20; }
}
```

\## Example GET Request

```bash
curl "https://w8jvp902aa.execute-api.ap-south-1.amazonaws.com/tasks"
```

The API returns a JSON object containing the task count and saved tasks.

\## Terraform Deployment

Prerequisites:

\- AWS CLI configured with appropriate permissions
\- Terraform installed
\- Python installed for local development
\- Git installed


Initialize and validate:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

Deploy:

```bash
terraform apply
```

Retrieve the API endpoint:

```bash
terraform output tasks\_endpoint
```

\## Testing

The following tests were performed:

\- POST request successfully created a task.
\- GET request returned the saved task.
\- The returned task ID matched between the POST and GET responses.

Additional checks can verify the DynamoDB item, Lambda function, CloudWatch logs, and IAM permissions.

\## Screenshots

See the `screenshots/` directory for evidence from the actual deployment:

\- `post-response.png`
\- `get-response.png`
\- `terraform-apply.png`
\- `dynamodb-item.png`

\## Security

\- Lambda uses a dedicated execution role.
\- DynamoDB permissions are scoped to the project's table.
\- CloudWatch logging permissions are limited to the designated log group.
\- AWS credentials and Terraform state files must not be committed to GitHub.
\## Cleanup

After saving the required evidence, remove the resources managed by this project:

```bash
terraform destroy
```

Review the deletion plan before confirming.

\## Learning Outcomes

This project demonstrates practical experience with Infrastructure as Code, serverless computing, HTTP APIs, Python Lambda development, DynamoDB integration, IAM permissions, CloudWatch logging, CLI testing, and Git-based project documentation.