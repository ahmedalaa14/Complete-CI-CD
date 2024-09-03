resource "aws_s3_bucket" "terraform_state" {
  bucket = "team6-remote-statefile"
  lifecycle {
    # prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enable" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "team6-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

 terraform {
     backend "s3" {
         bucket         = "team6-remote-statefile"
         key            = "terraform.tfstate"
         region         = "eu-north-1"
         dynamodb_table = "team6-locks"
         encrypt        = true
     }
 }