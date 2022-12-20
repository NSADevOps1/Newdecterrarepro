# Create a VPC
resource "aws_vpc" "Dec-Vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Dec-Vpc"
  }
}

# Create public subnets
resource "aws_subnet" "Dec-pub-sub1-cidr_block" {
  vpc_id     = aws_vpc.Dec-Vpc.id
  cidr_block = var.Dec-pub-sub1-cidr_block

  tags = {
    Name = "Dec-pub-sub1"
  }
}

resource "aws_subnet" "Dec-pub-sub2-cidr_block" {
  vpc_id     = aws_vpc.Dec-Vpc.id
  cidr_block = var.Dec-pub-sub2-cidr_block

  tags = {
    Name = "Dec-pub-sub2"
  }
}

# Create private subnets
resource "aws_subnet" "Dec-priv-sub1-cidr_block" {
  vpc_id     = aws_vpc.Dec-Vpc.id
  cidr_block = var.Dec-priv-sub1-cidr_block

  tags = {
    Name = "Dec-priv-sub1"
  }
}

resource "aws_subnet" "Dec-priv-sub2-cidr_block" {
  vpc_id     = aws_vpc.Dec-Vpc.id
  cidr_block = var.Dec-priv-sub2-cidr_block

  tags = {
    Name = "Dec-priv-sub2"
  }
}

# Create public route table
resource "aws_route_table" "Dec-route-pub" {
  vpc_id = aws_vpc.Dec-Vpc.id
  route  = []

  tags = {
    Name = "Dec-route-pub"
  }
}

# Create private route table
resource "aws_route_table" "Dec-route-priv" {
  vpc_id = aws_vpc.Dec-Vpc.id
  route  = []

  tags = {
    Name = "Dec-route-priv"
  }
}

# Route table association public
resource "aws_route_table_association" "pub-sub-assc1" {
  subnet_id      = aws_subnet.Dec-pub-sub1-cidr_block.id
  route_table_id = aws_route_table.Dec-route-pub.id


}

resource "aws_route_table_association" "pub-sub-assc2" {
  subnet_id      = aws_subnet.Dec-pub-sub2-cidr_block.id
  route_table_id = aws_route_table.Dec-route-pub.id

}

# Route table association private
resource "aws_route_table_association" "priv-sub-assc1" {
  subnet_id      = aws_subnet.Dec-priv-sub1-cidr_block.id
  route_table_id = aws_route_table.Dec-route-priv.id

}

resource "aws_route_table_association" "priv-sub-assc2" {
  subnet_id      = aws_subnet.Dec-priv-sub2-cidr_block.id
  route_table_id = aws_route_table.Dec-route-priv.id

}

# Create internet gateway
resource "aws_internet_gateway" "Dec-vpc-igw" {
  vpc_id = aws_vpc.Dec-Vpc.id

  tags = {
    Name = "Dec-vpc-igw"
  }
}

# Internet Gateway and public Route table association
resource "aws_route_table_association" "igw-route-pubassc" {
  gateway_id     = aws_internet_gateway.Dec-vpc-igw.id
  route_table_id = aws_route_table.Dec-route-pub.id

}

# Create EIP
resource "aws_eip" "Dec-eip" {
  vpc = true

  tags = {
    Name = "Dec-eip"
  }
}

# Create a NAT Gateway in Public Subnet association
resource "aws_nat_gateway" "Dec-Natgw" {
  allocation_id = aws_eip.Dec-eip.id
  subnet_id     = aws_subnet.Dec-pub-sub1-cidr_block.id

}


# Create security group
resource "aws_security_group" "Dec-sec-group1" {
  description = var.aws_security_group-Dec-sec-group1
  vpc_id      = aws_vpc.Dec-Vpc.id

  ingress {
    description = "ssh access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Dec-sec-group2" {
  description = var.aws_security_group-Dec-sec-group2
  vpc_id      = aws_vpc.Dec-Vpc.id
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ... other configuration ...
resource "aws_security_group" "Dec-sec-group3" {

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Create  EC2 Instance
resource "aws_instance" "Dec-server-pub" {
  ami                         = var.aws_instance_Dec-server-pub
  instance_type               = "t2.micro"
  key_name                    = "Newsshkeypair"
  vpc_security_group_ids      = [aws_security_group.Dec-sec-group1.id]
  subnet_id                   = aws_subnet.Dec-pub-sub1-cidr_block.id
  associate_public_ip_address = true

  tags = {
    name = "Dec-server-pub"
  }
}

resource "aws_instance" "Dec-server-priv" {
  ami                         = var.aws_instance_Dec-server-priv
  instance_type               = "t2.micro"
  key_name                    = "Newsshkeypair"
  vpc_security_group_ids      = [aws_security_group.Dec-sec-group1.id]
  subnet_id                   = aws_subnet.Dec-priv-sub1-cidr_block.id
  associate_public_ip_address = true

  tags = {
    name = "Dec-server-priv"
  }
}







