resource "aws_launch_template" "my_launch_template" {
  name = "my_launch_template"
  description = "my launch template"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 10
      delete_on_termination = true
      volume_type = "gp2"
    }
  }

  ebs_optimized = true
  image_id = data.aws_ami.amz-linux2.id
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
  }

  instance_type = var.instance_type

  key_name = var.instance_keypair

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }


  vpc_security_group_ids = [module.private-sg.security_group_id]

  tag_specifications {
    resource_type = "instance"

    tags = local.common_tags
  }

  user_data = filebase64("${path.module}/app1-install.sh")

  update_default_version = true
}