resource "aws_security_group" "front_sg" {
  name        = "front_sg"
  vpc_id      = aws_vpc.my_vpc.id
  description = "My security group for Front instance"

  ingress {          #for inbound
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {          #for inbound
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {          #for inbound
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {           #for outbound
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #for all type tcp/udp
    cidr_blocks = ["0.0.0.0/0"]  
  }
}


resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  vpc_id      = aws_vpc.my_vpc.id
  description = "My security group for DB instance"

  ingress {          #for inbound
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {          #for inbound
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  egress {           #for outbound
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #for all type tcp/udp
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

  