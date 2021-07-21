resource "aws_ssm_parameter" "dynamodb_users_table" {
  name = "dynamodb-users-table-${var.workspace}"
  value = aws_dynamodb_table.users.name
  type = "String"

  depends_on = [
    aws_dynamodb_table.users
  ]
}

resource "aws_ssm_parameter" "iam_role_register" {
  name  = "iam-role-register-${var.workspace}"
  type  = "String"
  value = aws_iam_role.register_role.arn
}

resource "aws_ssm_parameter" "dynamodb_users_email_gsi" {
    name  = "${var.workspace}-email-index"
    type  = "String"
    value = "${var.workspace}-email-index"
}

resource "aws_ssm_parameter" "secret_login_key" {
    name  = "${var.workspace}-secret-login-key"
    type  = "String"
    value = "5be8eac847a7dc640643b86c0c3b9330"
}