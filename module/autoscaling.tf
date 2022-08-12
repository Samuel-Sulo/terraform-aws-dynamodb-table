locals {
  autoscaling_read  = merge(var.autoscaling_default, var.autoscaling_read)
  autoscaling_write = merge(var.autoscaling_default, var.autoscaling_write)
}

resource "aws_appautoscaling_target" "table_read" {
  count = var.autoscaling_enabled ? 1 : 0

  resource_id        = "table/${aws_dynamodb_table.this.name}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  min_capacity       = var.read_capacity
  max_capacity       = var.autoscaling_read.max_capacity
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

    scale_in_cooldown  = lookup(local.autoscaling_read, "scale_in_cooldown", null)
    scale_out_cooldown = lookup(local.autoscaling_read, "scale_out_cooldown", null)
    target_value       = lookup(local.autoscaling_read, "target_value", null)
  }
}

resource "aws_appautoscaling_target" "table_write" {
  count = var.autoscaling_enabled ? 1 : 0

  resource_id        = "table/${aws_dynamodb_table.this.name}"
  service_namespace  = "dynamodb"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  min_capacity       = var.write_capacity
  max_capacity       = var.autoscaling_write.max_capacity
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

    scale_in_cooldown  = lookup(local.autoscaling_write, "scale_in_cooldown", null)
    scale_out_cooldown = lookup(local.autoscaling_write, "scale_out_cooldown", null)
    target_value       = lookup(local.autoscaling_write, "target_value", null)
  }
}
