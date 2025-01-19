resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
      name=var.vpc_config.name
    }
  }
resource "aws_subnet" "mysubnet" {
        for_each = var.subnet_config

    cidr_block = each.value.cidr_block
    vpc_id = aws_vpc.myvpc.id
    availability_zone = each.value.azs
    tags = {
      name=each.key
    }
}
locals {
  public_subnet={
  for key,config in var.subnet_config:key =>config if config.public
  }
   private_subnet={
  for key,config in var.subnet_config:key =>config if !config.public
  }
}
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.myvpc.id
    count = length(local.public_subnet) > 0 ? 1:0
}
  resource "aws_route_table" "main" {
    count = length(local.public_subnet)> 0 ? 1 :  0
    vpc_id = aws_vpc.myvpc.id
    route  {
      cidr_block="0.0.0.0/0"
      gateway_id= aws_internet_gateway.main[0].id
    }
    
  }
  resource "aws_route_table_association" "main" {
  for_each = local.public_subnet

  subnet_id =aws_subnet.mysubnet[each.key].id
  route_table_id =aws_route_table.main[0].id  
  }