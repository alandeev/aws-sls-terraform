data "aws_iam_policy_document" "register_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "register_role" {
  name               = "register-role-${var.workspace}"
  assume_role_policy = data.aws_iam_policy_document.register_role_document.json
}