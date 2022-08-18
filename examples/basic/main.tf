provider "aws" {
  region = "eu-west-1"
}

module "users_db" {
  source = "../../module"

  name     = "Users"
  hash_key = "userId"

  attributes = {
    userId = "S"
  }
}
