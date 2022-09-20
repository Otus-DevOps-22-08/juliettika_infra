# juliettika_infra
juliettika Infra repository


## Способ подключения к ```someinternalhost``` в одну команду:
```
ssh -i appuser -A appuser@<публичный ip bastion> ssh appuser@<внутренний ip someinternalhost> -tt
```

## Способ подключения к ```someinternalhost``` через команду вида ```ssh someinternalhost```:
1. Создать файл ~/.ssh/config со следующими параметрами:
```
Host gateway
Hostname <публичный ip bastion>
User appuser
IdentityFile ~/.ssh/appuser

Host someinternalhost
Hostname <внутренний ip someinternalhost>
User appuser
ProxyCommand ssh gateway nc %h %p
```
2. Подключиться к ```someinternalhost``` с помощью команды ```ssh someinternalhost```

##Данные для подключения:
```
bastion_IP = 51.250.14.3
someinternalhost_IP = 10.128.0.28
```