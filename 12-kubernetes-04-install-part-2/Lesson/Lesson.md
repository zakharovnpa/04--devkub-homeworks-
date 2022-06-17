## Ход выполнения ДЗ по теме"12.4 Развертывание кластера на собственных серверах, лекция 2"

Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

### Подготовка:

### 1. Необходимо подготовить инвентарь kubespray. 
> Инвентарь - это значит набор файлов, в которых описаны ресурсы для организации серверных ресурсов
> inventory файл. Этот файл будет содержать конфигурацию вашего кластера.

1. Наш инвентарь будет состоять из следующих файлов:
  1.  Для создания ВМ на локальном сервере или на облачном. Vagrant, yc, Terraform
  2.  Файлы, устанавливающие на ВМ необходимые програмные компоненты. Ansible, kubespray

Рекомендация от преподавателя:
1. Создать на облачном сервисе кластер с помощью kubespray
2. Доступ к кластеру должен быть с вашей локальной машины, на которой установлен kubectl

### - 01:18:50 - про ДЗ. Надо найти ключик для подключения домашнего ПК к kubectl

### Ход решения 1:
#### Создание ВМ в Яндекс Облаке
1. Директория выполнения ДЗ - /root/learning-kubernetis/Alfa
2. Создаем три скрипта для управления ВМ на облаке
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# chmod 777 ./list-vms.sh 
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# chmod 777 ./create-vms.sh 
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# chmod 777 ./delete-vms.sh 

```

3. Запускаем скрипт, устанавливающий 2 ВМ
```
#!/bin/bash

#!/bin/bash

set -e

function create_vm {
  local NAME=$1

  YC=$(cat <<END
    yc compute instance create \
      --name $NAME \
      --hostname $NAME \
      --zone ru-central1-a \
      --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
      --memory 2 \
      --cores 2 \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,type=network-ssd,size=20 \
      --ssh-key /root/.ssh/id_rsa.pub
END
)
#  echo "$YC"
  eval "$YC"
}

create_vm "cp1"
create_vm "node1"
#create_vm "node2"

```
4. Результат работы скрипта
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./create-vms.sh 
done (22s)
id: fhmbr831t8a45vdb8a3f
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-17T05:55:04Z"
name: cp1
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhm21q7242vqhsqb3ous
  auto_delete: true
  disk_id: fhm21q7242vqhsqb3ous
network_interfaces:
- index: "0"
  mac_address: d0:0d:bd:a0:61:ea
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.6
    one_to_one_nat:
      address: 51.250.79.135
      ip_version: IPV4
fqdn: cp1.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

done (18s)
id: fhm0ca8tj6g9me0m8o4g
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-17T05:55:27Z"
name: node1
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhmb7il8gr8fsth14h94
  auto_delete: true
  disk_id: fhmb7il8gr8fsth14h94
network_interfaces:
- index: "0"
  mac_address: d0:0d:62:91:d9:9a
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.14
    one_to_one_nat:
      address: 51.250.81.89
      ip_version: IPV4
fqdn: node1.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
```
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./list-vms.sh 
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm0ca8tj6g9me0m8o4g | node1 | ru-central1-a | RUNNING | 51.250.81.89  | 10.128.0.14 |
| fhmbr831t8a45vdb8a3f | cp1   | ru-central1-a | RUNNING | 51.250.79.135 | 10.128.0.6  |
+----------------------+-------+---------------+---------+---------------+-------------+

(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# vim ./delete-vms.sh 
```
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./delete-vms.sh 
...1s...6s...11s...done (12s)
...1s...6s...11s...done (12s)
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./list-vms.sh 
+----+------+---------+--------+-------------+-------------+
| ID | NAME | ZONE ID | STATUS | EXTERNAL IP | INTERNAL IP |
+----+------+---------+--------+-------------+-------------+
+----+------+---------+--------+-------------+-------------+

(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# 

```



## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
