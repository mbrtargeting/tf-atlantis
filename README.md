# Atlantis Terraform Module

Terraform Module for Atlantis environment in Gitlab and Github running in AWS ECS Fargate.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.51.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | terraform-aws-modules/atlantis/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.atlantis_gh_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.atlantis_gh_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.atlantis_gitlab_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.atlantis_gitlab_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.atlantis_web_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.atlantis_gh_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.atlantis_gh_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.atlantis_gitlab_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.atlantis_gitlab_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.atlantis_web_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_ssm_parameter.atlantis_gh_username](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.atlantis_gitlab_username](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.atlantis_repo_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.atlantis_gh_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.atlantis_gitlab_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.atlantis_web_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_secretsmanager_secret_version.atlantis_gitlab_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acc_name"></a> [acc\_name](#input\_acc\_name) | the account name | `string` | n/a | yes |
| <a name="input_atlantis_dns_name"></a> [atlantis\_dns\_name](#input\_atlantis\_dns\_name) | the DNS name for the atlantis web interface | `string` | n/a | yes |
| <a name="input_atlantis_vpc_id"></a> [atlantis\_vpc\_id](#input\_atlantis\_vpc\_id) | a valid aws\_vpc id to install components in | `string` | n/a | yes |
| <a name="input_atlantis_web_password"></a> [atlantis\_web\_password](#input\_atlantis\_web\_password) | password for the atlantis web interface | `string` | n/a | yes |
| <a name="input_atlantis_web_username"></a> [atlantis\_web\_username](#input\_atlantis\_web\_username) | username for the atlantis web interface | `string` | n/a | yes |
| <a name="input_atlantis_zone_id"></a> [atlantis\_zone\_id](#input\_atlantis\_zone\_id) | a valid Route 53 Zone ID managing the presented core\_domain | `string` | n/a | yes |
| <a name="input_exec_iam_role_policies"></a> [exec\_iam\_role\_policies](#input\_exec\_iam\_role\_policies) | map of IAM policies for the ECS task execution | `map(string)` | n/a | yes |
| <a name="input_git_server_type"></a> [git\_server\_type](#input\_git\_server\_type) | the type of git server to use. Must be either 'gitlab' or 'github'. | `string` | `"gitlab"` | no |
| <a name="input_git_username"></a> [git\_username](#input\_git\_username) | the username for the git server | `string` | `""` | no |
| <a name="input_gitlab_hostname"></a> [gitlab\_hostname](#input\_gitlab\_hostname) | base domain to be used for gitlab. Has to exist as Route53 zone in account | `string` | `"code.example.com"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key id for the log group | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | name of the log group for the ECS cluster | `string` | n/a | yes |
| <a name="input_nickname"></a> [nickname](#input\_nickname) | The organisation nickname | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | list of private subnets to deploy into | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | list of public subnets to deploy into | `list(string)` | n/a | yes |
| <a name="input_repo_list"></a> [repo\_list](#input\_repo\_list) | list of repositories to be managed by atlantis | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | the account stage-name | `string` | n/a | yes |
| <a name="input_task_iam_role_arn"></a> [task\_iam\_role\_arn](#input\_task\_iam\_role\_arn) | ARN of the IAM role for the ECS task | `string` | n/a | yes |

## Outputs

No outputs.
