module "atlantis" {
  source = "../tf-atlantis"

  nickname = "org-name"
  acc_name = "root"
  stage    = "prod"

  git_server_type = "github"
  git_username    = "github-username"
  repo_list       = ["*"]

  atlantis_vpc_id    = "vpc-id"
  private_subnet_ids = ["subnet-private-1", "subnet-private-2"]
  public_subnet_ids  = ["subnet-public-1", "subnet-public-2"]
  atlantis_zone_id   = "ZONE_ID"

  atlantis_dns_name     = "atlantis.example.com"
  atlantis_web_password = "password"
  atlantis_web_username = "atlantis-user"

  kms_key_id     = "arn:aws:kms:eu-central-1:123456789:key/17abda15-2a4f-4027-8d07-36454554"
  log_group_name = "/atlantis/runner/cd/tasks"

  #Task exec role for the ECS task
  exec_iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  #ECS Task role ARN for the ECS task
  task_iam_role_arn = aws_iam_role.atlantis_runner.arn

  depends_on = [
    aws_iam_role.atlantis_runner,
  ]
}
