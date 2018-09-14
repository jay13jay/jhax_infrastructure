# Create a new docker capable instance
resource "aws_instance" "wordpress" {
  ami                     = "ami-7209f41f" # centos 7 base image
  count                   = 1
  instance_type           = "t2.micro"
  key_name                = "wordpress"
  subnet_id               = "${aws_subnet.pb_main.id}"
  #vpcs                  = "${aws_vpc.pb_main.id}"
  vpc_security_group_ids  = [ "${aws_security_group.allow_web.id}","${aws_security_group.allow_ssh.id}"]

  tags {
    Name                  = "wordpress-${count.index}"
  }


  connection {
    Type        = "ssh"
    private_key = "${file("./secret/wordpress.pem")}"
    user        = "centos"
  }

  provisioner "remote-exec" {
    inline = [ "sudo yum install -y docker",
      "sudo service docker restart",
      "sudo docker pull wordpress",
      "sudo docker run --name pb-wordpress -e WORDPRESS_DB_HOST=${aws_db_instance.wordpress_db.address} -e WORDPRESS_DB_USER=wordpress -e WORDPRESS_DB_PASSWORD=wordpress -d wordpress"
      ]
  }
}