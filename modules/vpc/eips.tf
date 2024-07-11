resource "aws_eip" "tcc_eip" {
  count = length(var.private_subnet_cidrs)
  # count = var.tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number

  tags = {
    Name = "${var.vpc_name}-tcc_eip-${count.index + 1}"
  }
  depends_on = [aws_internet_gateway.tcc_igw]
}