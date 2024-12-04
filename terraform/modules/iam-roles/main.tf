resource "aws_iam_policy" "lambda_kinesis_policy" {
  name   = "lambda_kinesis_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["kinesis:GetRecords", "kinesis:DescribeStream", "kinesis:ListStreams"],
        Resource = module.kinesis.kinesis_stream_arn
      },
      {
        Effect   = "Allow",
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_kinesis_policy.arn
}
