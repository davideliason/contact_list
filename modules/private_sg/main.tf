


resource "aws_security_group" "private_sg" {
  name        = var.name
  description = "Private security group for internal services"
  vpc_id      = var.vpc_id

  # Restricting access to only specific IP or other security groups
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to a private subnet or specific IP range
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id] # Only allow access from the public SG for example
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
