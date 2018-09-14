resource "aws_elb" "pb_elb" {
  name                = "pb-tf-elb"
  #availability_zones = ["us-east-1a"]
  subnets = ["${aws_subnet.pb_main.id}"]
  security_groups     = ["${aws_security_group.allow_web.id}","${aws_security_group.allow_ssh.id}"]

#  access_logs {
#    bucket        = "pb-elb-access-logs"
#    bucket_prefix = "LOGS"
#    interval      = 60
#  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

#  listener {
#    instance_port      = 8000
#    instance_protocol  = "http"
#    lb_port            = 443
#    lb_protocol        = "https"
#    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.wordpress.*.id}"]
  cross_zone_load_balancing   = false
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "pb-tf-elb"
  }
}
