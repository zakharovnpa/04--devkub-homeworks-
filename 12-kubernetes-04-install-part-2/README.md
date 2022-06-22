# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2" - Захаров Сергей Николаевич
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

## Ответ:
1. Для разворачивания кластера используется Kubespray и 5 ВМ в Яндекс Облаке

```
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm1u661me90nn9fp76i | node4 | ru-central1-a | RUNNING | 51.250.93.74  | 10.128.0.29 |
| fhm5a1ss72jisu8ljq9c | cp1   | ru-central1-a | RUNNING | 51.250.93.145 | 10.128.0.30 |
| fhm8nr00jlpoi9q15js5 | node3 | ru-central1-a | RUNNING | 51.250.82.4   | 10.128.0.34 |
| fhmiop06ucrc0qdp9vr2 | node1 | ru-central1-a | RUNNING | 51.250.89.48  | 10.128.0.14 |
| fhmujb14gvm050vcuv17 | node2 | ru-central1-a | RUNNING | 51.250.91.220 | 10.128.0.22 |
+----------------------+-------+---------------+---------+---------------+-------------+

```

2. Для наших инвентори файлов создадим новую директорию `inventory/netology-test` копированием директории `inventory/sample`
3. С помощью билдера создаем файл `hosts.yaml`
4. Редактируем файл `hosts.yaml`. Добавляем ip адреса ВМ и имя пользователя на ВМ. Делаем тестовые подключения по ssh для проброса ключа, чтобы Kebrespray мог нормально подключаться к ВМ.

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
5. Для возможности удаленного подключения по http к кластеру в файле `k8s-cluster.yml` раскомментируем строку и пропишем ip адрес ВМ с управляющей нодой `cp1` 

```
supplementary_addresses_in_ssl_keys: [51.250.93.145]
```
6. По условию задания необходимо использовать в качестве CRI — containerd. Настривается в файле 


7. Запуск etcd производить на мастере. Прописывается в файле 

```
├── netology-test
    ├── credentials
    │   └── kubeadm_certificate_key.creds
    ├── group_vars
    │   ├── all
    │   │   ├── all.yml
    │   │   ├── aws.yml
    │   │   ├── azure.yml
    │   │   ├── containerd.yml
    │   │   ├── coreos.yml
    │   │   ├── cri-o.yml
    │   │   ├── docker.yml
    │   │   ├── etcd.yml
    │   │   ├── gcp.yml
    │   │   ├── hcloud.yml
    │   │   ├── oci.yml
    │   │   ├── offline.yml
    │   │   ├── openstack.yml
    │   │   ├── upcloud.yml
    │   │   └── vsphere.yml
    │   ├── etcd.yml
    │   └── k8s_cluster
    │       ├── addons.yml
    │       ├── k8s-cluster.yml
    │       ├── k8s-net-calico.yml
    │       ├── k8s-net-canal.yml
    │       ├── k8s-net-cilium.yml
    │       ├── k8s-net-flannel.yml
    │       ├── k8s-net-kube-ovn.yml
    │       ├── k8s-net-kube-router.yml
    │       ├── k8s-net-macvlan.yml
    │       └── k8s-net-weave.yml
    ├── hosts.yaml
    └── inventory.ini
```


3. 

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
