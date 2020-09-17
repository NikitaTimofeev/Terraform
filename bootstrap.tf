variable "infrastructure_version" {
  default = "2"
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "tymofeiev"
    region  = "us-east-1"
    key     = "v2"
  }
}
