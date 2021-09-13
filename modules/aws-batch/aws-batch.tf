resource "aws_batch_compute_environment" "batch-env" {
  compute_environment_name = "aws-batch-environment"

  compute_resources {
    instance_role = aws_iam_instance_profile.ecs_instance_role.arn

    instance_type = [
      "c4.large",
    ]
    allocation_strategy = "BEST_FIT"
    desired_vcpus = 1
    /* ec2_key_pair = ""
    image_id = var.image_id
    launch_template = "" */

    max_vcpus = 4
    min_vcpus = 0

    security_group_ids = [
      aws_security_group.traffic.id,
    ]

    subnets = [
      var.public_subnet_ids,
    ]

    type = "EC2"
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  state        = "ENABLED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]
}