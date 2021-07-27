resource "aws_dynamodb_table" "rate_limit" {
  name           = "rate-limit-${terraform.workspace}"
  hash_key       = "id"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  ttl {
    attribute_name = "expire_at"
    enabled        = true
  }

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_ssm_parameter" "dynamodb_rate_limit" {
  name = "dynamodb-table-rate-limit-${var.workspace}"
  type = "String"
  value = aws_dynamodb_table.rate_limit.name
}