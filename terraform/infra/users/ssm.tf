resource "aws_ssm_parameter" "dynamodb_users_table" {
  name = "dynamodb-users-table-${var.workspace}"
  value = aws_dynamodb_table.users.name
  type = "String"

  depends_on = [
    aws_dynamodb_table.users
  ]
}

resource "aws_ssm_parameter" "iam_role_register" {
  name = "iam-role-register-${var.workspace}"
  value = aws_iam_role.register_role.arn
  type = "String"
}