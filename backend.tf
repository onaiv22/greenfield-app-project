terraform {
  backend "s3" {
    bucket         = "terraform-state-greenfield-project"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "TerraformStateLocks"
  }
}
