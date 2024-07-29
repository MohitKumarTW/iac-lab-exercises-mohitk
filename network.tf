resource "aws_vpc" "network" {
    cidr_block = var.vpc_cidr
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    instance_tenancy = "default"
    tags = {
    Name = var.prefix
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet1_cidr
  availability_zone = var.availability-zone1
  tags = {
    Name = format("%s-public-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet2_cidr
  availability_zone = var.availability-zone1
  tags = {
    Name = format("%s-private-subnet-2", var.prefix)
  }
}

resource "aws_subnet" "protected1" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet3_cidr
  availability_zone = var.availability-zone1
  tags = {
    Name = format("%s-protected-subnet-3", var.prefix)
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet4_cidr
  availability_zone = var.availability-zone2
  tags = {
    Name = format("%s-public-subnet-4", var.prefix)
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet5_cidr
  availability_zone = var.availability-zone2
  tags = {
    Name = format("%s-private-subnet-5", var.prefix)
  }
}

resource "aws_subnet" "protected2" {
  vpc_id     = aws_vpc.network.id
  cidr_block = var.subnet6_cidr
  availability_zone = var.availability-zone2
  tags = {
    Name = format("%s-protected-subnet-6", var.prefix)
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.private1.id
  tags = {
    Name = "AWSNAT"
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "pvt_route_table"
  }
}

resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.privateroute.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.privateroute.id
}