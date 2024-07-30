locals {
  environment_variables = [
    {
      name  = "ATLANTIS_REPO_ALLOWLIST"
      value = aws_ssm_parameter.atlantis_repo_list.value
    },
    {
      name  = "ATLANTIS_WEB_BASIC_AUTH"
      value = "true"
    },
    {
      name  = "ATLANTIS_WEBSOCKET_CHECK_ORIGIN"
      value = "true"
    },
    {
      name  = "ATLANTIS_WEB_USERNAME"
      value = var.atlantis_web_username
    },
    {
      name  = "ATLANTIS_WEB_PASSWORD"
      value = aws_secretsmanager_secret_version.atlantis_web_password.secret_string
    },
    {
      name  = "ATLANTIS_REPO_CONFIG_JSON"
      value = jsonencode(yamldecode(file("${path.module}/server-atlantis.yaml"))),
    },
    {
      name  = "TF_HTTP_LOCK_METHOD"
      value = "POST"
    },
    {
      name  = "TF_HTTP_UNLOCK_METHOD"
      value = "DELETE"
    },
    {
      name  = "TF_HTTP_USERNAME"
      value = var.atlantis_web_username
    },
    {
      name = "TF_HTTP_PASSWORD"
      value = try(aws_secretsmanager_secret_version.atlantis_gh_token[0].secret_string,
      aws_secretsmanager_secret_version.atlantis_gitlab_token[0].secret_string)
    },
    {
      name  = "TF_HTTP_RETRY_WAIT_MIN"
      value = "5"
    },
    {
      name  = "ATLANTIS_GITLAB_HOSTNAME"
      value = var.gitlab_hostname
    },
    {
      name  = "ATLANTIS_GITLAB_USER"
      value = try(aws_ssm_parameter.atlantis_gitlab_username[0].value, null)
    },
    {
      name  = "ATLANTIS_GH_USER"
      value = try(aws_ssm_parameter.atlantis_gh_username[0].value, null)
    },
  ]

  secrets = [
    {
      name      = "ATLANTIS_GITLAB_TOKEN"
      valueFrom = try(aws_secretsmanager_secret.atlantis_gitlab_token[0].id, "default")
    },
    {
      name      = "ATLANTIS_GITLAB_WEBHOOK_SECRET"
      valueFrom = try(aws_secretsmanager_secret.atlantis_gitlab_secret[0].id, "default")
    },
    {
      name      = "ATLANTIS_GH_TOKEN"
      valueFrom = try(aws_secretsmanager_secret.atlantis_gh_token[0].id, "default")
    },
    {
      name      = "ATLANTIS_GH_WEBHOOK_SECRET"
      valueFrom = try(aws_secretsmanager_secret.atlantis_gh_secret[0].id, "default")
    },
  ]
}

module "atlantis" {
  source = "terraform-aws-modules/atlantis/aws"

  name = "atlantis"

  # ECS Container Definition
  atlantis = {
    cpu         = 512
    memory      = 2048
    environment = local.environment_variables
    secrets     = local.secrets
  }

  # ECS Cluster
  cluster = {
    cloudwatch_log_group_retention_in_days = 14
    cloudwatch_log_group_kms_key_id        = var.kms_key_id
    create_cloudwatch_log_group            = false
    configuration = {
      execute_command_configuration = {
        logging = "OVERRIDE"
        log_configuration = {
          cloud_watch_log_group_name = var.log_group_name
        }
      }
    }
  }

  # ECS Service
  service = {
    cpu                      = var.cpu
    memory                   = var.memory
    enable_autoscaling       = var.enable_autoscaling
    autoscaling_max_capacity = var.autoscaling_max_capacity
    task_exec_secret_arns = [
      try(aws_secretsmanager_secret.atlantis_gitlab_token[0].arn, aws_secretsmanager_secret.atlantis_gh_token[0].arn),
      try(aws_secretsmanager_secret.atlantis_gitlab_secret[0].arn, aws_secretsmanager_secret.atlantis_gh_secret[0].arn),
    ]
    task_exec_ssm_param_arns = [
      try(aws_ssm_parameter.atlantis_gitlab_username[0].arn, aws_ssm_parameter.atlantis_gh_username[0].arn),
    ]

    # Provide Atlantis permission necessary to create/destroy resources
    task_exec_iam_role_name = "AtlantisElevatedCdRunnerExec"
    #task_exec_iam_role_policies = var.exec_iam_role_policies
    task_exec_iam_role_policy_statements = var.exec_iam_role_policies

    create_tasks_iam_role = false
    tasks_iam_role_arn    = var.task_iam_role_arn


    runtime_platform = {
      cpu_architecture = "ARM64"
      operating_system = "LINUX"
    }
    assign_public_ip = false
  }
  service_subnets = data.aws_subnets.private.ids
  vpc_id          = var.atlantis_vpc_id

  # ALB
  alb_subnets             = data.aws_subnets.public.ids
  certificate_domain_name = var.atlantis_dns_name
  route53_zone_id         = var.atlantis_zone_id
  alb = {
    enable_deletion_protection = false
  }

  # EFS
  enable_efs = true
  efs = {
    mount_targets = {
      "eu-west-1a" = {
        subnet_id = data.aws_subnets.private.ids[0]
      }
      "eu-west-1b" = {
        subnet_id = data.aws_subnets.private.ids[1]
      }
      "eu-west-1c" = {
        subnet_id = data.aws_subnets.private.ids[2]
      }
    }
  }

}

