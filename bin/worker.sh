#!/usr/bin/env bash

name="$1"
repo="$2"
deploy_script="$3"
branch=$4 || "master"
destination_folder="/tmp/$name"


if [ -d $destination_folder ]; then
  cd $destination_folder
  git pull
else
  git clone $repo $destination_folder
fi

cd $destination_folder
$deploy_script
