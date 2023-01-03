resource "aws_security_group" "jump" {
  name        = "jump"
  description = "jump host SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "inbound ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "proxy service"
    from_port        = 3128
    to_port          = 3128
    protocol         = "tcp"
    cidr_blocks      = ["10.13.37.0/24"]
    ipv6_cidr_blocks = ["2406:da1c:c99:9100::/56"]
  }
  ingress {
    description      = "wireguard"
    from_port        = 31337
    to_port          = 31337
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "outbound ssh to internal network"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.13.37.0/24"]
    ipv6_cidr_blocks = ["2406:da1c:c99:9100::/56"]
  }
  egress {
    description      = "outbound to internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ "Name" = "jump" }, var.common_tags)
}

resource "aws_security_group" "sharedServices" {
  name        = "sharedServices"
  description = "Shared Services SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "ssh from jump host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }

  egress {
    description     = "http proxy to jump host"
    from_port       = 3128
    to_port         = 3128
    protocol        = "tcp"
    security_groups = [aws_security_group.jump.id]
  }

  tags = merge({ "Name" = "sharedServices" }, var.common_tags)
}
