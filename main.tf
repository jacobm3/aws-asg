provider "aws" {
  region = "us-east-1"
}

module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "coolest-asg"

  # Launch configuration
  lc_name = "best-lc-ever"

  image_id        = "ami-2757f631"
  instance_type   = "t2.micro"
  security_groups = ["sg-0202d12a0907030e3"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "coolest-asg"
  vpc_zone_identifier       = ["subnet-07e11a155b1d15faa", "subnet-0f1aa1afac01c5ed6"]
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 5
  desired_capacity          = 5
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "owner"
      value               = "jmartinson@hashicorp.com"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
