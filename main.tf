resource "aws_vpc" "stage-vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc-stage"
  }
}

resource "aws_subnet" "publicsubnet" {
  count                   = length(var.az)
  vpc_id                  = aws_vpc.stage-vpc.id
  cidr_block              = element(var.publicsubnet, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.az, count.index)

  tags = {
    Name = "stage-public1-${count.index + 1}"
  }
}

resource "aws_subnet" "privatesubnet" {
  count      = length(var.az)
  vpc_id     = aws_vpc.stage-vpc.id
  cidr_block = element(var.privatesubnet, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "stage-private1-${count.index + 1}"
  }
}

resource "aws_subnet" "datasubnet" {
  count      = length(var.az)
  vpc_id     = aws_vpc.stage-vpc.id
  cidr_block = element(var.datasubnet, count.index)
  availability_zone = element(var.az, count.index)
  tags = {
    Name = "stage-data1-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.stage-vpc.id

  tags = {
    Name = "stage-igw"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  tags = {
    "name" = "eip-stage"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.publicsubnet[0].id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicroute"
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "privateroute"
  }
}

resource "aws_route_table" "dataroute" {
  vpc_id = aws_vpc.stage-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "dataroute"
  }
}

resource "aws_route_table_association" "public-association" {
  count          = length(var.publicsubnet)
  subnet_id      = element(aws_subnet.publicsubnet.*.id, count.index)
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "private-association" {
  count          = length(var.privatesubnet)
  subnet_id      = element(aws_subnet.privatesubnet.*.id, count.index)
  route_table_id = aws_route_table.privateroute.id
}

resource "aws_route_table_association" "data-association" {
  count          = length(var.datasubnet)
  subnet_id      = element(aws_subnet.datasubnet.*.id, count.index)
  route_table_id = aws_route_table.dataroute.id
}
