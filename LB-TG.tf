# Create a load balancer
resource "aws_lb" "alb" {
  name               = "front-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.front_sg.id,aws_security_group.front_sg.id]
  subnets            = [aws_subnet.public.id ,aws_subnet.public2.id,] 

  enable_deletion_protection = false
}

# Create a target group
resource "aws_lb_target_group" "tg_group" {
  name        = "frontend-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

# Attach the instance to target group and attache it to the load balancer
resource "aws_lb_target_group_attachment" "frontend_attachment" {
  target_group_arn = aws_lb_target_group.tg_group.arn
  target_id        = aws_instance.front_server.id
}




