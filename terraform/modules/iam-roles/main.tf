resource "aws_iam_policy" "lambda_athena_policy" {
  name   = "lambda_athena_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        # Allow Lambda to write logs
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        # Allow Lambda to interact with the S3 bucket (GuardDuty findings)
        Effect   = "Allow",
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetBucketLocation"
        ],
        Resource = [
          "arn:aws:s3:::guardduty-findings-processed",
          "arn:aws:s3:::guardduty-findings-processed/*"
        ]
      },
      {
        # Allow Lambda to query Athena
        Effect   = "Allow",
        Action   = [
          "athena:StartQueryExecution",
          "athena:GetQueryExecution",
          "athena:GetQueryResults",
          "athena:StopQueryExecution",
          "athena:ListDatabases",
          "athena:ListTableMetadata",
          "athena:GetTableMetadata"
        ],
        Resource = "*"
      },
      {
        # Optional: Allow CloudWatch custom metrics and alarms
        Effect   = "Allow",
        Action   = [
          "cloudwatch:PutMetricData",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutMetricAlarm"
        ],
        Resource = "*"
      },
      {
        # Allow access to the S3 bucket used by Athena for query results
        Effect   = "Allow",
        Action   = [
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads"
        ],
        Resource = "arn:aws:s3:::athena-query-results-bucket"
      },
      {
        # Allow Athena to write query results to the S3 bucket
        Effect   = "Allow",
        Action   = [
          "s3:AbortMultipartUpload",
          "s3:PutObject",
          "s3:ListMultipartUploadParts"
        ],
        Resource = "arn:aws:s3:::athena-query-results-bucket/*"
      },
      {
        # Allow Lambda to use Glue Data Catalog (if using Athena with Glue integration)
        Effect   = "Allow",
        Action   = [
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables",
          "glue:CreateTable",
          "glue:UpdateTable"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "lambda_exec_role_guardduty" {
  name               = "lambda_exec_role_guardduty"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_athena_attach" {
  role       = aws_iam_role.lambda_exec_role_guardduty.name
  policy_arn = aws_iam_policy.lambda_athena_policy.arn
}
