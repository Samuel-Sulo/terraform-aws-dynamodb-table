provider "aws" {
  region = "eu-west-1"
}

module "customers_db" {
  source = "../../module"

  name      = "Customers"
  hash_key  = "customerId"
  range_key = "orderId"

  attributes = {
    customerId      = "S"
    orderId         = "S"
    orderStatus     = "S"
    deliveryAddress = "S"
    deliveredAt     = "S"
  }

  local_secondary_indexes = [
    {
      name            = "OrderStatus"
      range_key       = "orderStatus"
      projection_type = "KEYS_ONLY"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "Deliveries"
      hash_key           = "deliveryAddress"
      range_key          = "deliveredAt"
      projection_type    = "INCLUDE"
      non_key_attributes = ["customerId", "orderId", "orderStatus"]
    }
  ]
}
