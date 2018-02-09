#=================================================================#
#                          S3 Demo
#=================================================================#

resource "aws_s3_bucket" "public" {
  bucket        = "inspec-testing-public-${terraform.env}.chef.io"
  acl           = "public-read"
}

output "s3_bucket_public_name" {
  value = "${aws_s3_bucket.public.id}"
}

output "s3_bucket_public_region" {
  value = "${aws_s3_bucket.public.region}"
}

resource "aws_s3_bucket" "private" {
  bucket        = "inspec-testing-private-${terraform.env}.chef.io"
  acl           = "private"
}

output "s3_bucket_private_name" {
  value = "${aws_s3_bucket.private.id}"
}
