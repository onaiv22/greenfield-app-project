 resource "aws_s3_bucket" "access-logs" {
     bucket = "access-logs19122020"
     acl    = "log-delivery-write"
     force_destroy = true
 }

 resource "aws_s3_bucket" "main" {
     count  = length(var.s3-bucket-names)
     bucket = element(var.s3-bucket-names, count.index)
     acl    = "private"
     force_destroy = true

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

 

 resource "aws_s3_bucket_object" "object" {
     bucket = aws_s3_bucket.main[3].id
     key    = "clamav-scanner/lambda.zip"
     source = "lambda.zip" 
     acl    = "bucket-owner-full-control"
     etag   = filemd5("lambda.zip")
}

