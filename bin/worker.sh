#!/usr/bin/env bash

repo=$1
deploy_script=$2

git clone $repo
$deploy_script
