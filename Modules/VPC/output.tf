output "region" {
  value = var.region
}
output "Environment" {
  value = var.Environment
}
output "myvpc_id" {
  value = aws_vpc.Labvpc1.id
}
output "Pub_sub_az1" {
  value = aws_subnet.public_subnet_az1.id
}
output "Pub_sub_az2" {
  value = aws_subnet.public_subnet_az2.id
}
output "PrivAppSub_az1" {
  value = aws_subnet.private_app_subnet_az1.id
}
output "PrivAppSub_az2" {
  value = aws_subnet.private_app_subnet_az2.id
}
output "PrivDataSub_az1" {
  value = aws_subnet.private_data_subnet_az1.id
}
output "PrivDataSub_az2" {
  value = aws_subnet.private_data_subnet_az2.id
}
output "igw" {
  value = aws_internet_gateway.igw
}
output "PubSubnet_id" {
  value = aws_subnet.public_subnet_az1.id
}
