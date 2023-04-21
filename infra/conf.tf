terraform {
  backend "s3" {
    bucket = "ccccccascxzc"
    key    = "infra/infra.tfstate"
    region = "eu-central-1"
  }
}