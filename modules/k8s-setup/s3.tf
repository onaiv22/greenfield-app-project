 resource "aws_s3_bucket" "k8s-components" {
     bucket = var.k8s-bucket-name
     acl    = "private"
     force_destroy = false

     versioning {
       enabled = true
     }

     tags = {
         Name      = "automated"
         Automated = "yes"
     }
 }

resource "aws_s3_bucket" "helm-components" {
     bucket = var.helm-bucket-name
     acl    = "private"
     force_destroy = false

     versioning {
       enabled = true
     }

     tags = {
         Name      = "automated"
         Automated = "yes"
     }
 }

 resource "aws_s3_bucket_object" "object" {
     bucket = aws_s3_bucket.helm-components.bucket
     key = "charts/index.yaml"
     content = file("${path.module}/index.yaml")
 }
 