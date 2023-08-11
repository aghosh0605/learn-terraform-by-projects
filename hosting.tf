provider "aws" {
  profile = "default"
  region = "ap-south-1"  # Change to your desired region
}

#Create Bucket
resource "aws_s3_bucket" "static_website" {
  bucket = "route53.safeinfo.in" #Any name of the bucket
}

#Module to host websites using the created bucket
resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website.id
  
   index_document {
    suffix = "index.html"
  }

#   error_document {
#     key = "error.html"
#   }
}

#Bucket ACL Configuration
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.static_website.id
  acl    = "public-read"
}
  
#Upload the files
resource "aws_s3_object" "s3_objects" {
  bucket = aws_s3_bucket.static_website.id
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

#AWS Bucket Policy Configuration in JSON  
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.static_website.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["665123895031"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.static_website.arn,
      "${aws_s3_bucket.static_website.arn}/*",
    ]
  }
}