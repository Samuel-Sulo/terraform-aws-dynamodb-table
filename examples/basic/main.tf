provider "aws" {
  region = "eu-west-1"
}

module "users_db" {
  source = "../../module"

  name                = "test-users"
  hash_key            = "userId"
  billing_mode        = "PROVISIONED"
  read_capacity       = 1
  write_capacity      = 1
  autoscaling_enabled = true
  autoscaling_read    = { max_capacity = 10 }
  autoscaling_write   = { max_capacity = 10 }

  attributes = {
    userId = "S"
  }
}
