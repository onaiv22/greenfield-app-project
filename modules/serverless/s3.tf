 resource "aws_s3_bucket" "access-logs" {
     bucket = "access-logs19122020"
     acl    = "log-delivery-write"
 }

 resource "aws_s3_bucket" "main" {
     count  = length(var.s3-bucket-names)
     bucket = element(var.s3-bucket-names, count.index)
     acl    = "private"
     force_destroy = false

     versioning {
       enabled = true
     }
     logging {
       target_bucket = aws_s3_bucket.access-logs.id
       target_prefix = "logs/"
     }

     tags = {
         Name      = "adroit"
         Automated = "yes"
     }
 }

 data "archive_file" "main" {
     type = "zip"
     source_dir = "/Users/femi.okuta/lambda-s3-bucket-clamav/lambda-s3-bucket-clamav/bin/"
     output_path = "clamav-scan.zip"
 }

 resource "aws_s3_bucket_object" "object" {
     bucket = aws_s3_bucket.main[3].id
     key    = "clamav-scanner/clamav-scanner.v1.0.0.zip"
     source = data.archive_file.main.output_path
     acl    = "bucket-owner-full-control"
     etag   = filemd5("clamav-scan.zip")
}

