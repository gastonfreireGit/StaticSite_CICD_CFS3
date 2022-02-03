resource "aws_cloudfront_origin_access_identity" "s3_oai" {
  comment = "OAI for S3"
}