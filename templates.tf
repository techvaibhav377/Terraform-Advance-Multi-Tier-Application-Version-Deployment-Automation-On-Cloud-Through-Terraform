resource "aws_launch_configuration" "frontend_lc" {
  name                   = "front_template"
  image_id               = var.front_instance_ami
  instance_type          = "${var.front_instance_type}"
  security_groups        = [aws_security_group.front_sg.id]
  key_name               = "${var.key_name}"
  iam_instance_profile = aws_iam_instance_profile.front_instance_profile.name
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
}

