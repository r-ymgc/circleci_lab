#!/usr/bin/env bash

#==================================================================
# TerraformでASGを構築
#
# @global xxx
# @parameter $1 Terraformサブコマンド apply | plan etc...
# @return 1 エラー
#==================================================================

# tfenvインストール
git clone https://github.com/tfutils/tfenv.git .tfenv
export PATH=/home/circleci/project/.tfenv/bin:$PATH
tfenv -v
tfenv list-remote
tfenv install 0.11.8

# インフラ定義DL
git clone git@github.com:r-ymgc/terraform.git ~/terraform

# Terraform実行
cd ~/terraform
terraform $1 -var-file=./tfvars/${ENV}.tfvars
