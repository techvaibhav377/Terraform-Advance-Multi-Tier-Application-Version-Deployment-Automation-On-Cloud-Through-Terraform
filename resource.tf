resource "aws_instance" "front_server" {
  ami                     = "${var.front_instance_ami}"
  instance_type           = "${var.front_instance_type}"
 # count = "${var.front_instance_count}"
  subnet_id              = aws_subnet.public.id
  iam_instance_profile = aws_iam_instance_profile.front_instance_profile.name
  vpc_security_group_ids = [aws_security_group.front_sg.id]

  user_data              = <<-EOF
                            #!/bin/bash
                            sudo yum install awscli -y
                            sudo mkdir /root/vaibhav-project
                            sudo aws s3 cp "s3://vaibhav-project/" "/root/vaibhav-project/" --recursive --exclude "*" --include "*.zip"
                            sudo yum install httpd unzip -y
                            cd /root/vaibhav-project
                            sudo unzip *
                            sudo rm -rf /root/vaibhav-project/*.zip
                            sudo mv /root/vaibhav-project/* /root/vaibhav-project/index.html
                           
                            sudo mv /root/vaibhav-project/index.html /var/www/html/
                            sudo systemctl enable --now httpd
                            EOF
  
  key_name = "${var.key_name}"

tags = {
      Name = "${var.front_instance_name}"
}
}

resource "aws_iam_instance_profile" "front_instance_profile" {
  name = "ec2-s3-access-profile"
  role = aws_iam_role.s3_role.name
}


resource "aws_instance" "db_server" {
  ami                     = "${var.db_instance_ami}"
  instance_type           = "${var.db_instance_type}"
  count = "${var.front_instance_count}"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  key_name = "${var.key_name}"

tags = {
      Name = "${var.db_instance_name}"
}
}