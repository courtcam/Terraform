terraform {
  backend "s3" {
    bucket = "tf-remote-backend-bucket-cc"
    #path = "terraform.tfstate"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-cc"
    encrypt        = true
  }
}