provider "aws" {
  region = "eu-west-1"
}

module "user_pwd_exp_db" {
  source = "../../"

  name               = "UserPwdExp"
  hash_key           = "userId"
  ttl_enabled        = true
  ttl_attribute_name = "exp"
  stream_enabled     = true
  stream_view_type   = "KEYS_ONLY"

  attributes = {
    userId = "S"
  }
}
