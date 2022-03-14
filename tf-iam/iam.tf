terraform {
  required_providers {
    aws = "~> 4"
  }
}

variable "suffix" {
  default = ""
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role" "prod-ci-role" {
  name               = "prod-ci-role${var.suffix}"
  assume_role_policy = data.aws_iam_policy_document.worker.json
  #  permissions_boundary = "arn:aws:iam::${account_id}:policy/My-Boundary"
}

resource "aws_iam_policy" "prod-ci-policy" {
  name = "prod-ci-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "prod-ci-group" {

  name = "prod-ci-group"
}

resource "aws_iam_user" "prod-ci-user" {
  name = "user-${var.suffix}"
}

resource "aws_iam_role" "worker-role" {
  assume_role_policy = data.aws_iam_policy_document.worker.json
}

data "aws_iam_policy_document" "worker" {
  statement {
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}