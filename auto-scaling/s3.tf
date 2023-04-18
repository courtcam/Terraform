# Create an s3 buckets used for remote backend 
resource "aws_s3_bucket" "my-tf-bucket-ccampbell" {
  bucket        = var.s3_bucket_name
  force_destroy = true #when destory bucket, if empty it will forse it to delete 

  tags = {
    Name        = var.s3_bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "tf-bucket-acl" {
  bucket = aws_s3_bucket.my-tf-bucket-ccampbell.id
  acl    = "private"
}


#Block Public Access to my s3 bucket 
resource "aws_s3_bucket_public_access_block" "my-bucket-public-block" {
  bucket = aws_s3_bucket.my-tf-bucket-ccampbell.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}





resource "aws_dynamodb_table" "my-tf-lock-table" {
  name         = var.dynamodb-table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.dynamodb-hash-key

  attribute {
    name = var.dynamodb-hash-key
    type = "S"
  }
}