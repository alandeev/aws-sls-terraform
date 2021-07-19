module "users" {
  source         = "../../infra/users"
  workspace      = var.workspace
  write_capacity = 1
  read_capacity  = 1
}