#!/bin/bash
yc compute instance create --name reddit-full --hostname reddit-full --memory=4 --create-boot-disk image-id=fd8imv4vf0kk1eu87e5a,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --ssh-key appuser.pub
