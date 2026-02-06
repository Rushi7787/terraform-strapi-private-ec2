resource "aws_instance" "strapi" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = "nice"
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "strapi-private-ec2"
  }
}
