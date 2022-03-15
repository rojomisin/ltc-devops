terraform {
  required_providers {
    aws = "~> 4"
  }
}

variable "suffix" {
  default = ""
}
locals {
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "prod-ci-policy-doc" {
  statement {
    principals {
      identifiers = [local.account_id]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "prod-ci-role" {
  name               = "prod-ci-role${var.suffix}"
  assume_role_policy = data.aws_iam_policy_document.prod-ci-policy-doc.json
}

resource "aws_iam_group" "prod-ci-group" {
  name = "prod-ci-group${var.suffix}"
}

resource "aws_iam_user" "prod-ci-user" {
  name = "user${var.suffix}"
}

resource "aws_iam_group_membership" "prod-ci-group-membership" {
  name = "prod-ci-group-membership"
  users = [
    aws_iam_user.prod-ci-user.name,
  ]
  group = aws_iam_group.prod-ci-group.name
}

