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

# resource "aws_sns_topic" "topic" {
#     name = "s3-event-notification-topic"
# }