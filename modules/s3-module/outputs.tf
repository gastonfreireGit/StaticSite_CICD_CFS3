output "staticsite_url" {
  value = aws_s3_bucket.static-site-cicd.website_endpoint
}

output "s3_origin" {
  value = var.s3_name
}