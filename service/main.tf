resource "aws_ecs_cluster" "test" {
  name               = var.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]


}

resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = var.capacity_provider_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.capacity_provider.arn
    managed_termination_protection = var.managed_termination_protection
    managed_scaling {
      status                    = var.managed_scaling_status
      target_capacity           = var.managed_scaling_target
      maximum_scaling_step_size = var.maximum_scaling_step_size
    }
  }
}

resource "aws_autoscaling_group" "capacity_provider" {
  name                = var.asg-name
  vpc_zone_identifier = data.aws_subnet_ids.public.ids            #[aws_subnet.secretgame_public_a.id, aws_subnet.secretgame_public_b.id]
  max_size            = var.max-size
  min_size            = var.min-size
  desired_capacity    = var.desired_capacity

  capacity_rebalance    = true
  protect_from_scale_in = true

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.test-lt.id
        version            = var.lt_version
      }
    }
  }

  tags = [
    {
      key                 = "Name"
      value               = var.env
      propagate_at_launch = true
    },
  ]
}

resource "aws_launch_template" "test-lt" {
  name                   = var.lt_name
  image_id               = var.image_id[var.region]
  instance_type          = var.instance_type
  key_name               = var.key_ec2
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  ebs_optimized          = false
  user_data              = filebase64("${path.module}/user-data.sh")
  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
      encrypted   = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ecsInstanceRole-profile.name
  }

  tags = {
    Name = var.env
  }

}

#======== UP policy========
resource "aws_autoscaling_policy" "test_policy_up" {
  name                   = var.name-up-policy
  scaling_adjustment     = var.scaling_adjustment-up
  adjustment_type        = var.adjustment_type-up
  cooldown               = var.cooldown-up
  autoscaling_group_name = aws_autoscaling_group.capacity_provider.name
}

resource "aws_cloudwatch_metric_alarm" "test_cpu_alarm_up" {
  alarm_name          = var.alarm_name-up
  comparison_operator = var.comparison_operator-up
  evaluation_periods  = var.evaluation_periods-up
  metric_name         = var.metric_name-up
  namespace           = var.namespace-up
  period              = var.period-up
  statistic           = var.statistic-up
  threshold           = var.threshold-up
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.capacity_provider.name
  }
  alarm_description = var.alarm_description_up
  alarm_actions     = ["${aws_autoscaling_policy.test_policy_up.arn}"]
}

#======== DOWN policy========
resource "aws_autoscaling_policy" "test_policy_down" {
  name                   = var.name-down
  scaling_adjustment     = var.scaling_adjustment-down
  adjustment_type        = var.adjustment_type-down
  cooldown               = var.cooldown-down
  autoscaling_group_name = aws_autoscaling_group.capacity_provider.name
}

resource "aws_cloudwatch_metric_alarm" "test_cpu_alarm_down" {
  alarm_name          = var.alarm_name-down
  comparison_operator = var.comparison_operator-down
  evaluation_periods  = var.evaluation_periods-down
  metric_name         = var.metric_name-down
  namespace           = var.namespace-down
  period              = var.period-down
  statistic           = var.statistic-down
  threshold           = var.threshold-down

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.capacity_provider.name}"
  }

  alarm_description = var.alarm_description_down
  alarm_actions     = ["${aws_autoscaling_policy.test_policy_down.arn}"]
}