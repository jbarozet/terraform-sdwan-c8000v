
# SUBNETS

resource "aws_subnet" "transport" {
  vpc_id            = aws_vpc.instance.id
  cidr_block        = var.subnet_transport_prefix
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name}-subnet-transport"
  }
}

resource "aws_subnet" "service" {
  vpc_id            = aws_vpc.instance.id
  cidr_block        = var.subnet_service_prefix
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.name}-subnet-service"
  }
}

# GATEWAY

resource "aws_internet_gateway" "instance" {
  vpc_id = aws_vpc.instance.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# ROUTE TABLE

resource "aws_route_table" "network_transport" {
  vpc_id = aws_vpc.instance.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.instance.id
  }

  tags = {
    Name = "${var.name}-transport"
  }
}

#  ROUTE TABLE ASSOCIATION

resource "aws_route_table_association" "network_transport" {
  subnet_id      = aws_subnet.transport.id
  route_table_id = aws_route_table.network_transport.id
}
