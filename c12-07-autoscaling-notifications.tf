// SNS topic

resource "aws_sns_topic" "myasg_sns_topic" {
  name = "myasg_sns_topic-${random_pet.this.id}"
}

// sns subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.myasg_sns_topic.arn
  protocol  = "email"
  endpoint  = "amitnoelms@gmail.com"
}

// create autoscaling notification resource
resource "aws_autoscaling_notification" "myasg_notifications" {
  group_names = [
    aws_autoscaling_group.asg.name,
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.myasg_sns_topic.arn
}

