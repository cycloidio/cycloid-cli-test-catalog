locals {
  prefix = "${var.customer}-${var.project}-${var.env}-${var.component}"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-vpc"
    role = "vpc"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-ig"
    role = "internet_gateway"
  })
}


# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_public_subnet
  map_public_ip_on_launch = true

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-public-subnet"
    role = "public_subnet"
    Tier = "Public"
  })
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_private_subnet
  map_public_ip_on_launch = false

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-private-subnet"
    role = "private_subnet"
    Tier = "Private"
  })
}


# Route table which uses our internet gateway to access the internet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-public-rt"
    role = "public_route_table"
  })
}

# Associate route table with the subnet to make our subnet public
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Allocate an IP address for our NAT gateway
resource "aws_eip" "eip_nat_gateway" {
  count = var.nat_gateway ? 1 : 0

  domain = "vpc"

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-eip"
    role = "eip_nat_gateway"
  })
}

# Create a NAT gateway and allocate our EIP
resource "aws_nat_gateway" "nat_gateway" {
  count = var.nat_gateway ? 1 : 0

  allocation_id = aws_eip.eip_nat_gateway[0].id
  subnet_id     = aws_subnet.public_subnet.id

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-nat-gw"
    role = "nat_gateway"
  })
}

# Route table which uses our NAT gateway to access the internet
resource "aws_route_table" "private_route_table" {
  count = var.nat_gateway ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
  }

  tags = merge(local.merged_tags, {
    Name = "${var.prefix}-private-rt"
    role = "private_route_table"
  })
}

# Associate private route table with the private subnet to make NAT gateway reachable
resource "aws_route_table_association" "private_route_table_association" {
  count = var.nat_gateway ? 1 : 0

  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table[0].id
}
