variable "create_table" {
  description = "(Optional) Wheter to create the table."
  type        = bool
  default     = true
}

variable "name" {
  description = "(Required) Name of the dynamodb table."
  type        = string
}

variable "hash_key" {
  description = "(Required, Forces new resource) Attribute to use as the hash (partition) key. Must also be defined as an attribute."
  type        = string
}

variable "range_key" {
  description = "(Optional, Forces new resource) Attribute to use as the range (sort) key. Must also be defined as an attribute."
  type        = string
  default     = null
}

variable "attributes" {
  description = "(Required) List of nested attribute definitions. Only required for hash_key and range_key attributes."
  type        = map(string)
}

variable "billing_mode" {
  description = "(Optional) Controls how you are charged for read and write throughput and how you manage capacity. Valid values are PROVISIONED and PAY_PER_REQUEST."
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "(Optional) Number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "(Optional) Number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
  type        = number
  default     = null
}

variable "stream_enabled" {
  description = "(Optional) Whether Streams are enabled."
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "(Optional) When an item in the table is modified, determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type        = string
  default     = null
}

variable "table_class" {
  description = "(Optional) Storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS."
  type        = string
  default     = "STANDARD"
}

variable "point_in_time_recovery_enabled" {
  description = "(Optional) Whether to enable point-in-time recovery."
  type        = bool
  default     = false
}

variable "ttl_enabled" {
  description = "(Optional) Whether TTL is enabled."
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "(Optional) Name of the table attribute to store the TTL timestamp in."
  type        = string
  default     = ""
}

variable "server_side_encryption_enabled" {
  description = "(Optional) Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK)."
  type        = bool
  default     = false
}

variable "server_side_encryption_kms_key_arn" {
  description = "(Optional) ARN of the CMK that should be used for the AWS KMS encryption."
  type        = string
  default     = null
}

variable "replicas" {
  description = "(Optional) AWS Regions where this table will be replicated."
  type        = any
  # Waiting for terraform to add support for optional object properties
  # type = list(object({
  #   region_name            = string
  #   kms_key_arn            = (Optional) string
  #   point_in_time_recovery = (Optional) bool
  #   propagate_tags         = (Optional) bool
  # }))
  default = []
}

variable "local_secondary_indexes" {
  description = "(Optional, Forces new resource) List of LSIs to create on the table."
  type        = any
  # Waiting for terraform to add support for optional object properties
  # type = list(object({
  #   name               = string
  #   range_key          = string
  #   projection_type    = string
  #   non_key_attributes = (Optional) set(string)
  # }))
  default = []
}

variable "global_secondary_indexes" {
  description = "(Optional) List of GSIs to create on the table."
  type        = any
  # Waiting for terraform to add support for optional object properties
  # type = list(object({
  #   name               = string
  #   hash_key           = string
  #   projection_type    = string
  #   range_key          = (Optional) string
  #   non_key_attributes = (Optional) set(string)
  #   read_capacity      = (Optional) number
  #   write_capacity     = (Optional) number
  # }))
  default = []
}

variable "restore_date_time" {
  description = "(Optional, Forces new resource) Time of the point-in-time recovery point to restore, conflicts with `restore_to_latest_time`. Must be in RFC3339 time format 2006-01-02T15:04:05Z07:00."
  type        = string
  default     = null
}

variable "restore_source_name" {
  description = "(Optional, Forces new resource) Name of the table to restore. Must match the name of an existing table with PITR enabled."
  type        = string
  default     = null
}

variable "restore_to_latest_time" {
  description = "(Optional, Forces new resource) If set, restores table to the most recent point-in-time recovery point, conflicts with `restore_date_time`."
  type        = bool
  default     = null
}

variable "tags" {
  description = "(Optional) A map of tags to populate on the created table."
  type        = map(string)
  default     = null
}

variable "timeouts" {
  description = "Terraform resource management timeouts."
  type        = map(string)
  default = {
    create = "30m"
    update = "60m"
    delete = "10m"
  }
}

variable "autoscaling_enabled" {
  description = "(Optional, Forces new resource) Wheter autoscaling is enabled."
  type        = bool
  default     = false
}

variable "autoscaling_default" {
  description = "(Optional) Default autoscaling settings to apply to base table and indexes."
  type        = map(number)
  default = {
    scale_in_cooldown  = 0
    scale_out_cooldown = 0
    target_value       = 70
  }
}

variable "autoscaling_table_read" {
  description = "(Optional) Autoscaling settings for RCUs of base table. Required properties: `max_capacity` and `min_capacity`."
  type        = map(number)
  default     = {}
}

variable "autoscaling_table_write" {
  description = "(Optional) Autoscaling settings for WCUs of base table. Required properties: `max_capacity` and `min_capacity`."
  type        = map(number)
  default     = {}
}

variable "autoscaling_indexes_read" {
  description = "(Optional) Autoscaling settings for RCUs of indexes. Required properties: `max_capacity` and `min_capacity`."
  type        = map(map(number))
  default     = {}
}

variable "autoscaling_indexes_write" {
  description = "(Optional) Autoscaling settings for WCUs of indexes. Required properties: `max_capacity` and `min_capacity`."
  type        = map(map(number))
  default     = {}
}
