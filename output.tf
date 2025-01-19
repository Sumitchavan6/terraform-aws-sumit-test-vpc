output "vpc" {
    value = module.vpc.VPCID
  
}
output "publicsubent" {
    value = module.vpc.public-subnet
}
output "privatesubnet" {
    value = module.vpc.private-subnet
}