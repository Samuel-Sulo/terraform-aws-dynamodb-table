resource "aws_dynamodb_table" "this" {
  name             = var.name
  hash_key         = var.hash_key
  range_key        = var.range_key
  billing_mode     = var.billing_mode
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  table_class      = var.table_class
  # restore_date_time      = ""
  # restore_source_name    = ""
  # restore_to_latest_time = ""

  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.server_side_encryption_kms_key_arn
  }


  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.key
      type = attribute.value
    }
  }

  dynamic "replica" {
    for_each = var.replicas

    content {
      region_name            = replica.value.region_name
      kms_key_arn            = lookup(replica.value, "kms_key_arn", null)
      point_in_time_recovery = lookup(replica.value, "point_in_time_recovery", null)
      propagate_tags         = lookup(replica.value, "propagate_tags", null)
    }
  }

  tags = merge(var.tags, { Name = var.name })

  # global_secondary_index {

  # }

  # local_secondary_index {

  # }
}
