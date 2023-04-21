variable "region" {
  type    = string
  default = "eu-central-1"

}

variable "env" {
  default = "test"
  type = string
  
}

variable "lb_sg_port" {
  type        = number
  default     = 80
  description = "Default LB ingress port"

}

variable "container_port_nginx" {
  type        = number
  default     = 80
  description = "The port number on the container that should be exposed"
}

variable "alb_tg_health_check_interval" {
  type        = number
  default     = 30
  description = "Health check interval used in alb tg"
}

variable "alb_tg_health_check_timeout" {
  type        = number
  default     = 20
  description = "Health check timeout used in alb tg"
}

variable "alb_tg_health_check_path" {
  type        = string
  default     = "/"
  description = "Health check path used in alb tg"
}

#==================lt===========
variable "lt_name" {
  default = "test"
  type    = string

}

variable "instance_type" {
  default = "t2.micro"
  type    = string

}

variable "image_id" {
  type = map(string)
  default = {
    "eu-central-1" = "ami-0479e02f9b310c857"

  }
}

variable "device_name" {
  default = "/dev/xvda"
  type    = string

}

#========asg=========

variable "asg-name" {
  default = "test"
  type    = string

}

variable "min-size" {
  default = 1
  type    = number

}

variable "max-size" {
  default = 1
  type    = number

}

variable "desired_capacity" {
  default = 1
  type    = number

}

variable "health_check_type" {
  default = "ELB"
  type    = string

}

variable "metrics_granularity" {
  default = "1Minute"
  type    = string

}

variable "key_ec2" {
  default = "frankfurt"
  type    = string

}

variable "volume_type" {
  default = "gp2"
  type    = string

}

variable "volume_size" {
  default = 30
  type    = number

}

variable "on_demand_base_capacity" {
  default = 0
  type    = number

}

variable "on_demand_percentage_above_base_capacity" {
  default = 20
  type    = number

}

variable "lt_version" {
  default = "$Latest"
  type    = string

}

#==========capacity provider========

variable "capacity_provider_name" {
  default = "test_capacity_provider"
  type    = string

}

variable "managed_termination_protection" {
  default = "ENABLED"
  type    = string

}

variable "managed_scaling_status" {
  default = "ENABLED"
  type    = string

}

variable "managed_scaling_target" {
  default = 90
  type    = number

}

variable "maximum_scaling_step_size" {
  default = 1
  type    = number

}

#========cluster name=======
variable "cluster_name" {
  type    = string
  default = "test"

}

#===== UP======================================
variable "scaling_adjustment-up" {
  default = 1
  type    = number

}

variable "name-up-policy" {
  default = "test_policy_up"
  type    = string

}

variable "adjustment_type-up" {
  default = "ChangeInCapacity"
  type    = string

}

variable "cooldown-up" {
  default = 60
  type    = number

}

variable "evaluation_periods-up" {
  default = 2
  type    = number

}

variable "alarm_name-up" {
  default = "test_cpu_alarm_up"
  type    = string

}

variable "comparison_operator-up" {
  default = "GreaterThanOrEqualToThreshold"
  type    = string

}

variable "metric_name-up" {
  default = "CPUUtilization"
  type    = string

}


variable "namespace-up" {
  default = "AWS/EC2"
  type    = string

}

variable "period-up" {
  default = 120
  type    = number


}


variable "statistic-up" {
  default = "Average"
  type    = string

}

variable "threshold-up" {
  default = 70
  type    = number


}

variable "alarm_description_up" {
  default = "This metric monitor ec2 instance cpu utilization"
  type    = string

}


#========DOWN====================================

variable "name-down" {
  default = "test_policy_down"
  type    = string

}

variable "scaling_adjustment-down" {
  default = -1
  type    = number

}

variable "adjustment_type-down" {
  default = "ChangeInCapacity"
  type    = string

}

variable "cooldown-down" {
  default = 60
  type    = number

}

variable "alarm_name-down" {
  default = "test_cpu_alarm_down"
  type    = string

}

variable "comparison_operator-down" {
  default = "LessThanOrEqualToThreshold"
  type    = string

}

variable "evaluation_periods-down" {
  default = 2
  type    = number

}

variable "metric_name-down" {
  default = "CPUUtilization"
  type    = string

}

variable "namespace-down" {
  default = "AWS/EC2"
  type    = string

}

variable "period-down" {
  default = 120
  type    = number

}

variable "statistic-down" {
  default = "Average"
  type    = string

}

variable "threshold-down" {
  default = 30
  type    = number

}

variable "alarm_description_down" {
  default = "This metric monitor ec2 instance cpu utilization"
  type    = string

}

#===========polices====
variable "policies" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  ]
}

#============sg=======================
variable "allow_ports_alb" {
  description = "List of Ports to open for alb"
  type        = list(any)
  default     = ["80", "443", "8080", ]
}

variable "secretgame_sg_ports" {
  description = "List of Ports to open for sg"
  type        = list(any)
  default     = ["80", "22", "8080", "443"]
}