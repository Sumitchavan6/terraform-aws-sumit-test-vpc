variable "vpc_config" {
    description = "To get value from user of cidr block"
    type = object({
      cidr_block =string
      name=string 
      public=optional(bool, false)
    })
}
variable "subnet_config" {
    description = "Get the cidr block and az for the subne"
    type = map(object({
      cidr_block = string
      azs=string
      public=optional(bool, false)
    }))
  
}