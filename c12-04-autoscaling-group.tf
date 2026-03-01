# resource "aws_placement_group" "test" {
#   name     = "test"
#   strategy = "cluster"
# }

resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
#   placement_group           = aws_placement_group.test.id
  # launch_configuration      = aws_launch_configuration..name
  vpc_zone_identifier       = toset(module.vpc.private_subnets)
  target_group_arns = toset([module.alb.target_groups["mytg1"].arn])

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = 300 // default behavior  = health check grace period
    }
    triggers = ["desired_capacity"]
  }


  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

#   initial_lifecycle_hook {
#     name                 = "foobar"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

  tag {
    key                 = "Owners"
    value               = "devteam"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

}