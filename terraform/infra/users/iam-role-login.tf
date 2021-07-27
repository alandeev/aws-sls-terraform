data "aws_iam_policy_document" "login_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "login_policy_document" {
  statement {
    resources = [
      aws_dynamodb_table.users.arn,
      "${aws_dynamodb_table.users.arn}/index/*"
    ]

    actions = [
      "dynamodb:Query"
    ]
  }

  statement {
    resources = [
      aws_dynamodb_table.rate_limit.arn 
    ]

    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem"
    ]
  }
}

resource "aws_iam_role" "login_role" {
  name = "login-role-${var.workspace}"
  assume_role_policy = data.aws_iam_policy_document.login_role_document.json
}

resource "aws_iam_role_policy" "login_role_policy" {
    name = "login-policy-${var.workspace}"
    role = aws_iam_role.login_role.id
    policy = data.aws_iam_policy_document.login_policy_document.json
}

resource "aws_ssm_parameter" "iam_role_login" {
    name  = "iam-role-login-${var.workspace}"
    type  = "String"
    value = aws_iam_role.login_role.arn
}