resource "aws_appautoscaling_target" "table_read" {
  count = var.autoscaling_enabled ? 1 : 0

  resource_id        = "table/${aws_dynamodb_table.this.name}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  min_capacity       = var.autoscaling_table_read.min_capacity
  max_capacity       = var.autoscaling_table_read.max_capacity
}

resource "aws_appautoscaling_policy" "table_read" {
  count = var.autoscaling_enabled ? 1 : 0

  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.table_read[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.table_read[0].resource_id
  service_namespace  = aws_appautoscaling_target.table_read[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.table_read[0].scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = lookup(var.autoscaling_table_read, "scale_in_cooldown", var.autoscaling_default.scale_in_cooldown)
    scale_out_cooldown = lookup(var.autoscaling_table_read, "scale_out_cooldown", var.autoscaling_default.scale_out_cooldown)
    target_value       = lookup(var.autoscaling_table_read, "target_value", var.autoscaling_default.target_value)
  }
}

resource "aws_appautoscaling_target" "table_write" {
  count = var.autoscaling_enabled ? 1 : 0

  resource_id        = "table/${aws_dynamodb_table.this.name}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  min_capacity       = var.autoscaling_table_write.min_capacity
  max_capacity       = var.autoscaling_table_write.max_capacity
}

resource "aws_appautoscaling_policy" "table_write" {
  count = var.autoscaling_enabled ? 1 : 0

  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.table_write[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.table_write[0].resource_id
  service_namespace  = aws_appautoscaling_target.table_write[0].service_namespace
  scalable_dimension = aws_appautoscaling_target.table_write[0].scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = lookup(var.autoscaling_table_write, "scale_in_cooldown", var.autoscaling_default.scale_in_cooldown)
    scale_out_cooldown = lookup(var.autoscaling_table_write, "scale_out_cooldown", var.autoscaling_default.scale_out_cooldown)
    target_value       = lookup(var.autoscaling_table_write, "target_value", var.autoscaling_default.target_value)
  }
}

resource "aws_appautoscaling_target" "index_read" {
  for_each = var.autoscaling_enabled ? var.autoscaling_indexes_read : {}

  resource_id        = "table/${aws_dynamodb_table.this.name}/index/${each.key}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  min_capacity       = each.value.min_capacity
  max_capacity       = each.value.max_capacity
}

resource "aws_appautoscaling_policy" "index_read" {
  for_each = var.autoscaling_enabled ? var.autoscaling_indexes_read : {}

  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.index_read[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_read[each.key].resource_id
  service_namespace  = aws_appautoscaling_target.index_read[each.key].service_namespace
  scalable_dimension = aws_appautoscaling_target.index_read[each.key].scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = lookup(each.value, "scale_in_cooldown", var.autoscaling_default.scale_in_cooldown)
    scale_out_cooldown = lookup(each.value, "scale_out_cooldown", var.autoscaling_default.scale_out_cooldown)
    target_value       = lookup(each.value, "target_value", var.autoscaling_default.target_value)
  }
}

resource "aws_appautoscaling_target" "index_write" {
  for_each = var.autoscaling_enabled ? var.autoscaling_indexes_write : {}

  resource_id        = "table/${aws_dynamodb_table.this.name}/index/${each.key}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  min_capacity       = each.value.min_capacity
  max_capacity       = each.value.max_capacity
}

resource "aws_appautoscaling_policy" "index_write" {
  for_each = var.autoscaling_enabled ? var.autoscaling_indexes_write : {}

  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.index_write[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_write[each.key].resource_id
  service_namespace  = aws_appautoscaling_target.index_write[each.key].service_namespace
  scalable_dimension = aws_appautoscaling_target.index_write[each.key].scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = lookup(each.value, "scale_in_cooldown", var.autoscaling_default.scale_in_cooldown)
    scale_out_cooldown = lookup(each.value, "scale_out_cooldown", var.autoscaling_default.scale_out_cooldown)
    target_value       = lookup(each.value, "target_value", var.autoscaling_default.target_value)
  }
}
