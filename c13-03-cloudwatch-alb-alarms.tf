resource "aws_cloudwatch_metric_alarm" "alb-4xx-errors" {
  alarm_name          = "${local.name}-alb-4xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_ELB_4XX_Count"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 4
  alarm_description   = "Number of 5xx errors in specified time period"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.myasg_sns_topic.arn]
  ok_actions          = [aws_sns_topic.myasg_sns_topic.arn]
  dimensions = {
    # TargetGroup  = aws_lb_target_group.lb-tg.arn_suffix
    LoadBalancer = module.alb.arn_suffix
  }
}