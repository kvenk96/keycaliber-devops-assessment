resource "aws_s3_bucket" "s3_sample" {
  bucket = "${var.bucket_name_prefix}-${random_id.bucket_id.hex}"
  acl    = "private"
}

resource "random_id" "bucket_id" {
  byte_length = 8
}
