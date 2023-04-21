data "aws_vpc" "project" {
     tags = {
    Name = "project"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.project.id
    tags = {
    Name = "public"
  }

}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.project.id
      tags = {
    Name = "private"
  }

}
