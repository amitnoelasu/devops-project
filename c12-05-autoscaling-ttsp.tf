// target tracking scaling policy



resource "aws_autoscaling_policy" "avg_cpu_greater_than_xx" {
  name                   = "avg_cpu_greater_than_xx"
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  autoscaling_group_name = aws_autoscaling_group.asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }

}

resource "aws_autoscaling_policy" "avg_requests_greater_than_xx" {
  depends_on = [module.alb]
  name                   = "avg_requests_greater_than_xx"
  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 180
  autoscaling_group_name = aws_autoscaling_group.asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg1"].arn_suffix}"
    }
    target_value = 10.0
  }
}
