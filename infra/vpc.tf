module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "project"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", ]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", ]
   
   private_subnet_tags = {
    Role = "private"
  }
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24",]

   public_subnet_tags = {
    Role = "public"
  }


  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
