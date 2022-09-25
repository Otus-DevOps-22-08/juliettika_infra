#!/bin/bash
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
if ! [ -x "$(command -v ruby)" ]; then
  echo 'Error: ruby is not installed.' >&2
else
  echo 'ruby successfully installed'
fi
if ! [ -x "$(command -v bundler)" ]; then
  echo 'Error: bundler is not installed.' >&2
else
  echo 'bundler successfully installed'
fi
