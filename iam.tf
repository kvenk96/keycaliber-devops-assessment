resource "aws_iam_user" "iam_user_sample" {
  name = var.iam_user_name
}

resource "aws_iam_policy" "iam_policy_sample" {
  name        = "sample-bucket-access"
  description = "Full access to the sample S3 bucket"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action    = "s3:*",
      Resource  = [
        aws_s3_bucket.s3_sample.arn,
        "${aws_s3_bucket.s3_sample.arn}/*",
      ],
      Effect    = "Allow",
      Sid       = ""
    }]
  })
}

resource "aws_iam_user_policy_attachment" "sample" {
  user       = aws_iam_user.iam_user_sample.name
  policy_arn = aws_iam_policy.iam_policy_sample.arn
}
