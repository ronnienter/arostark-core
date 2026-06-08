resource "aws_iam_role" "lambda_guardduty" {
  name = "${var.project_name}-lambda-guardduty-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-lambda-guardduty-role"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role_policy" "lambda_guardduty" {
  name = "${var.project_name}-lambda-guardduty-policy"
  role = aws_iam_role.lambda_guardduty.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "sns:Publish"
        ]
        Resource = "*"
      }
    ]
  })
}

data "archive_file" "lambda_guardduty" {
  type        = "zip"
  source_file = "lambda/guardduty_response.py"
  output_path = "lambda/guardduty_response.zip"
}

resource "aws_lambda_function" "guardduty_response" {
  filename         = "lambda/guardduty_response.zip"
  function_name    = "${var.project_name}-guardduty-response"
  role             = aws_iam_role.lambda_guardduty.arn
  handler          = "guardduty_response.handler"
  runtime          = "python3.12"
  source_code_hash = data.archive_file.lambda_guardduty.output_base64sha256

  tags = {
    Name        = "${var.project_name}-guardduty-response"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  name        = "${var.project_name}-guardduty-findings"
  description = "Capture GuardDuty findings and trigger Lambda"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })

  tags = {
    Name        = "${var.project_name}-guardduty-findings"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_event_target" "guardduty_lambda" {
  rule      = aws_cloudwatch_event_rule.guardduty_findings.name
  target_id = "GuardDutyLambda"
  arn       = aws_lambda_function.guardduty_response.arn
}

resource "aws_lambda_permission" "guardduty_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.guardduty_response.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty_findings.arn
}