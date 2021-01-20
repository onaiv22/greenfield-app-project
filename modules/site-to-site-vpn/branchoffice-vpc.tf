# create vpc representing cloud environment
resource "aws_vpc" "cloud" {
    cidr_block = "10.20.0.0/16"

    tags = {
      "Name" = "branchoffice"
    }
}

