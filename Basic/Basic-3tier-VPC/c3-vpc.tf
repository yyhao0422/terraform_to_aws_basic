#Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"

  azs                 = ["us-east-1a" , "us-east-1b"]
  private_subnets     = ["10.0.1.0/24","10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24","10.0.102.0/24"]

  # Database Subnet
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets    = ["10.0.151.0/24","10.0.152.0/24"]  


  # NAT gateway - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true



  #VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Name = "public-subnets"
    
  }

  private_subnet_tags = {
    Name = "private-subnet"
  }

  database_subnet_tags = {
    Name = "database-subnet"
  }

  tags = {
    Owner = "yyhao"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }


}