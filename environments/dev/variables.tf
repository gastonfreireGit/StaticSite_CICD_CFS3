######
# S3 Bucket name
######
variable "s3_name" {}

######
# Common tags
######
variable "createdby" {}
variable "project" {}

######
# GitHub Branch name
######
variable "gh-branch" {}

######
# CodePipeline
######
variable "cp_name" {}
variable "iam_name" {}

######
# CloudFront
######
variable "cf_comment" {}