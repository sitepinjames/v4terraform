resource "aws_security_group" "websecgrp" {
  name        = "${var.Environment}-websecgrp"
  description = "Allow frontend traffic"
  vpc_id      = var.myvpc_id

  ingress {
    description = "Front end traffic "
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Front end traffic nonsec "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "For developper"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.DeveloperCidr}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name        = "FrontEndSecgrop"
    Environment = "${var.Environment}"
  }
}
