terraform {
  backend "s3" {
    bucket = "ccccccascxzc"
    key    = "service/infra.tfstate"
    region = "eu-central-1"
  }
}