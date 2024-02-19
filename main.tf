terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = "us-east-1"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "aws_sample" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  user_data = <<-EOF
              curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
              chmod 700 get_helm.sh
              ./get_helm.sh

              helm repo add keycaliber https://charts.keycaliber.com/charts
              helm install my-release keycaliber/my-chart
              EOF

  tags = {
    Name = "SampleInstance"
  }
}


resource "aws_s3_bucket" "s3_sample" {
  bucket = "my-sample-bucket-${random_id.bucket_id.hex}"
  acl    = "private"
}

resource "random_id" "bucket_id" {
  byte_length = 8
}

resource "aws_iam_user" "iam_user_sample" {
  name = "sample-user"
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

output "instance_id" {
  value = aws_instance.aws_sample.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_sample.arn
}

output "iam_user_arn" {
  value = aws_iam_user.iam_user_sample.arn
}
