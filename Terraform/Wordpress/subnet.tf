resource "aws_subnet" "pb_main" {
  vpc_id                  ="${aws_vpc.pb_main.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "PB public"
  }
}

resource "aws_subnet" "pb_pvt" {
  vpc_id                  ="${aws_vpc.pb_main.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags {
    Name = "PB private"
  }
}

resource "aws_db_subnet_group" "pb_db" {
  name       = "pb_db"
  subnet_ids = ["${aws_subnet.pb_main.id}", "${aws_subnet.pb_pvt.id}"]

  tags {
    Name = "PB DB subnet group"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.pb_main.id}"
}

resource "aws_route" "internet_access" {
  route_table_id          = "${aws_vpc.pb_main.main_route_table_id}"
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = "${aws_internet_gateway.default.id}"
}