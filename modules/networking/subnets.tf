resource "aws_subnet" "public_subnet" {
    count             = length(var.networks["public_subnets"])
    availability_zone = element(var.networks["zones"], count.index)
    cidr_block        = element(var.networks["public_subnets"], count.index)
    vpc_id            = var.vpc_id
    
    tags = {
      "Name" = "public_subnets-${count.index}"
    }
}
