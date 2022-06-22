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

#### Директория выполнения ДЗ - `/root/learning-kubernetis/Alfa`

#### 1. Создание ВМ в Яндекс Облаке
1. Создаем три скрипта для управления ВМ на облаке
```
-rwxrwxrwx  1 root root  578 июн 19 08:55 create-vms.sh
-rwxrwxrwx  1 root root  196 июн 19 09:06 delete-vms.sh
-rwxrwxrwx  1 root root   57 июн 17 08:59 list-vms.sh
-rwxr-xr-x  1 root root  203 июн 19 09:18 restart-vms.sh
-rwxr-xr-x  1 root root  237 июн 19 09:53 start-vms.sh
-rwxr-xr-x  1 root root  182 июн 19 09:15 stop-vms.sh

```
2. Скрипты:

*  create-vms.sh
```
 
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
create_vm "node2"
create_vm "node3"
create_vm "node4"

```
*  list-vms.sh 
```
#!/bin/bash

yc compute instance list 
```
* restart-vms.sh 
```
#!/bin/bash

set -e

function restart_vm {
  local NAME=$1
  $(yc compute instance restart --name="$NAME")
}

restart_vm "cp1"
restart_vm "node1"
restart_vm "node2"
restart_vm "node3"
restart_vm "node4"

```
* start-vms.sh 
```
#!/bin/bash

yc compute instance start --name="cp1" && \
yc compute instance start --name="node1" && \
yc compute instance start --name="node2" && \
yc compute instance start --name="node3" && \
yc compute instance start --name="node4"

```
* stop-vms.sh 
```
#!/bin/bash

set -e

function stop_vm {
  local NAME=$1
  $(yc compute instance stop --name="$NAME")
}

stop_vm "cp1"
stop_vm "node1"
stop_vm "node2"
stop_vm "node3"
stop_vm "node4"

```

3. Запускаем скрипт, устанавливающий 2 ВМ
```
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
4. Результат работы скрипта. Создано две ВМ
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
5. Устанавливаем в следующий сеанс 5 ВМ
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./create-vms.sh
done (25s)
id: fhm5a1ss72jisu8ljq9c
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-19T04:56:24Z"
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
  device_name: fhm1j2lvsq2d3lhu7fsn
  auto_delete: true
  disk_id: fhm1j2lvsq2d3lhu7fsn
network_interfaces:
- index: "0"
  mac_address: d0:0d:55:07:9c:38
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.30
    one_to_one_nat:
      address: 51.250.72.250
      ip_version: IPV4
fqdn: cp1.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

There is a new yc version '0.91.0' available. Current version: '0.85.0'.
See release notes at https://cloud.yandex.ru/docs/cli/release-notes
You can install it by running the following command in your shell:
        $ yc components update

done (21s)
id: fhmiop06ucrc0qdp9vr2
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-19T04:56:51Z"
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
  device_name: fhm7ask25784bqssbp3f
  auto_delete: true
  disk_id: fhm7ask25784bqssbp3f
network_interfaces:
- index: "0"
  mac_address: d0:0d:12:c6:40:6f
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.14
    one_to_one_nat:
      address: 51.250.89.112
      ip_version: IPV4
fqdn: node1.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

done (17s)
id: fhmujb14gvm050vcuv17
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-19T04:57:13Z"
name: node2
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhmof9h89flnefo036oj
  auto_delete: true
  disk_id: fhmof9h89flnefo036oj
network_interfaces:
- index: "0"
  mac_address: d0:0d:1e:9a:c2:48
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.22
    one_to_one_nat:
      address: 51.250.90.116
      ip_version: IPV4
fqdn: node2.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

done (21s)
id: fhm8nr00jlpoi9q15js5
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-19T04:57:32Z"
name: node3
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhmiii8vnr8qnl7no4b7
  auto_delete: true
  disk_id: fhmiii8vnr8qnl7no4b7
network_interfaces:
- index: "0"
  mac_address: d0:0d:8b:ec:00:9d
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.34
    one_to_one_nat:
      address: 51.250.11.207
      ip_version: IPV4
fqdn: node3.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

done (19s)
id: fhm1u661me90nn9fp76i
folder_id: b1gd3hm4niaifoa8dahm
created_at: "2022-06-19T04:57:55Z"
name: node4
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: fhmh4vgge1is5ue70al8
  auto_delete: true
  disk_id: fhmh4vgge1is5ue70al8
network_interfaces:
- index: "0"
  mac_address: d0:0d:1f:18:c1:b3
  subnet_id: e9bi82druit5rcjcbn14
  primary_v4_address:
    address: 10.128.0.29
    one_to_one_nat:
      address: 51.250.80.140
      ip_version: IPV4
fqdn: node4.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

```
**Ответ:**

Создано 4 ВМ:
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ./list-vms.sh 
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm1u661me90nn9fp76i | node4 | ru-central1-a | RUNNING | 51.250.80.140 | 10.128.0.29 |
| fhm5a1ss72jisu8ljq9c | cp1   | ru-central1-a | RUNNING | 51.250.72.250 | 10.128.0.30 |
| fhm8nr00jlpoi9q15js5 | node3 | ru-central1-a | RUNNING | 51.250.11.207 | 10.128.0.34 |
| fhmiop06ucrc0qdp9vr2 | node1 | ru-central1-a | RUNNING | 51.250.89.112 | 10.128.0.14 |
| fhmujb14gvm050vcuv17 | node2 | ru-central1-a | RUNNING | 51.250.90.116 | 10.128.0.22 |
+----------------------+-------+---------------+---------+---------------+-------------+
```
#### 2. Подготовка файлов инвентори для kubespray

* Пояснение:
1. Согласно задания необходимо создать два кластера
  * тестовый
  * продуктовый
2. Необходимо автоматизировать процесс развертывания кластеров

**Ход решения:**

1. Установка Kubernetes на созданные ВМ будем производить с помощью kubespray на основании ролей Ansible
2. Ansible роли для kubespray копируем из репозитория [kubespray](https://github.com/kubernetes-sigs/kubespray)
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# git clone git@github.com:kubernetes-sigs/kubespray.git
Клонирование в «kubespray»…
remote: Enumerating objects: 62348, done.
remote: Counting objects: 100% (66/66), done.
remote: Compressing objects: 100% (45/45), done.
remote: Total 62348 (delta 21), reused 53 (delta 16), pack-reused 62282
Получение объектов: 100% (62348/62348), 18.33 МиБ | 2.73 МиБ/с, готово.
Определение изменений: 100% (35049/35049), готово.
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# 
```

3. Создаем две новые локальные директории для настройки кластеров

* `cp -rfp inventory/sample inventory/netology-test`
* `cp -rfp inventory/sample inventory/netology-prod`
4. Заходим в директорию со скачанным Kuberspray. 
5. Заносим в этот файл IP адреса наших ВМ из облака
* `/root/learning-kubernetis/Alfa/kubespray/inventory/netology-test/inventory.ini`

6. Идем вариантом создания файла `hosts.yaml` с помощью билдера
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# declare -a IPS=(51.250.93.145 51.250.89.48 51.250.91.220 51.250.82.4 51.250.93.74)
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# CONFIG_FILE=inventory/unknow-cluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
Traceback (most recent call last):
  File "contrib/inventory_builder/inventory.py", line 40, in <module>
    from ruamel.yaml import YAML
ModuleNotFoundError: No module named 'ruamel'

```
* Ошибка. Нет устновленного модуля 'ruamel'
7. Устанавливаем модуль 'ruamel'
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# pip install ruamel.yaml
Collecting ruamel.yaml
  Using cached ruamel.yaml-0.17.21-py3-none-any.whl (109 kB)
Collecting ruamel.yaml.clib>=0.2.6
  Using cached ruamel.yaml.clib-0.2.6-cp38-cp38-manylinux1_x86_64.whl (570 kB)
Installing collected packages: ruamel.yaml.clib, ruamel.yaml
Successfully installed ruamel.yaml-0.17.21 ruamel.yaml.clib-0.2.6
WARNING: You are using pip version 21.3.1; however, version 22.1.2 is available.
You should consider upgrading via the '/root/learning-kubernetis/Alfa/venv/bin/python -m pip install --upgrade pip' command.

```
8. Необходимо обновить пакет pip
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# /root/learning-kubernetis/Alfa/venv/bin/python -m pip install --upgrade pip
Requirement already satisfied: pip in /root/learning-kubernetis/Alfa/venv/lib/python3.8/site-packages (21.3.1)
Collecting pip
  Downloading pip-22.1.2-py3-none-any.whl (2.1 MB)
     |████████████████████████████████| 2.1 MB 1.4 MB/s            
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 21.3.1
    Uninstalling pip-21.3.1:
      Successfully uninstalled pip-21.3.1
Successfully installed pip-22.1.2

```
9.  Вторая попытка обновления модуля 'ruamel'
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# pip install ruamel.yaml
Requirement already satisfied: ruamel.yaml in /root/learning-kubernetis/Alfa/venv/lib/python3.8/site-packages (0.17.21)
Requirement already satisfied: ruamel.yaml.clib>=0.2.6 in /root/learning-kubernetis/Alfa/venv/lib/python3.8/site-packages (from ruamel.yaml) (0.2.6)
```
10. Вторая попытка создания файла `hosts.yaml` с помощью билдера
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# declare -a IPS=(51.250.93.145 51.250.89.48 51.250.91.220 51.250.82.4 51.250.93.74)
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# echo ${IPS[@]}
51.250.93.145 51.250.89.48 51.250.91.220 51.250.82.4 51.250.93.74
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# 
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa/kubespray# CONFIG_FILE=inventory/unknow-cluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
DEBUG: Adding group all
DEBUG: Adding group kube_control_plane
DEBUG: Adding group kube_node
DEBUG: Adding group etcd
DEBUG: Adding group k8s_cluster
DEBUG: Adding group calico_rr
DEBUG: adding host node1 to group all
DEBUG: adding host node2 to group all
DEBUG: adding host node3 to group all
DEBUG: adding host node4 to group all
DEBUG: adding host node5 to group all
DEBUG: adding host node1 to group etcd
DEBUG: adding host node2 to group etcd
DEBUG: adding host node3 to group etcd
DEBUG: adding host node1 to group kube_control_plane
DEBUG: adding host node2 to group kube_control_plane
DEBUG: adding host node1 to group kube_node
DEBUG: adding host node2 to group kube_node
DEBUG: adding host node3 to group kube_node
DEBUG: adding host node4 to group kube_node
DEBUG: adding host node5 to group kube_node
```
11. Создался файл `/root/learning-kubernetis/Alfa/kubespray/inventory/unknow-cluster/hosts.yaml`
12. Копируем этот файл в директорию кластера `netology-test`
13. Редактируем файл. !!! Копию в ответ на ДЗ
```yml
all:
  hosts:
    cp1:
      ansible_host: 51.250.93.145
      ansible_user: yc-user
    node1:
      ansible_host: 51.250.89.48
      ansible_user: yc-user
    node2:
      ansible_host: 51.250.91.220
      ansible_user: yc-user
    node3:
      ansible_host: 51.250.82.4
      ansible_user: yc-user
    node4:
      ansible_host: 51.250.93.74
      ansible_user: yc-user
  children:
    kube_control_plane:
      hosts:
        cp1:
    kube_node:
      hosts:
        node1:
        node2:
        node3:
        node4:
    etcd:
      hosts:
        cp1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```
14. Далее смторим на параметры в файлах

`/root/learning-kubernetis/Alfa/kubespray/inventory/netology-test/group_vars/all/all.yml`

`/root/learning-kubernetis/Alfa/kubespray/inventory/netology-test/group_vars/k8s_cluster/k8s-cluster.yml`

15. Поочередно заходим на подготовленные ВМ по ssh для установления соединения с ними

### 3. Запускаем установку кластера

1. Стартуем запуск командой:
`ansible-playbook -i inventory/netology-test/hosts.yaml  --become --become-user=root cluster.yml`

2. В результате получена ошибка `Ошибка сегментирования (стек памяти сброшен на диск)`

```
TASK [download : download_file | Create dest directory on node] *******************************************************************************************************************************************************************
ok: [cp1]
ok: [node1]
ok: [node2]
ok: [node3]
ok: [node4]
Воскресенье 19 июня 2022  13:11:15 +0400 (0:00:01.789)       0:08:50.462 ****** 
Воскресенье 19 июня 2022  13:11:15 +0400 (0:00:00.059)       0:08:50.522 ****** 
Воскресенье 19 июня 2022  13:11:15 +0400 (0:00:00.074)       0:08:50.597 ****** 
FAILED - RETRYING: [node1]: download_file | Validate mirrors (4 retries left).
FAILED - RETRYING: [cp1]: download_file | Validate mirrors (4 retries left).
FAILED - RETRYING: [node3]: download_file | Validate mirrors (4 retries left).
FAILED - RETRYING: [node4]: download_file | Validate mirrors (4 retries left).
FAILED - RETRYING: [node2]: download_file | Validate mirrors (4 retries left).
FAILED - RETRYING: [node3]: download_file | Validate mirrors (3 retries left).
FAILED - RETRYING: [cp1]: download_file | Validate mirrors (3 retries left).
FAILED - RETRYING: [node1]: download_file | Validate mirrors (3 retries left).
FAILED - RETRYING: [node2]: download_file | Validate mirrors (3 retries left).
FAILED - RETRYING: [node4]: download_file | Validate mirrors (3 retries left).
FAILED - RETRYING: [node1]: download_file | Validate mirrors (2 retries left).
FAILED - RETRYING: [cp1]: download_file | Validate mirrors (2 retries left).
FAILED - RETRYING: [node2]: download_file | Validate mirrors (2 retries left).
FAILED - RETRYING: [node3]: download_file | Validate mirrors (2 retries left).
FAILED - RETRYING: [node4]: download_file | Validate mirrors (2 retries left).
FAILED - RETRYING: [node1]: download_file | Validate mirrors (1 retries left).
FAILED - RETRYING: [cp1]: download_file | Validate mirrors (1 retries left).
FAILED - RETRYING: [node2]: download_file | Validate mirrors (1 retries left).
FAILED - RETRYING: [node3]: download_file | Validate mirrors (1 retries left).
FAILED - RETRYING: [node4]: download_file | Validate mirrors (1 retries left).

TASK [download : download_file | Validate mirrors] ********************************************************************************************************************************************************************************
failed: [node1] (item=None) => {"attempts": 4, "censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
failed: [cp1] (item=None) => {"attempts": 4, "censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
failed: [node2] (item=None) => {"attempts": 4, "censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
failed: [node3] (item=None) => {"attempts": 4, "censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
failed: [node4] (item=None) => {"attempts": 4, "censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
ok: [node1] => (item=None)
fatal: [node1 -> {{ download_delegate if download_force_cache else inventory_hostname }}]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
...ignoring
ok: [node2] => (item=None)
fatal: [node2 -> {{ download_delegate if download_force_cache else inventory_hostname }}]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
...ignoring
ok: [cp1] => (item=None)
ok: [node4] => (item=None)
fatal: [cp1 -> {{ download_delegate if download_force_cache else inventory_hostname }}]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
...ignoring
fatal: [node4 -> {{ download_delegate if download_force_cache else inventory_hostname }}]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
...ignoring
ok: [node3] => (item=None)
fatal: [node3 -> {{ download_delegate if download_force_cache else inventory_hostname }}]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": false}
...ignoring
Воскресенье 19 июня 2022  13:11:47 +0400 (0:00:31.207)       0:09:21.804 ****** 


```

3. Еще ошибки
```

```
4. Результат: установлен на ВМ Kubernetes 
```
PLAY RECAP ************************************************************************************************************************************************************************************************************************
cp1                        : ok=730  changed=79   unreachable=0    failed=0    skipped=1232 rescued=0    ignored=9   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
node1                      : ok=483  changed=41   unreachable=0    failed=0    skipped=721  rescued=0    ignored=2   
node2                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   
node3                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   
node4                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   

Воскресенье 19 июня 2022  13:53:54 +0400 (0:00:00.154)       0:24:04.932 ****** 
=============================================================================== 
network_plugin/calico : Wait for calico kubeconfig to be created ---------------------------------------------------------------------------------------------------------------------------------------------------------- 48.83s
kubernetes/control-plane : kubeadm | Initialize first master -------------------------------------------------------------------------------------------------------------------------------------------------------------- 34.32s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down CoreDNS templates ---------------------------------------------------------------------------------------------------------------------------------------------------- 31.18s
download : download_file | Validate mirrors ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 31.13s
kubernetes-apps/ansible : Kubernetes Apps | Start Resources --------------------------------------------------------------------------------------------------------------------------------------------------------------- 30.43s
kubernetes/kubeadm : Join to cluster -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 22.72s
network_plugin/calico : Calico | Create calico manifests ------------------------------------------------------------------------------------------------------------------------------------------------------------------ 18.45s
network_plugin/calico : Calico | Copy calicoctl binary from download dir -------------------------------------------------------------------------------------------------------------------------------------------------- 16.20s
network_plugin/calico : Start Calico resources ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 15.24s
container-engine/containerd : containerd | Unpack containerd archive ------------------------------------------------------------------------------------------------------------------------------------------------------ 12.98s
kubernetes/preinstall : Preinstall | wait for the apiserver to be running ------------------------------------------------------------------------------------------------------------------------------------------------- 11.13s
kubernetes/preinstall : Ensure kube-bench parameters are set -------------------------------------------------------------------------------------------------------------------------------------------------------------- 10.40s
kubernetes/node : install | Copy kubelet binary from download dir ---------------------------------------------------------------------------------------------------------------------------------------------------------- 9.97s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down nodelocaldns Template ------------------------------------------------------------------------------------------------------------------------------------------------- 8.66s
etcd : Check certs | Register ca and etcd admin/member certs on etcd hosts ------------------------------------------------------------------------------------------------------------------------------------------------- 8.21s
kubernetes/preinstall : Create kubernetes directories ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- 8.10s
container-engine/containerd : containerd | Remove orphaned binary ---------------------------------------------------------------------------------------------------------------------------------------------------------- 7.97s
etcd : Check certs | Register ca and etcd admin/member certs on etcd hosts ------------------------------------------------------------------------------------------------------------------------------------------------- 7.86s
network_plugin/calico : Get current calico cluster version ----------------------------------------------------------------------------------------------------------------------------------------------------------------- 7.79s
container-engine/crictl : extract_file | Unpacking archive ----------------------------------------------------------------------------------------------------------------------------------------------------------------- 7.74s

```
5. Заходим на ноду cp1. 

```
(venv) root@PC-Ubuntu:~/learning-kubernetis/Alfa# ssh yc-user@51.250.93.145
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-117-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Last login: Sun Jun 19 09:53:47 2022 from 128.69.71.165
```
6. Проверяем ноды кластера. Результат: нет подключения, т.к. нет прав доступа пользователя к кластеру
```
yc-user@cp1:~$ kubectl get no
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```
7. Копируем конфиг в домашнюю папку пользователя для управления кластером 
```
{
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
``` 
8. Результат: проверяем ноды на кластере:
```
yc-user@cp1:~$ kubectl get no
NAME    STATUS   ROLES           AGE    VERSION
cp1     Ready    control-plane   116m   v1.24.2
node1   Ready    <none>          114m   v1.24.2
node2   Ready    <none>          114m   v1.24.2
node3   Ready    <none>          114m   v1.24.2
node4   Ready    <none>          114m   v1.24.2

```
### 4. Настройка доступа к ластеру с локального ПК

1. На ВМ cp1 откроем файл `./kube/config`
2. Скопируем из него 
3. И внесем изменения в файл /home/maestro/.kube/config
4. Добавим ключи и сертификаты пользователя, скопированные с ВМ
5. После добавления ключей проверяем команду
```
maestro@PC-Ubuntu:~$ kubectl get nodes
Please enter Username: yc-user
Please enter Password: Unable to connect to the server: x509: certificate is valid for 10.233.0.1, 10.128.0.30, 127.0.0.1, not 51.250.93.145

```



##### Примеры файлов инфентори
* inventory.ini 
```
# ## Configure 'ip' variable to bind kubernetes services on a
# ## different ip than the default iface
# ## We should set etcd_member_name for etcd cluster. The node that is not a etcd member do not need to set the value, or can set the empty string value.
[all]
# node1 ansible_host=95.54.0.12  # ip=10.3.0.1 etcd_member_name=etcd1
# node2 ansible_host=95.54.0.13  # ip=10.3.0.2 etcd_member_name=etcd2



[kube_control_plane]
cp1

[etcd]
cp1

[kube_node]
node1

[k8s_cluster:children]
kube_control_plane
kube_node


```

#### 5. Подотовка локального ПК для взаимодействия с кластером Kubrneets
1. Устанавливаем на локальный ПК зависимости
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray# sudo pip3 install -r requirements.txt
Collecting ansible==5.7.1
  Downloading ansible-5.7.1.tar.gz (35.7 MB)
     |████████████████████████████████| 35.7 MB 42 kB/s 
Collecting ansible-core==2.12.5
  Downloading ansible-core-2.12.5.tar.gz (7.8 MB)
     |████████████████████████████████| 7.8 MB 6.1 MB/s 
Collecting cryptography==3.4.8
  Downloading cryptography-3.4.8-cp36-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl (3.2 MB)
     |████████████████████████████████| 3.2 MB 10.0 MB/s 
Collecting jinja2==2.11.3
  Downloading Jinja2-2.11.3-py2.py3-none-any.whl (125 kB)
     |████████████████████████████████| 125 kB 6.6 MB/s 
Requirement already satisfied: netaddr==0.7.19 in /usr/lib/python3/dist-packages (from -r requirements.txt (line 5)) (0.7.19)
Collecting pbr==5.4.4
  Downloading pbr-5.4.4-py2.py3-none-any.whl (110 kB)
     |████████████████████████████████| 110 kB 6.7 MB/s 
Collecting jmespath==0.9.5
  Downloading jmespath-0.9.5-py2.py3-none-any.whl (24 kB)
Collecting ruamel.yaml==0.16.10
  Downloading ruamel.yaml-0.16.10-py2.py3-none-any.whl (111 kB)
     |████████████████████████████████| 111 kB 6.3 MB/s 
Requirement already satisfied: ruamel.yaml.clib==0.2.6 in /usr/local/lib/python3.8/dist-packages (from -r requirements.txt (line 9)) (0.2.6)
Collecting MarkupSafe==1.1.1
  Downloading MarkupSafe-1.1.1-cp38-cp38-manylinux2010_x86_64.whl (32 kB)
Requirement already satisfied: PyYAML in /usr/lib/python3/dist-packages (from ansible-core==2.12.5->-r requirements.txt (line 2)) (5.3.1)
Requirement already satisfied: packaging in /usr/local/lib/python3.8/dist-packages (from ansible-core==2.12.5->-r requirements.txt (line 2)) (21.3)
Requirement already satisfied: resolvelib<0.6.0,>=0.5.3 in /usr/local/lib/python3.8/dist-packages (from ansible-core==2.12.5->-r requirements.txt (line 2)) (0.5.4)
Collecting cffi>=1.12
  Downloading cffi-1.15.0-cp38-cp38-manylinux_2_12_x86_64.manylinux2010_x86_64.whl (446 kB)
     |████████████████████████████████| 446 kB 6.6 MB/s 
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.8/dist-packages (from packaging->ansible-core==2.12.5->-r requirements.txt (line 2)) (3.0.7)
Collecting pycparser
  Downloading pycparser-2.21-py2.py3-none-any.whl (118 kB)
     |████████████████████████████████| 118 kB 6.7 MB/s 
Building wheels for collected packages: ansible, ansible-core
  Building wheel for ansible (setup.py) ... done
  Created wheel for ansible: filename=ansible-5.7.1-py3-none-any.whl size=61777681 sha256=1194e3a5f723508a73e576af660c545571866cfe111c5830081b69643c9e9120
  Stored in directory: /root/.cache/pip/wheels/02/07/2a/7b3eb5d79e268b769b0910cded0d524b4647ae5bc19f3ebb70
  Building wheel for ansible-core (setup.py) ... done
  Created wheel for ansible-core: filename=ansible_core-2.12.5-py3-none-any.whl size=2077336 sha256=61b48f504a0036b1d83a00f02098685e8dd5aad050f004c81a30bf99636fe21d
  Stored in directory: /root/.cache/pip/wheels/13/09/5b/799a6bc9ca05da9805eaee2afea07e7f63e2ff03b37799d930
Successfully built ansible ansible-core
Installing collected packages: pycparser, cffi, cryptography, MarkupSafe, jinja2, ansible-core, ansible, pbr, jmespath, ruamel.yaml
  Attempting uninstall: cryptography
    Found existing installation: cryptography 2.8
    Not uninstalling cryptography at /usr/lib/python3/dist-packages, outside environment /usr
    Can't uninstall 'cryptography'. No files were found to uninstall.
  Attempting uninstall: MarkupSafe
    Found existing installation: MarkupSafe 2.1.1
    Uninstalling MarkupSafe-2.1.1:
      Successfully uninstalled MarkupSafe-2.1.1
  Attempting uninstall: jinja2
    Found existing installation: Jinja2 3.1.2
    Uninstalling Jinja2-3.1.2:
      Successfully uninstalled Jinja2-3.1.2
  Attempting uninstall: ansible-core
    Found existing installation: ansible-core 2.12.2
    Uninstalling ansible-core-2.12.2:
      Successfully uninstalled ansible-core-2.12.2
  Attempting uninstall: ansible
    Found existing installation: ansible 5.3.0
    Uninstalling ansible-5.3.0:
      Successfully uninstalled ansible-5.3.0
  Attempting uninstall: jmespath
    Found existing installation: jmespath 0.9.4
    Not uninstalling jmespath at /usr/lib/python3/dist-packages, outside environment /usr
    Can't uninstall 'jmespath'. No files were found to uninstall.
  Attempting uninstall: ruamel.yaml
    Found existing installation: ruamel.yaml 0.17.21
    Uninstalling ruamel.yaml-0.17.21:
      Successfully uninstalled ruamel.yaml-0.17.21
Successfully installed MarkupSafe-1.1.1 ansible-5.7.1 ansible-core-2.12.5 cffi-1.15.0 cryptography-3.4.8 jinja2-2.11.3 jmespath-0.9.5 pbr-5.4.4 pycparser-2.21 ruamel.yaml-0.16.10

```
2. Для удаленного подключения к класетру выполним настройку доступа обычного пользователя на локальной ОС
  - Узнать внешний ip адрес управляющей ноды для вставки его в будущий конфиг на локальной ОС
  - На управляющей ноде кластера скопировать файл `/home/yc-user/.kube.config` в такую же директорию на локальной ОС
  - Заменить адрес 127.0.0.1 на внешний адрес управляющей ноды 51.250.93.145
```
yc-user@cp1:~$ cat .kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJ------------tLS0tCg==       # сокращенный вывод
    server: https://127.0.0.1:6443                                      # заменить на внешний адрес управляющей ноды
  name: cluster.local
contexts:
- context:
    cluster: cluster.local
    user: kubernetes-admin
  name: kubernetes-admin@cluster.local
current-context: kubernetes-admin@cluster.local
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUd---------URS0tLS0tCg==         # сокращенный вывод
    client-key-data: LS0tLS1CRUdJT---------------tFWS0tLS0tCg==        # сокращенный вывод
```
3. Результат подключения к кластеру из УЗ обычного пользователя с локальной ОС

```
maestro@PC-Ubuntu:~/.kube$ kubectl get nodes
NAME    STATUS   ROLES           AGE     VERSION
cp1     Ready    control-plane   2d16h   v1.24.2
node1   Ready    <none>          2d16h   v1.24.2
node2   Ready    <none>          2d16h   v1.24.2
node3   Ready    <none>          2d16h   v1.24.2
node4   Ready    <none>          2d16h   v1.24.2

```
```
maestro@PC-Ubuntu:~/.kube$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   2d17h

```

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
