output "instance_id" {
  value = aws_instance.aws_sample.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_sample.arn
}

output "iam_user_arn" {
  value = aws_iam_user.iam_user_sample.arn
}
