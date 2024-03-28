# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "MyVPC"  # name for vpc
  }
}

# Create public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${var.public_availability_zone}"
  map_public_ip_on_launch = true    #it is for auto-attach public IP
tags = {
    Name = "Pub-subnet"  # Subnet name
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "${var.public_subnet2_cidr}"
  availability_zone = "${var.public_availability_zone2}"
  map_public_ip_on_launch = true 

  tags = {
    Name = "Pub-subnet2"  # Subnet name
  }
}


# Create private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.private_availability_zone}"
tags = {
  Name = "Private-Subnet"  # Subnet name
  }
}

# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create route for public subnet to the Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}




# Create NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "NATGateway"  # NATGateway" name
  }
}


# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc" 
}



# Route traffic from private subnet to NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate public subnet with route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id  
}

# Create route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Pvt-RT"  # RT name
  }
}

# Create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Pub-RT"  # sPub-RT name
  }
}

# Associate private subnet with route table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}




resource "aws_autoscaling_group" "front_asg" {
  name                 = "frontend-asg"
  launch_configuration = aws_launch_configuration.frontend_lc.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.public.id]
  health_check_type    = "ELB"
  health_check_grace_period = 30
   tag {
    key                 = "Name"
    value               = "ASG-FrontEnd"
    propagate_at_launch = true
  }


depends_on = [
    aws_vpc.my_vpc,
    aws_subnet.public,
    aws_subnet.public2,
    # Add other dependencies here if needed
  ]
}
  
# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "front_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.front_asg.id
  lb_target_group_arn    = aws_lb_target_group.tg_group.arn
}

resource "aws_autoscaling_policy" "cpu_utilization_policy" {
  name                   = "cpu-utilization-policy"
  autoscaling_group_name = aws_autoscaling_group.front_asg.name  # Directly refer to the autoscaling group

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70
  }
}


