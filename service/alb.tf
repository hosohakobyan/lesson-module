module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "test-alb"

  load_balancer_type = "application"

  vpc_id             = data.aws_vpc.project.id
  subnets            = data.aws_subnet_ids.public.ids
  security_groups    = [aws_security_group.test_sg_alb.id]

 
 target_groups = [
    {
      name             = "test-tg"
      backend_protocol = "HTTP"
      backend_port     = var.container_port_nginx
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = var.alb_tg_health_check_interval
        path                = var.alb_tg_health_check_path
        port                = "traffic-port"
        healthy_threshold   = 4
        unhealthy_threshold = 4
        timeout             = var.alb_tg_health_check_timeout
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "test"
  }
}