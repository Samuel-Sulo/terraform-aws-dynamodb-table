provider "aws" {
  region = "eu-west-1"
}

module "bank_transactions_db" {
  source = "../../module"

  name                           = "dev-bank-transactions"
  hash_key                       = "accountId"
  range_key                      = "transactionStartedAt"
  billing_mode                   = "PAY_PER_REQUEST"
  stream_enabled                 = true
  stream_view_type               = "NEW_AND_OLD_IMAGES"
  point_in_time_recovery_enabled = false
  ttl_enabled                    = true
  ttl_attribute_name             = "transactionExpiresAt"
  server_side_encryption_enabled = true

  attributes = {
    accountId            = "S"
    transactionStartedAt = "S"
    originCountry        = "S"
  }

  replicas = [
    {
      region_name    = "eu-west-2"
      propagate_tags = true
    }
  ]

  # local_secondary_indexes = [
  #   {
  #     name            = "value"
  #     range_key       = "test"
  #     projection_type = "KEYS_ONLY"
  #   }
  # ]

  global_secondary_indexes = [
    {
      name            = "value"
      hash_key        = "originCountry"
      projection_type = "KEYS_ONLY"
    }
  ]

  tags = {
    Environment = "development"
  }

  timeouts = {
    create = "10m"
  }
}
