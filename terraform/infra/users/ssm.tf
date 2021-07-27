resource "aws_ssm_parameter" "secret_login_key" {
    name  = "${var.workspace}-secret-login-key"
    type  = "String"
    value = "5be8eac847a7dc640643b86c0c3b9330"
}