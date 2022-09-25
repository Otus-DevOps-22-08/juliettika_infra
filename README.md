# juliettika_infra
juliettika Infra repository

## Способ подключения к ```someinternalhost``` в одну команду:
```
ssh -i appuser -A appuser@51.250.14.3 ssh appuser@10.128.0.28 -tt
```

## Способ подключения к ```someinternalhost``` через команду вида ```ssh someinternalhost```:
Создать файл ~/.ssh/config со следующими параметрами:
```
Host gateway
Hostname 51.250.14.3
User appuser
IdentityFile ~/.ssh/appuser

Host someinternalhost
Hostname 10.128.0.28
User appuser
ProxyCommand ssh gateway nc %h %p
```
Подключиться к ```someinternalhost``` с помощью команды ```ssh someinternalhost```.

## Данные для подключения:
```
https://51.250.14.3.sslip.io/
bastion_IP = 51.250.14.3
someinternalhost_IP = 10.128.0.28
```

## Данные для подключения к reddit:
```
testapp_IP = 51.250.88.90
testapp_port = 9292
```

## Команда CLI для создания ВМ с metadata.yaml
```
yc compute instance create --name reddit-app-metadata --hostname reddit-app-metadata --memory=4  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=metadata.yaml
```
