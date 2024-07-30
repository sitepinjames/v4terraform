# create vpc
resource "aws_vpc" "Labvpc1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.Environment}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Labvpc1.id

  tags = {
    Name = "${var.Environment}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "a_z" {}

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.Subnet1_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.Environment}-PubSub1"
  }
}

# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.Subnet2_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.Environment}-PubSub2"
  }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Labvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PubRT"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.PrivAppSubnet1_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.Environment}-PrivAppSub1"
  }
}

# create private app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.PrivAppSubnet2_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.Environment}-PrivAppSub2"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.PrivDataSubnet1_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.Environment}-PrivDataSub1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.Labvpc1.id
  cidr_block              = var.PrivDataSubnet2_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false


  tags = {
    Name = "${var.Environment}-PrivDataSub2"
  }
}
