provider "aws" {
  region = "eu-west-1"
}

module "config_db" {
  source = "../../"

  name                           = "Configurations"
  hash_key                       = "PK"
  range_key                      = "SK"
  stream_enabled                 = true
  stream_view_type               = "NEW_AND_OLD_IMAGES"
  server_side_encryption_enabled = true
  point_in_time_recovery_enabled = true

  attributes = {
    PK = "S"
    SK = "S"
  }

  replicas = [
    {
      region_name            = "eu-west-2"
      point_in_time_recovery = true
      propagate_tags         = true
    }
  ]

  tags = {
    Environment = "Development"
  }
}
