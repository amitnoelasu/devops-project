//need to create log group first to use the module

resource "aws_cloudwatch_log_group" "cis-log-group" {
  name = "${local.name}-cis-log-group-${random_pet.this.id}"

  tags = local.common_tags
}

module "cloudwatch_cis-alarms" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/cis-alarms"
  version = "5.7.2"
#   create = false

  log_group_name = aws_cloudwatch_log_group.cis-log-group.name
  ok_actions = [aws_sns_topic.myasg_sns_topic.arn]
  alarm_actions = [aws_sns_topic.myasg_sns_topic.arn]
  tags = local.common_tags
}
