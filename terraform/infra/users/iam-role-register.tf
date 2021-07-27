data "aws_iam_policy_document" "register_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

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

  statement {
    resources = [
      aws_dynamodb_table.users.arn,
      "${aws_dynamodb_table.users.arn}/*"
    ]

    actions = [
      "dynamodb:Query"
    ]
  }
}

resource "aws_iam_role" "register_role" {
  name               = "register-role-${var.workspace}"
  assume_role_policy = data.aws_iam_policy_document.register_role_document.json
}

resource "aws_iam_role_policy" "iam_role_login" {
  name   = "me-role-${var.workspace}"
  policy = data.aws_iam_policy_document.register_policy_document.json
  role   = aws_iam_role.register_role.id
}

resource "aws_ssm_parameter" "iam_role_register" {
  name  = "iam-role-register-${var.workspace}"
  type  = "String"
  value = aws_iam_role.register_role.arn
}