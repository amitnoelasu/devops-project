

resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name  = "increase_capacity_9am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 8
#   start_time             = "2016-12-11T18:00:00Z" // UTC time
#   end_time               = "2016-12-12T06:00:00Z"
  recurrence = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}


resource "aws_autoscaling_schedule" "increase_capacity_9pm" {
  scheduled_action_name  = "decrease_capacity_9am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
#   start_time             = "2016-12-11T18:00:00Z" // UTC time
#   end_time               = "2016-12-12T06:00:00Z"
  recurrence = "00 21 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg.name
}