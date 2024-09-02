resource "aws_internet_gateway" "SimpleLB-Gw" {
  vpc_id = aws_vpc.SimpleLB-VPC.id

  tags = {
    Name = "SimpleLB-Gw"
  }
}

resource "aws_route_table" "SimpleLB-Route" {
  vpc_id = aws_vpc.SimpleLB-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SimpleLB-Gw.id
  }

  route {
    cidr_block = "10.10.0.0/16"
    gateway_id = "local"
  }
  tags = {
    Name = "TF-Routing"
  }
}

resource "aws_main_route_table_association" "RouteAndVPC" {
  vpc_id         = aws_vpc.SimpleLB-VPC.id
  route_table_id = aws_route_table.SimpleLB-Route.id
}