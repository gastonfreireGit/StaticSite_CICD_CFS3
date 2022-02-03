# creation of codepipeline
resource "aws_codepipeline" "codepipeline" {
  name     = "cp-staticsite-gf"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      region           = "us-east-1"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      namespace        = "SourceVariables"

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.codepipeline.arn
        FullRepositoryId     = "gastonfreire3XM/StaticSite_CI-CD-FedeCor"
        BranchName           = "staticsite-branch"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      region          = "us-east-1"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["SourceArtifact"]
      namespace       = "DeployVariables"
      version         = "1"

      configuration = {
        Extract    = "true"
        BucketName = "static-site-gf"
      }
    }
  }
}

# connection codepipeline
resource "aws_codestarconnections_connection" "codepipeline" {
  name          = "connectionout-gf"
  provider_type = "GitHub"
}

# IAM policy
resource "aws_iam_role" "codepipeline_role" {
  name = "role-staticsite-gf"
  
  assume_role_policy = templatefile("templates/iam-assume-policy.json", { aws_codepipeline = "cp-staticsite-gf" })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.codepipeline_role.id

  policy = templatefile("templates/iam-policy.json", { aws_codepipeline = "cp-staticsite-gf" })

}