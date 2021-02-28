terraform {
  backend "s3" {}
}

provider aws {
  region = var.region
}

resource aws_vpc vpc {
  cidr_block = cidrsubnet(var.vpc_config["cidr_block"], 0, 0)

  tags = {
    Name = "${var.project["name"]}-${var.environment}-vpc"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_internet_gateway internet_gateway {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project["name"]}-${var.environment}-internet-gateway"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_default_security_group default_security_group {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project["name"]}-${var.environment}-vpc-sg"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_route_table public_route_table {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project["name"]}-${var.environment}-public-route-table"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_subnet public_subnet {
  count = length(var.availability_zones)

  cidr_block = cidrsubnet(var.vpc_config["cidr_block"], var.vpc_config["newbits"], count.index)
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public-${var.environment}-${element(var.availability_zones, count.index)}-subnet"
    Environment = var.environment
    Project = var.project["name"]
  }
}

resource aws_route_table_association public_subnet_route_association {
  count          = length(var.availability_zones)

  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource aws_main_route_table_association main_route_table {
  vpc_id = aws_vpc.vpc.id
  route_table_id = aws_route_table.public_route_table.id
}
