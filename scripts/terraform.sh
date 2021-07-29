#!/usr/bin/env bash

#==================================================================
# TerraformでASGを構築
#
# @global xxx
# @parameter $1 Terraformサブコマンド apply|plan etc...
# @parameter $2 環境名 dev|fut
# @return 1 エラー
#==================================================================
terraform_cmd=$1
env=$2

# tfenvインストール
if [[ ! -e .tfenv ]]; then
  git clone https://github.com/tfutils/tfenv.git .tfenv
  export PATH=/home/circleci/project/.tfenv/bin:${PATH}
  tfenv -v
  tfenv list-remote
  tfenv install 0.11.8
  tfenv use 0.11.8
fi

# インフラ定義DL
if [ ! -e terraform ]; then
  git clone git@github.com:r-ymgc/terraform.git terraform
fi

# Terraform実行
cd terraform/web_deploy
if [[ "${terraform_cmd}" == "apply" ]]; then
  terraform plan -var-file=../${env}.tfvars -out=./app.plan
  terraform apply "./app.plan"
elif [[ "${terraform_cmd}" == "init" ]]; then
  terraform init -verify-plugins=false
else
  terraform plan -var-file=../${env}.tfvars
fi
