resource "aws_dynamodb_table" "users" {
  name = "users-${var.workspace}"
  hash_key = "id"
  billing_mode = "PROVISIONED"
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name = "${var.workspace}-email-index"
    hash_key = "email"
    projection_type = "ALL"

    read_capacity = var.read_capacity
    write_capacity = var.write_capacity
  }
}

resource "aws_ssm_parameter" "dynamodb_users_table" {
  name = "dynamodb-users-table-${var.workspace}"
  value = aws_dynamodb_table.users.name
  type = "String"

  depends_on = [
    aws_dynamodb_table.users
  ]
}

resource "aws_ssm_parameter" "dynamodb_users_email_gsi" {
    name  = "${var.workspace}-email-index"
    type  = "String"
    value = "${var.workspace}-email-index"
}