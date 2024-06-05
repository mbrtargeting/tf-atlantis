variable "nickname" {
  description = "The organisation nickname"
  type        = string
}

variable "stage" {
  description = "the account stage-name"
  type        = string
}

variable "acc_name" {
  description = "the account name"
  type        = string
}

variable "atlantis_vpc_id" {
  type        = string
  description = "a valid aws_vpc id to install components in"

  validation {
    condition     = can(regex("^vpc-[[:xdigit:]]{8,17}$", var.atlantis_vpc_id))
    error_message = "Must be a valid AWS VPC ID."
  }
}

variable "gitlab_hostname" {
  type        = string
  description = "base domain to be used for gitlab. Has to exist as Route53 zone in account"
  default     = "code.example.com"
}

variable "atlantis_zone_id" {
  type        = string
  description = "a valid Route 53 Zone ID managing the presented core_domain"
}

variable "atlantis_dns_name" {
  type        = string
  description = "the DNS name for the atlantis web interface"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "list of public subnets to deploy into"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "list of private subnets to deploy into"
}

variable "repo_list" {
  type        = list(string)
  description = "list of repositories to be managed by atlantis"
}

variable "atlantis_web_username" {
  type        = string
  description = "username for the atlantis web interface"
}

variable "atlantis_web_password" {
  type        = string
  description = "password for the atlantis web interface"
}


variable "kms_key_id" {
  type        = string
  description = "KMS key id for the log group"
}

variable "log_group_name" {
  type        = string
  description = "name of the log group for the ECS cluster"
}

variable "task_iam_role_arn" {
  type        = string
  description = "ARN of the IAM role for the ECS task"
}

variable "exec_iam_role_policies" {
  type        = map(string)
  description = "map of IAM policies for the ECS task execution"
}

variable "git_server_type" {
  type        = string
  description = "the type of git server to use. Must be either 'gitlab' or 'github'."
  default     = "gitlab"

  validation {
    condition     = can(regex("^(gitlab|github)$", var.git_server_type))
    error_message = "Must be either 'gitlab' or 'github'."
  }
}

variable "git_username" {
  description = "the username for the git server"
  type        = string
  default     = ""
}

variable "autoscaling_max_capacity" {
  description = "maximum number of instances in the autoscaling group"
  type        = number
  default     = 4
}

variable "memory" {
  description = "memory for the ECS task"
  type        = number
  default     = 2048
}

variable "cpu" {
  description = "cpu for the ECS task"
  type        = number
  default     = 512
}

variable "enable_autoscaling" {
  description = "enable autoscaling for the ECS service"
  type        = bool
  default     = true
}

