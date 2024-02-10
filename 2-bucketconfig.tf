# S3 bucket for static website.
resource "aws_s3_bucket" "www-ipgame2_bucket" {
  bucket = "www-ipgame2"

  tags = {
    Name = "www-ipgame2"
    Environment = "Dev"
    }
  force_destroy = true
  }

# Configures the S3 bucket "www-ipgame2" to host a static website with specified index and error documents.
resource "aws_s3_bucket_website_configuration" "www-ipgame2_website" {
  bucket = aws_s3_bucket.www-ipgame2_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Blocks public access to the S3 bucket "www-ipgame2" to prevent unauthorized access and enforce security.
resource "aws_s3_bucket_public_access_block" "wwww-ipgame2_bucket" {
    bucket = aws_s3_bucket.www-ipgame2_bucket.bucket
    block_public_acls = true # Prevents adding objects to buckets
    block_public_policy = true # Bucket rejects policies that allow public access
    ignore_public_acls = true # If public access is granted by an acl it will be ignored
    restrict_public_buckets = true # Only aws pricipals and authorized users can access bucket
}

# Configures server-side encryption for the S3 bucket to protect data at rest using AES256 encryption.
resource "aws_s3_bucket_server_side_encryption_configuration" "wwww-ipgame2_bucket" {
    bucket = aws_s3_bucket.www-ipgame2_bucket.bucket
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Enables versioning for the S3 bucket to secure objects from accidental deletion or overwrite.
resource "aws_s3_bucket_versioning" "www-ipgame2_bucket" {
  bucket = aws_s3_bucket.www-ipgame2_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


#  Uploads the "index.html" file to the S3 bucket
resource "aws_s3_object" "content" {
# this object cannot be uploaded until the bucket is established first
  depends_on = [
    aws_s3_bucket.www-ipgame2_bucket
  ]

  bucket = aws_s3_bucket.www-ipgame2_bucket.bucket
  key    = "index.html" # Specifices the name of the resource
  source = "./index.html" # Specifies the path to the file that is being uplaoded
  server_side_encryption = "AES256" # Specifies the path to the file that is being uplaoded
  content_type = "text/html" # Specifcy the content type as text.html
}

#  Uploads the "internationalwomen.gif" file to the S3 bucket
resource "aws_s3_object" "international_women" {
# this object cannot be uploaded until the bucket is established first
  depends_on = [
    aws_s3_bucket.www-ipgame2_bucket
  ]

  bucket = aws_s3_bucket.www-ipgame2_bucket.bucket
  key    = "internationalwomen.gif" # Specifices the name of the resource
  source = "./internationalwomen.gif" # Specifies the path to the file that is being uplaoded
  server_side_encryption = "AES256" # Specifies the path to the file that is being uplaoded
  content_type = "image/gif" # Specifcy the content type as image.gif
}
