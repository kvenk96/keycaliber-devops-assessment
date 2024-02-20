variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type of the AWS EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name to ensure uniqueness"
  type        = string
  default     = "sample-bucket"
}

variable "iam_user_name" {
  description = "The name of the IAM user to be created"
  type        = string
  default     = "sample.dev"
}
