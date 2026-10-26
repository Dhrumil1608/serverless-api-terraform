import json
import logging
import os
import uuid

import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body)
    }


def lambda_handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method")
    path = event.get("rawPath", "")

    logger.info("Received request: %s %s", method, path)

    if path != "/tasks":
        return response(404, {"error": "Route not found"})

    try:
        if method == "POST":
            raw_body = event.get("body") or "{}"

            try:
                body = json.loads(raw_body)
            except json.JSONDecodeError:
                return response(400, {"error": "Invalid JSON body"})

            if not isinstance(body, dict):
                return response(400, {"error": "JSON body must be an object"})

            task_name = body.get("task")
            status = body.get("status", "pending")

            if not isinstance(task_name, str) or not task_name.strip():
                return response(400, {"error": "task is required"})

            if not isinstance(status, str) or not status.strip():
                return response(400, {"error": "status must be a non-empty string"})

            item = {
                "taskId": str(uuid.uuid4()),
                "task": task_name.strip(),
                "status": status.strip()
            }

            table.put_item(Item=item)

            logger.info("Created task: %s", item["taskId"])
            return response(201, {"message": "Task created", "task": item})

        if method == "GET":
            items = []
            scan_args = {}

            while True:
                result = table.scan(**scan_args)
                items.extend(result.get("Items", []))

                last_key = result.get("LastEvaluatedKey")
                if not last_key:
                    break

                scan_args["ExclusiveStartKey"] = last_key

            return response(200, {"count": len(items), "tasks": items})

        return response(405, {"error": "Method not allowed"})

    except ClientError:
        logger.exception("DynamoDB operation failed")
        return response(500, {"error": "Database operation failed"})

    except Exception:
        logger.exception("Unexpected application error")
        return response(500, {"error": "Internal server error"})