# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "vaibhav-project"
  
  tags = {
    Name = "vaibhav-project"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Step 2: Upload the HTML Zip File to S3 Bucket
resource "aws_s3_object" "html_zip" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "html.zip"  # Name of the zip file in S3 bucket
  source = "html.zip"  # Path to the zip file in your present working directory
  acl    = "private"   # Adjust the ACL as per your requirement
}



# Create IAM role for EC2 instances
resource "aws_iam_role" "s3_role" {
  name = "s3-role"
  
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
  
  # Attach an inline policy granting full access to S3
  inline_policy {
    name = "s3-full-access"
  
    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "s3:*",
          "Resource": "*"
        }
      ]
    })
  }
}


