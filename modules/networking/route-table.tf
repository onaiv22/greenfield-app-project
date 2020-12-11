resource "aws_route_table" "public_route_tables" {
    vpc_id      = var.vpc_id
    count       = length(var.networks["public_subnets"])

    tags        = {
        Name    = "${element(var.networks["public_subnet_names"], count.index)}-route-table"
    }
}
resource "aws_route" "internet_access" {
    count                       = length(var.networks["public_subnets"])
    destination_cidr_block      = "0.0.0.0/0"
    route_table_id              = element(aws_route_table.public_route_tables.*.id, count.index)
    gateway_id                  = var.gw_id
}
resource "aws_route_table_association" "public" {
    count                       = length(var.networks["public_subnets"])
    subnet_id                   = element(aws_subnet.public_subnets.*.id, count.index)
    route_table_id              = element(aws_route_table.public_route_tables.*.id, count.index)

}
resource "aws_route_table" "private_route_tables" {
    vpc_id                     = var.vpc_id
    count                      = length(var.networks["private_subnets"])

    tags                       = {
        Name                   = "${element(var.networks["private_subnet_names"], count.index)}-route-table"
    }
}
resource "aws_route" "private_route" {
    count                      = length(var.networks["private_subnets"])
    nat_gateway_id             = element(aws_nat_gateway.nat_gw.*.id, count.index)
    route_table_id             = element(aws_route_table.private_route_tables.*.id, count.index)
    destination_cidr_block     = "0.0.0.0/0"
}
resource "aws_route_table_association" "private" {
    count                      = length(var.networks["private_subnets"])
    subnet_id                  = element(aws_subnet.private_subnets.*.id, count.index)
    route_table_id             = element(aws_route_table.private_route_tables.*.id, count.index)

}