###################################################################################
# create assume role policy for ecs
###################################################################################

data "aws_iam_policy_document" "ecs_instance_policy" {
    statement {
        actions = ["sts:AssumeRole",]

        principals {
            type    = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

###################################################################################
# create iam role for ecs instances
###################################################################################
resource "aws_iam_role" "ecs_instance_role" {
    name                  = "ecs_instance_role"
    assume_role_policy    = data.aws_iam_policy_document.ecs_instance_policy.json
    path                  = "/"
    force_detach_policies = true
}

###################################################################################
# attach role to policy for ecs
###################################################################################
resource "aws_iam_role_policy_attachment" "ecs_instance_role" {
    role       = aws_iam_role.ecs_instance_role.name 
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

###################################################################################
# create ecs instance profile
###################################################################################
resource "aws_iam_instance_profile" "ecs_instance_role" {
    name = "ecs_instance_role"
    role = aws_iam_role.ecs_instance_role.name
}


###################################################################################
# create assume role policy for batch service
###################################################################################
data "aws_iam_policy_document" "batch_instance_policy" {
    statement {
        actions = ["sts:AssumeRole",]

        principals {
            type    = "Service"
            identifiers = ["batch.amazonaws.com"]
        }
    }
}

###################################################################################
# create iam role for batch service
###################################################################################

resource "aws_iam_role" "aws_batch_service_role" {
    name                  = "aws_batch_service_role"
    assume_role_policy    = data.aws_iam_policy_document.batch_instance_policy.json
    path                  = "/"
    force_detach_policies = true
}

###################################################################################
# attach policy to batch service role
###################################################################################
resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}


