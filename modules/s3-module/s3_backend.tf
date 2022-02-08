/* S3 bucket for backend
resource "aws_s3_bucket" "static-site-backend" {
  bucket = var.s3_name
  acl    = "private"
  force_destroy = true
  policy = file("templates/s3-backend-policy.json")
} */