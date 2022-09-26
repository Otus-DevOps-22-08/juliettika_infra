#!/bin/bash
echo "Installing reddit app"

cd /home/ubuntu
/usr/bin/git clone -b monolith https://github.com/express42/reddit.git
cd reddit && /usr/bin/bundle install
