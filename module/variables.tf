variable "name" {
  description = "(Required) Name of the dynamodb table."
  type        = string
}

variable "hash_key" {
  description = "(Required, Forces new resource) Attribute to use as the hash (partition) key."
  type        = string
}

variable "range_key" {
  description = "(Optional, Forces new resource) Attribute to use as the range (sort) key."
  type        = string
  default     = null
}

variable "attributes" {
  description = "(Required) List of nested attribute definitions. Only required for hash_key and range_key attributes."
  type        = map(string)
}

variable "billing_mode" {
  description = "(Optional) Controls how you are charged for read and write throughput and how you manage capacity."
  type        = string
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "(Optional) Number of read units for this table."
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "(Optional) Number of write units for this table."
  type        = number
  default     = null
}

variable "stream_enabled" {
  description = "(Optional) Whether Streams are enabled."
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "(Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream."
  type        = string
  default     = null
}

variable "table_class" {
  description = "(Optional) Storage class of the table."
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

variable "tags" {
  description = "(Optional) A map of tags to populate on the created table."
  type        = map(string)
  default     = null
}

variable "timeouts" {
  description = "Terraform resource management timeouts"
  type        = map(string)
  default = {
    create = "30m"
    update = "60m"
    delete = "10m"
  }
}
