#!/usr/bin/env bash

#==================================================================
# TerraformでASGを構築
#
# @global xxx
# @parameter $1 xxx
# @return 1 エラー
#==================================================================

# tfenvインストール
git clone https://github.com/tfutils/tfenv.git .tfenv
PATH=~/.tfenv/bin:$PATH
tfenv -v
tfenv list-remote
tfenv install 0.11.8

# インフラ定義DL
git clone git@github.com:r-ymgc/terraform.git ~/terraform

# Terraform実行
cd ~/terraform
terraform plan -var-file=./tfvars/${ENV}.tfvars
