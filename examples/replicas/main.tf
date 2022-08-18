provider "aws" {
  region = "eu-west-1"
}

module "config_db" {
  source = "../../module"

  name             = "Configurations"
  hash_key         = "PK"
  range_key        = "SK"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attributes = {
    PK = "S"
    SK = "S"
  }

  replicas = [
    {
      region_name = "eu-west-2"
    }
  ]
}
