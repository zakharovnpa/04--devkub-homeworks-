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
5. Устанавливаем зависимости
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
6. Создаем локальную директорию для настройки кластера
```
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray# cp -rfp inventory/sample inventory/mycluster
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray# 
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray# cd inventory/mycluster/
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray/inventory/mycluster# 
(venv) root@PC-Ubuntu:~/learning-kubernetis/kubespray/inventory/mycluster# ls -lha
итого 16K
drwxr-xr-x 3 root root 4,0K июн 13 22:10 .
drwxr-xr-x 5 root root 4,0K июн 17 10:41 ..
drwxr-xr-x 4 root root 4,0K июн 13 22:10 group_vars
-rw-r--r-- 1 root root 1,1K июн 13 22:10 inventory.ini
```
7. Подготавливаем файлы инвентори

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



## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
