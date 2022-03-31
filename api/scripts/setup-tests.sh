#!/usr/bin/env bash

echo "Begin: setup Tests"

. ./scripts/setup-local-debug.sh

NODE_MODULES_BIN=$(pwd)/node_modules/.bin

# Output entire users env to a .env file
env > .env.test

# Delete generated files from serverless / JEST
$NODE_MODULES_BIN/rimraf \
        ".build" \
        ".serverless" \
        "coverage"

echo "Finish: setup Tests"