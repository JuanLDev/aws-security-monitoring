resource "aws_iam_policy" "lambda_kinesis_policy" {
  name   = "lambda_kinesis_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["kinesis:GetRecords","kinesis:PutRecord", "kinesis:DescribeStream", "kinesis:ListStreams"],
        Resource = "arn:aws:kinesis:${var.aws_region}:${var.aws_account_id}:stream/${var.kinesis_stream_name}"

      },
      {
        Effect   = "Allow",
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
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


resource "aws_iam_role_policy_attachment" "lambda_kinesis_attach" {
  role       = aws_iam_role.lambda_exec_role_guardduty.name
  policy_arn = aws_iam_policy.lambda_kinesis_policy.arn
}
