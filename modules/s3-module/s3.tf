# S3 bucket for website
resource "aws_s3_bucket" "static-site-cicd" {
  bucket = var.s3_name
  acl    = "private"
  force_destroy = true
  #policy = templatefile("templates/s3-policy.json", {bucket = "staticsite-dev-gf"})
  #policy = file("templates/s3-policy.json")

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}