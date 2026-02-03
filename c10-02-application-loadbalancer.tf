module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  load_balancer_type = "application" // is also the default value
  enable_deletion_protection = false // true is default
  # Security Group
  security_groups = [module.loadbalancer-sg.security_group_id]
  
    // requires s3 bucket to be created
#   access_logs = {
#     bucket = "my-alb-logs"
#   }

  listeners = {
    # ex-http-https-redirect = {
    #   port     = 80
    #   protocol = "HTTP"
    #   redirect = {
    #     port        = "443"
    #     protocol    = "HTTPS"
    #     status_code = "HTTP_301"
    #   }
    # }
    # ex-https = {
    #   port            = 443
    #   protocol        = "HTTPS"
    #   certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

    #   forward = {
    #     target_group_key = "ex-instance"
    #   }
    # }
    ex-http = {
      port            = 80
      protocol        = "HTTP"
    #   certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

      forward = {
        target_group_key = "mytg1"
      }
    }
  }

  target_groups = {
    mytg1 = {
        // do not create own target group attachment. We will create manually using resource block
      create_attachment = false
      //
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
    #   target_id        = resource.mytg1.id
      tags = local.common_tags
    } // end of target group 1

  } // end of target groups

  tags = local.common_tags
}


resource "aws_lb_target_group_attachment" "mytg1" {
  # covert a list of instance objects to a map with instance ID as the key, and an instance
  # object as the value.
  for_each = {
    for k, v in module.ec2-private :
    k => v
  }

  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}

// temp app outputs
output "kv-output-ec2-private"{
    value = {for k, v in module.ec2-private: k => v}
}
