provider "aws" {
  region = "eu-west-1"
}

module "users_db" {
  source = "../../module"

  name         = "test-users"
  hash_key     = "userId"
  billing_mode = "PAY_PER_REQUEST"

  attributes = {
    userId = "S"
  }
}
