resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true


  tags = var.tags
}

