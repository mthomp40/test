#!/usr/bin/env bash

# shopt -s failglob
set -euo pipefail

echo "Begin: setup local environment"

ENV=master
export ENV

AWS_REGION=ap-southeast-2
export AWS_REGION

DOMAIN_NAME=test.io
export DOMAIN_NAME

APP_NAME=$(basename -s .git "$(git config --get remote.origin.url)")
export APP_NAME

if [ "$ENV" == "master" ]; then
  BRANCH_NAME="master"
else
  BRANCH_NAME="${GIT_BRANCH}"
fi
export BRANCH_NAME

export STACK_BASE="${APP_NAME}-${BRANCH_NAME}"

if [ "$BRANCH_NAME" == "prod" ]; then
  echo "Using production environment config"

  export WEB_MARKETING_URL="www.$DOMAIN_NAME"
  export WEB_ADMIN_APP_URL="admin.$DOMAIN_NAME"
  export STORAGE_URL="storage.$DOMAIN_NAME"
  export API_URL="api.$DOMAIN_NAME"
  export WEB_CUSTOMER_APP_URL="app.$DOMAIN_NAME"
else
  echo "Using non-production environment config"

  export WEB_MARKETING_URL="${STACK_BASE}-www.$DOMAIN_NAME"
  export WEB_ADMIN_APP_URL="${STACK_BASE}-admin.$DOMAIN_NAME"
  export STORAGE_URL="${STACK_BASE}-storage.$DOMAIN_NAME"
  export WEB_CUSTOMER_APP_URL="${STACK_BASE}-app.$DOMAIN_NAME"
  if [ ${DEBUG_LOCAL:-"_"} == "_" ]; then
    export API_URL="${STACK_BASE}-api.$DOMAIN_NAME"
  fi
fi

export AWS_PAGER="" # Prevents paging with less

# Export project env vars
. ./scripts/export-cfn-outputs.sh "${APP_NAME}" "${BRANCH_NAME}"

export WEB_APP_META_TITLE="Test"
export WEB_APP_META_DESCRIPTION="Test"

# Export mobile vars
# export STACK_TYPE="mobile"
# export STACK_NAME="${STACK_BASE}-${STACK_TYPE}"
# . clients/packages/mobile/scripts/setup-env-vars.sh

# Export web admin app vars
export STACK_TYPE="web-admin-app"
export STACK_NAME="${STACK_BASE}-${STACK_TYPE}"
export WORKSPACE_ENTITY_BYNAME=Workspace
export DEFAULT_WORKSPACE_ID=
# . clients/packages/web/app/scripts/setup-env-vars.sh

# Create .env file in core package folder
CORE_PACKAGE_FOLDER_PATH=clients/packages/core/
printenv | grep REACT_APP_ | sort > "${CORE_PACKAGE_FOLDER_PATH}.env"

# Output entire users env to an .env.local file accepting a folder name / path as an argument.
if [ -n "${1-}" ]; then
    env > $(pwd)/$1/.env
fi

echo "Finish: setup local environment"
