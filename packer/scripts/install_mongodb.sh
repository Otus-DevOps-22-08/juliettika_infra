#!/bin/bash
apt update
sleep 30s
apt-get install apt-transport-https ca-certificates git -y
if ! type "git" > /dev/null;
then
  echo 'Error: git is not installed. Script has not been completed.'
else
  wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
  apt-get update
  apt-get install -y mongodb-org
  if ! type "mongod" > /dev/null;
  then
    echo 'Error: mongod is not installed. Script has not been completed.'
  else
    systemctl start mongod
    systemctl enable mongod
    systemctl status mongod
  fi
fi
