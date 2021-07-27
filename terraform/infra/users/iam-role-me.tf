data "aws_iam_policy_document" "me_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "me_policy_document" {
  statement {
    actions = [
      "dynamodb:GetItem"
    ]

    resources = [
      aws_dynamodb_table.users.arn
    ]
  }
}

resource "aws_iam_role" "me_role" {
  name = "role-me-${var.workspace}"
  assume_role_policy = data.aws_iam_policy_document.me_role_document.json
}

resource "aws_iam_role_policy" "me_policy" {
  name = "policy-me-${var.workspace}"
  policy = data.aws_iam_policy_document.me_policy_document.json
  role = aws_iam_role.me_role.id
}

resource "aws_ssm_parameter" "iam_role_me" {
    name  = "iam-role-me-${var.workspace}"
    type  = "String"
    value = aws_iam_role.me_role.arn
}