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

## Packer
1. Создан шаблон reddit-base (ruby + mongodb) ```packer/ubuntu16.json``` и ```packer/variables.json.example```, скопированы скрипты ```packer/scripts/install_ruby.sh``` и ```packer/scripts/install_mongodb.sh```
2. Команда для создания образа:
    ```
    packer build -var-file="variables.json" ubuntu16.json
    ```
    Вручную установлен reddit app. Созданная ВМ ```http://84.201.130.239:9292/```
3. Создан шаблон reddit-full ```packer/immutable.json``` со скриптами ```packer/files/install_reddit.sh``` и ```packer/files/create_puma_service.sh```
4. Команда для создания образа:
   ```
   packer build -var-file="variables.json" immutable.json
   ```
5. Команда CLI для создания ВМ из образа, созданного packer'ом
    ```
    yc compute instance create --name reddit-full --hostname reddit-full --memory=4 --create-boot-disk image-id=fd8imv4vf0kk1eu87e5a,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --ssh-key appuser.pub
    ```
   Созданная ВМ ```http://84.201.175.22:9292/```
6. Создан скрипт ```config-scripts/create-reddit-vm.sh```

## Terraform 1
1. Созданы instances из образа reddit-base с помощью terraform и переменной count:
   1. reddit-app-0 ```http://51.250.11.64:9292/```
   2. reddit-app-1 ```http://178.154.221.249:9292/```
2. Развернут и проверен load balancer: ```http://178.154.226.240/```

## Terraform 2
1. Приложение и БД вынесены в отдельные модули
2. Создана инфраструктура для двух окружений: stage и prod
3. Проверена корректность создания ресурсов
4. Настроено хранение стейт файла в удаленном бекенде (backend.tf)

## Ansible 1
1. Установлен ansible
2. Создан инвентори файл с параметрами подключения к инстансу
3. Создан конфигурационный файл ansible.cfg
4. Протестировано управление хостом с помощью ansible
5. Определена и протестирована группа хостов
6. Создан inventory.yaml

## Ansible 2
1. Написан плейбук с сценарием для управления конфигурацией обоих хостов, хэндлерами и шаблонами конфига
2. Протестирована конфигурация
3. Разбили сценарий на несколько плейбуков, пересоздали ресурсы и протестировали
4. Изменен провижн образов Packer на Ansible-плейбуки, пересобраны образы и ресурсы, протестирована конфигурация
5. Итоговое приложение reddit ```http://51.250.13.170:9292/```

## Ansible 3
1. Перенесли созданные плейбуки в раздельные роли
2. Описали два окружения: stage и prod
3. Использовали коммьюнити роль nginx
4. Использовали Ansible Vault для окружений
5. Итоговое приложение reddit ```http://84.252.131.206:80/```

## Ansible 4
1. Установили virtualbox и vagrant
2. Добавили Vagrantfile
3. Создали виртуалки, описанные в vagrantfile, проверили доступ к ним
4. Доработали и параметризировали роли, протестировали
5. Локально протестировали роли ansible:
   - установили и развернули virtualenv
   - установили модули molecule, ansible, testinfra
   - создали тестовую машину и прогнали тесты
6. Написали тест для проверки того, что БД слушает по порту 27017
