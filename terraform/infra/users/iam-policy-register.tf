data "aws_iam_policy_document" "register_policy_document" {
  statement {
    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      aws_dynamodb_table.users.arn
    ]
  }
}

resource "aws_iam_policy" "register_policy" {
  name                = "register-policy-${var.workspace}"
  policy = data.aws_iam_policy_document.register_policy_document.json
}