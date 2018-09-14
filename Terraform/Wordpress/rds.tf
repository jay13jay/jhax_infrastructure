resource "aws_db_instance" "wordpress_db" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7.22"
  instance_class          = "db.t2.micro"
  name                    = "wordpress_db"
  username                = "wordpress"
  password                = "wordpress"
  port                    = 3066
  vpc_security_group_ids  = ["${aws_security_group.allow_mysql.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.redmine_db.id}"
  availability_zone       = "us-east-1a"
  skip_final_snapshot     = true
}