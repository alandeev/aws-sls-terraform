data "aws_iam_policy_document" "register_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.users.arn
    ]
  }
}

resource "aws_iam_role_policy" "register_role_policy" {
  name   = "register-policy-${var.workspace}"
  policy = data.aws_iam_policy_document.register_policy_document.json
  role   = aws_iam_role.register_role.id
}