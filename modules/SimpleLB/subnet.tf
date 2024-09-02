resource "aws_subnet" "SimpleLB-Subnets" {
  for_each                = var.Subnet
  vpc_id                  = aws_vpc.SimpleLB-VPC.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.region
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = each.value.name
  }
}
