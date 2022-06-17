## Лекция по теме "Развертывание кластера на собственных серверах - часть 2"

Андрей
Копылов
1Андрей Копылов
TechLead
PremiumBonus
Андрей Копылов

[1](https://github.com/kubernetes-sigs/kubespray)

[2](https://devops.stackexchange.com/questions/9483/how-can-i-add-an-additional-ip-hostname-to-my-kubernetes-certificate)

### 2План занятия
1. Требования к серверам
2. Ansible
3. Kubespray
4. Итоги
5. Домашнее задание

-00:03:30 - Занятие посвящено развертыванию кластера с помощью Ansible и Kubespray
- С помощью Ansible - не самый рекоментуемый способ, но просто и быстро
- С помошью Kubespray можно сконфигурировать все что нужно. Устновить несколько Control Play
- Control Plane должно быть нечетное кол-во
- 




### 3Требования к серверам

### 4Требования для Control Plane (3 шт.)
- CPU — от 2 ядер
- ОЗУ — от 2 ГБ
- Диск — от 50 ГБ

### 5Требования для рабочих нод (5 шт.)
- CPU — от 1 ядра
- ОЗУ — от 1 ГБ
- Диск — от 100 ГБ

### 6Зависимости      - 00:06:50
- Системные:
```
apt-transport-https ca-certiﬁcates curl
```
- Новый репозиторий:
```
echo "deb
[signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg
] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee
/etc/apt/sources.list.d/kubernetes.list
```
- Системные для кубера:
```
kubelet kubeadm kubectl
```

### 7Зависимости в ansible      - 00:07:10
![install_01](/12-kubernetes-04-install-part-2/Files/install_01.png)

- В Ансибл мы переносим команды все теже самые, что и при запуске из Шелл

### 8Инициализация мастер ноды      - 00:07:30
![install_02](/12-kubernetes-04-install-part-2/Files/install_02.png)

- Может быть выведена в отдельную таску

### 9Подключение остальных мастеров
![install_03](/12-kubernetes-04-install-part-2/Files/install_03.png)

### 10Подключение рабочих нод
![install_04](/12-kubernetes-04-install-part-2/Files/install_04.png)

- 00:08:40 - использование Ансибл позволяет упростить процесс добавления нод в кластер

### 11Проверка работоспособности
- забрать конфиг с мастера
- kubectl get nodes

### 12Kubespray     - 00:09:15 - новые кластреы лучше ставить с помощью Kubespray

### 13Что за “зверь”?     - 00:10:10
- Kubespray - это набор Ansible ролей для установки и конфигурирования системы оркестрации контейнерами Kubernetes.
- В качестве IaaS в этом случае могут выступать AWS, GCE, Azure, OpenStack или обычные виртуальные машины.

- Можно устанавливать в обфчные ВМ или в облака

### 14Пример настройки через kubespray      - 00:10:40
![install_05](/12-kubernetes-04-install-part-2/Files/install_05.png)

- Здесь приведен вариант конфига в виде ini файла
- Также может быть конфиг в виде yaml файла
- Далее будем работать с yaml файлом конфига
- Этого файла достаточно для установки кластреа

### 15Проверка статуса кластера     - 00:11:35
- `kubectl get nodes` — покажет все ноды кластера;
- `kubectl get pods` — покажет поды в default namespace.

### 16Полезный софт     - 00:11:50
- Ingress
- Kubernetes dashboard
- Lens - аналог Kubernetes dashboard, устанавливаемый на локальный ПК

![install_06](/12-kubernetes-04-install-part-2/Files/install_06.png)



### Практическая часть Лекции   - 00:13:30

- Про Ansible playbook. ВАриант ручной установки


* setup-worker.yml
```yml
---
- import_playbook: playbooks/soft.yml
- import_playbook: playbooks/worker.yml
```
* setup-controlplane.yml
```yml
---
- import_playbook: playbooks/soft.yml
- import_playbook: playbooks/control-plane.yml
```
* setup-cluster.yml
```yml
---
- import_playbook: playbooks/soft.yml
- import_playbook: playbooks/control-plane.yml
- import_playbook: playbooks/worker.yml
```
* control-plane.yml
```yml
---
- hosts: master
  tasks:
  - name: Kubeadm init
    shell: kubeadm init --node-name=m1 --apiserver-cert-extra-sans=master --pod-network-cidr 10.244.0.0/16

  - name: Copy config to home directory
    shell: mkdir -p $HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config

  - name: Download CNI plugin
    shell: kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

  - name: Kubeadm token print
    shell: kubeadm token create --print-join-command
```
* soft.yml
```yml
---
- hosts: all
  tasks:
  - name: Install packages that allow apt to be used over HTTPS
    apt:
      name: "{{ packages }}"
      state: present
      update_cache: yes
    vars:
      packages:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg-agent
      - software-properties-common

  - name: Add kubernetes apt-key
    apt_key:
      url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
      state: present

  - name: Add kubernetes apt repository
    apt_repository:
      repo: 'deb http://apt.kubernetes.io/ kubernetes-xenial main'
      state: present
      filename: kubernetes


  - name: Install Kubernetes packages
    apt:
      name: "{{ packages }}"
      state: present
      update_cache: yes
    vars:
      packages:
        - kubelet
        - kubeadm
        - kubectl
        - containerd

  - name: Fix settings
    shell: echo 1 > /proc/sys/net/ipv4/ip_forward && modprobe br_netfilter

```
* worker.yml
```yml
---
- hosts: workers
  tasks:
  - name: Join node
    shell: kubeadm join 10.0.90.30:6443
#    shell: kubeadm join --skip-phases=preflight 10.0.90.30:6443
```
* control-plane-reset.yml
```yml
---
- hosts: workers
  tasks:
  - name: Join node
    shell: kubeadm join 10.0.90.30:6443
#    shell: kubeadm join --skip-phases=preflight 10.0.90.30:6443
```

- 00:15:40 
* hosts
```
[master]
10.0.90.30

[workers]
10.0.90.16
10.0.90.3
```
* hosts-control-plane
```
[master]
10.0.90.30
```
* hosts-new-node
```
[workers]
10.0.90.3
```
- 00:16:10 - в Ansible много ручной работы. Иногда это хорошо

- 00:16:19 - про Kubespray

## Установка Kubernetes с помощью kubespray
[Документация](https://kubespray.io/)

## Подготовка
Склонируйте себе репозиторий:
```shell script
git clone https://github.com/kubernetes-sigs/kubespray
```

```shell script
# Установка зависимостей
sudo pip3 install -r requirements.txt

# Копирование примера в папку с вашей конфигурацией
cp -rfp inventory/sample inventory/mycluster
```

## Конфигурация     - 00:18:00
После установки зависимостей и подготовки шаблона с конфигурацией необходимо подготовить inventory файл.
Этот файл будет содержать конфигурацию вашего кластера.

Тут возможны два варианта:
- запуск билдера и ручная правка `hosts.yaml` при необходимости; 
- ручная правка `inventory.ini`.
Эти способы равнозначны. Их использование зависит только от ваших личных предпочтений.
 
 - 00:18:15 - Билдер готовит файл `hosts.yaml`. Мы пойдем этим путем


Практически любой параметр кластера может быть сконфигурирован.
Минимальный набор параметров такой:
- имена нод;
- роли нод;
- ноды, на которых будет запущен etcd;
- CNI плагин;
- CRI плагин.

### Конфигурация с запуском билдера   - 00:18:35
Подготовьте список IP адресов и скопируйте их через пробел в первую команду.  
```shell script
# Обновление Ansible inventory с помощью билдера 
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# 10.10.1.3 10.10.1.4 10.10.1.5 - адреса ваших серверов
```
- 00:18:55
Билдер подготовит файл `inventory/mycluster/hosts.yaml`. Там будут прописаны адреса серверов, которые вы указали.
Остальные настройки нужно делать самостоятельно.

### Конфигурация без запуска билдера 
Далее необходимо отредактировать файл `inventory/mycluster/inventory.ini` в соответствии с вашими предпочтениями.

## Установка кластера
Вне зависимости от предыдущего шага установка кластера производится однообразно.
Меняется только указываемый `inventory` файл для playbook.

Установка кластера занимает значительное количество времени.
Время установки кластер из двух нод может занять более 10 минут.
Чем больше нод, тем больше времени занимает установка.

### Установка кластера после билдера 
```shell script
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
```

### Установка кластера без билдера 
```shell script
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v
```

## Проверка установки
```shell script
kubectl version
kubectl get nodes

kubectl create deploy nginx --image=nginx:latest --replicas=2
kubectl get po -o wide
```

## Добавление ноды
```shell script
ansible-playbook -i inventory/mycluster/hosts.yml scale.yml -b -v
```

## Удаление ноды
```shell script
ansible-playbook -i inventory/mycluster/hosts.yml remove-node.yml -b -v \
  --private-key=~/.ssh/private_key \
  --extra-vars "node=nodename,nodename2
```

- 00:19:55
- Начало показа установки
- 00:20:14 - установки ВМ на Яндекс.Облаке
* `./create-vms.sh`
```ShellSession
#!/bin/bash

set -e

function create_vm {
  local NAME=$1

  YC=$(cat <<END
    yc compute instance create \
      --name $NAME \
      --hostname $NAME \
      --zone ru-central1-c \
      --network-interface subnet-name=default,nat-ip-version=ipv4 \
      --memory 2 \
      --cores 2 \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,type=network-ssd,size=20 \
      --ssh-key /home/andrey/.ssh/id_rsa.pub
END
)
#  echo "$YC"
  eval "$YC"
}

create_vm "cp1"
create_vm "node1"
create_vm "node2"
```
* 00:20:30 - заходим в директорию со скачанным Kuberspray. Заносим в этот файл IP адреса наших ВМ из облака
* `inventory.ini`
```ini
# ## Configure 'ip' variable to bind kubernetes services on a
# ## different ip than the default iface
# ## We should set etcd_member_name for etcd cluster. The node that is not a etcd member do not need to set the value, or can set the empty string value.
[all]
# node1 ansible_host=95.54.0.12  # ip=10.3.0.1 etcd_member_name=etcd1
# node2 ansible_host=95.54.0.13  # ip=10.3.0.2 etcd_member_name=etcd2
# node3 ansible_host=95.54.0.14  # ip=10.3.0.3 etcd_member_name=etcd3
# node4 ansible_host=95.54.0.15  # ip=10.3.0.4 etcd_member_name=etcd4
# node5 ansible_host=95.54.0.16  # ip=10.3.0.5 etcd_member_name=etcd5
# node6 ansible_host=95.54.0.17  # ip=10.3.0.6 etcd_member_name=etcd6

# ## configure a bastion host if your nodes are not directly reachable
# [bastion]
# bastion ansible_host=x.x.x.x ansible_user=some_user

[kube_control_plane]
# node1
# node2
# node3

[etcd]
# node1
# node2
# node3

[kube_node]
# node2
# node3
# node4
# node5
# node6

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr

```
- 00:22:00 - далее делаем пошагово по файлу README.md каталога kubespray
-00:22:50 Создаем новую папку и копируем в нее файл 
```ShellSession
# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster
```
* Теперь работаем в новом файле `inventory/mycluster` Или можно работать в `inventory.ini` Или создаем `inventory/mycluster/hosts.yaml`
с нужными нам параметрами
```ShellSession
# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
- 00:24:30 - указываем внешние IP адреса наших ВМ. И запускаем команду. В результате создастся файл `hosts.yaml`
- 00:25:35 - с этим файлом можно дальше спокойно работать. Но рекомендуется убрать лишнее и некоторые вещи довести до нужного состояния.
А именно:

![myclaster-hosts](/12-kubernetes-04-install-part-2/Files/myclaster-hosts.png)

- 00:30:05 - Теперь мы готовы устанавливать наш кластер
* Смотрим и изменяем файлы переменных
```ShellSession
# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
```
- 00:30:30 - Запускаем установку кластера `ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml`
```ShellSession
# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```
- 00:30:43 - запуск с ошибкой `ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml`
- 00:35:55 - `ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml`

- 00:41:35 - про установку etcd на два разных кластера
- 00:51:50 - про ДЗ комментарий. 
```ShellSession
# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
```
* В файле `all.yml` секция про ДНС сервера. Можно настроить свои и даже сервера провайдера

- 00:54:00 - Завершение установки кластера

### Тестирование нового кластера      - 00:55:15
- вход на первую ноду.
- 00:55:25 - команда для подключения пользователя ОС к Kubernetes
- 00:56:01 - проверка кластера с ноды Control plane. !!! Нам надо сделать так, чтобы можно был оуправлять кластрером со своего ПК.
- 00:58:15 - проверка доступности к кластеру с локального ПК
- 00:58:45 - пояснение про Белые IP адерса. Нужно добавить (в?) нужный сертификат и тогда на локальной машине все заработает.
- 00:59:00 - ответы на вопросы студентов. Почему надо делать колв- управляющих нод, на которых установлено etcd нечетное кол-во. Смотри материалы по теме "split brain" 
- 01:03:10 - смотрим в `yml` файлах в директории вида `myclaster/group_vars/k8s_claster/` строчки кода, где настраиваются параметры для белых IP
- обзор файла `k8s-claster.yml`
- 01:05:50 - про то как может быть установлен внешний балансировщик
- 01:06:25 - как выбрать какую версию Kubernetes можно установить.
- 01:07:40 - про то где прописывается установка Calico
- 01:08:20 - где прописывать диапазон IP адресов для сервисов `kube_service_address`, для подов `kube_pods_subnet`
- данные диапазоны сетей можно задать только на стадии развертывания кластера, но потом, на работающем кластере их менять не жедательно. Это может нарушить работу сервисов со всеми вытекающими. Выход будет один - `kubeadm reset` (ну или настройки сети возвращать на место)
- 01:13:45 - !!! про то, какой будет контейнер менеджер `conteiner_manager: conteinerd`
- 01:14:20 - про ДЗ. какие файла показать в решении
- 01:15:00 - как выставить параметры ограничения потребления ресурсов кластером
- 01:16:10 - обзор файла `addons.yml`
- 01:16:15 - где прописать установку Helm `helm_enabled: true`
- 01:16:35 - provisioner
- 01:17:05 - ingress
- 01:18:50 - про ДЗ. Надо найти ключик для подключения домашнего ПК к kubectl. С его помощью можно будет прописать IP адрес в нужное место
- 01:20:10 - как лучше искать: надо в одном из плейбуков найти место где сертификаты выписываются и там найти непосредственную ссылку и указать какой там был ключик.
- 01:23:20 - найден ключ   `supplementary_addresses_in_ssl_keys` в таске `kubeadm-setup.yml`
- 01:23:50 - !!! в файле `k8s-claster.yml` раскомментируем ключ `supplementary_addresses_in_ssl_keys` и указываем там наш внешний ip адрес нашего сервера с управляющей нодой и тогда ыишется сертификат, с которым можно будет установить kubesprey так как нужно и этим опльзоваться.
- 01:26:25 - про рабочую нагрузку кластера
```
# Рабочая нагрузка
В Kubernetes есть объекты, в которых запускается рабочая нагрузка.

## Основные компоненты
- [Pod](./10-pod/README.md) — минимальная единица развертывания;
- [Deployment](./20-deployment/README.md) — создание подов и их масштабирование;
- [ReplicaSet](./30-replicaset/README.md) — создание подов и их масштабирование (версионирование);
- [StatefulSet](./40-statefulset/README.md) — создание подов с сохранением состояния и их масштабирование;
- [DaemonSet](./50-daemonset/README.md) - запуск подов на каждой ноде; 
- Job - запуск одноразовой задачи;
- CronJob - запуск задачи по крону.

Все эти объекты создают поды, в которых запускаются приложения с полезной нагрузкой.
```
### -01:26:50 - про поды
### -01:28:26 - про deployments
- У одного Deployment может быть несколько ReplicaSet
- 01:31:39 - про то, где описано про поды `/learning-kubernetis/kubernetes-for-beginners/20-concepts/10-workload/10-pod/README.md`
### -01:31:50 - про StatefullSet
- `~/learning-kubernetis/kubernetes-for-beginners/20-concepts/10-workload/40-statefulset/README.md`
### -01:33:40 - про DaemonSet
- Создает по одному поду на каждой ноже
- 01:33:50 - показаны демонсеты с помощью команды `kubectl --context=efox -n kube-system get pods -o wide`
- `~/learning-kubernetis/kubernetes-for-beginners/20-concepts/10-workload/50-daemonset/README.md`
![deamonsets](//Files/deamonsets.png)
### 17Итоги
Сегодня мы изучили:
- Установку мастеров и рабочих нод через ansible;
- Возможности Kubespray.

### 18Домашнее задание      -01:37:30

Пошагово повторить то, что было показано на лекции
- Папку с kubespray сохранить у себя и потом использовать
- Кластер можно использовать и на меньшее кол-во рабочих нод, а не как в задании.
- Немного усложним задание:
  - кластер должен быть доступен извне. Нужно чтобы кластер был не в локальной сети
- Можно в Яндекс.Облаке запускать. 
- Для доступа с вашего ПК надо будет указать ключик supplementory-ssl

В ответе прикладывать только те файлы, которые были изменены.
  - inventory.ini
  - hosts.yaml
  - те файлы, какие были изменены


Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты все задачи.


К домашке рикладывать испавленные файлы для проверки.

### 19Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
