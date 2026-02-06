resource "aws_security_group" "private_sg" {
  name        = "strapi-private-sg"
  description = "Allow traffic from ALB only"
  vpc_id      = aws_vpc.main.id

  # Allow ALB to access Strapi (port 1337)
  ingress {
    description     = "Allow traffic from ALB"
    from_port       = 1337
    to_port         = 1337
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow outbound internet (via NAT)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strapi-private-sg"
  }
}
