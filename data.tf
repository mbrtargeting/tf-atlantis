
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.atlantis_vpc_id]
  }
  tags = {
    Zone = "Private"
  }
}

data "aws_subnets" "public" {

  filter {
    name   = "vpc-id"
    values = [var.atlantis_vpc_id]
  }
  tags = {
    Zone = "Public"
  }
}
