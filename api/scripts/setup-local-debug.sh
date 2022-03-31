#!/usr/bin/env bash

echo "Begin: setup project debug locally"

ENV=master
export ENV

export CLOUDWATCH_LOG_RETENTION_DAYS=14

AWS_REGION=ap-southeast-2
export AWS_REGION

DOMAIN_NAME=test.io
export DOMAIN_NAME
APP_NAME=$(basename -s .git "$(git config --get remote.origin.url)")
export APP_NAME

export AWS_PROFILE="${APP_NAME}"

if [ "$ENV" == "master" ]; then
  BRANCH_NAME="master"
else
  BRANCH_NAME="${BITBUCKET_BRANCH}"
fi
export BRANCH_NAME

export STACK_TYPE="api"
export STACK_BASE="${APP_NAME}-${BRANCH_NAME}"
export STACK_NAME="${STACK_BASE}-${STACK_TYPE}"
export API_URL="localhost:4000/${BRANCH_NAME}"
export SLS_DEBUG=*
export DEBUG_LOCAL=true
export MAINTENANCE_MODE=false

# Required for XRAY tracing to work locally
export AWS_XRAY_CONTEXT_MISSING=LOG_ERROR
export _X_AMZN_TRACE_ID=debug
export DISABLE_XRAY_TRACING=1

echo "Finish: setup project debug locally"
