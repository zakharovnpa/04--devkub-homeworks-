# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2" - Захаров Сергей Николаевич
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

## Ответ:

Приложены отредактированные файлы из kuberspray
  - [hosts.yaml](/12-kubernetes-04-install-part-2/Files/hosts.yml)
  - [k8s-claster.yaml](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/a64fc3f0f4b35b5f6ba8f62d1e86ce3e82f7a6c1/12-kubernetes-04-install-part-2/Files/k8s-claster.yaml)

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
    │       ├── k8s-cluster.yml               #редактируемый файл
    │       ├── k8s-net-calico.yml
    │       ├── k8s-net-canal.yml
    │       ├── k8s-net-cilium.yml
    │       ├── k8s-net-flannel.yml
    │       ├── k8s-net-kube-ovn.yml
    │       ├── k8s-net-kube-router.yml
    │       ├── k8s-net-macvlan.yml
    │       └── k8s-net-weave.yml
    ├── hosts.yaml                           #редактируемый файл
    └── inventory.ini
```


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
<!-- 5. Для возможности удаленного подключения по http к кластеру в файле `k8s-cluster.yml` раскомментируем строку и пропишем ip адрес ВМ с управляющей нодой `cp1` . При этом создастся сертификат, в котром будет прописан этот внешний ip адрес и можно будет подключиться по https -->

5. Для возможности удаленного подключения по http к кластеру в файле `k8s-cluster.yml` раскомментируем строку и пропишем ip адрес ВМ с управляющей нодой `cp1` . При этом создастся сертификат, в котром будет прописан этот внешний ip адрес и можно будет подключиться по https

```
supplementary_addresses_in_ssl_keys: [51.250.93.145]
```
6. По условию задания необходимо использовать в качестве CRI — containerd. Настривается в файле `k8s-cluster.yml`

```
container_manager: containerd
```

7. Запуск etcd производить на мастере. Прописывается в файле `hosts.yaml`
* Участок кода, гду прописвается установка etcd на управляющую ноду
```
children:
    etcd:
      hosts:
        cp1:
```

8. Запускаем установку кластера Kubernetes из директории Kuberspray: 

```
ansible-playbook -i inventory/netology-test/hosts.yaml --become --become-user=root cluster.yml
```
9. Кластер Kubernetes установлен

```yml
PLAY RECAP *******************************************************************************************************
cp1                        : ok=730  changed=79   unreachable=0    failed=0    skipped=1232 rescued=0    ignored=9   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
node1                      : ok=483  changed=41   unreachable=0    failed=0    skipped=721  rescued=0    ignored=2   
node2                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   
node3                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   
node4                      : ok=483  changed=41   unreachable=0    failed=0    skipped=720  rescued=0    ignored=2   

Воскресенье 19 июня 2022  13:53:54 +0400 (0:00:00.154)       0:24:04.932 ****** 
=============================================================================== 
network_plugin/calico : Wait for calico kubeconfig to be created --------------------------- 48.83s
kubernetes/control-plane : kubeadm | Initialize first master ------------------------------- 34.32s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down CoreDNS templates --------------------- 31.18s
download : download_file | Validate mirrors ------------------------------------------------ 31.13s
kubernetes-apps/ansible : Kubernetes Apps | Start Resources -------------------------------- 30.43s
kubernetes/kubeadm : Join to cluster ------------------------------------------------------- 22.72s
network_plugin/calico : Calico | Create calico manifests ----------------------------------- 18.45s
network_plugin/calico : Calico | Copy calicoctl binary from download dir ------------------- 16.20s
network_plugin/calico : Start Calico resources --------------------------------------------- 15.24s
container-engine/containerd : containerd | Unpack containerd archive ----------------------- 12.98s
kubernetes/preinstall : Preinstall | wait for the apiserver to be running ------------------ 11.13s
kubernetes/preinstall : Ensure kube-bench parameters are set ------------------------------- 10.40s
kubernetes/node : install | Copy kubelet binary from download dir -------------------------- 9.97s
kubernetes-apps/ansible : Kubernetes Apps | Lay Down nodelocaldns Template ----------------- 8.66s
etcd : Check certs | Register ca and etcd admin/member certs on etcd hosts ----------------- 8.21s
kubernetes/preinstall : Create kubernetes directories -------------------------------------- 8.10s
container-engine/containerd : containerd | Remove orphaned binary -------------------------- 7.97s
etcd : Check certs | Register ca and etcd admin/member certs on etcd hosts ----------------- 7.86s
network_plugin/calico : Get current calico cluster version --------------------------------- 7.79s
container-engine/crictl : extract_file | Unpacking archive --------------------------------- 7.74s
```

10. Подготваливаем локальный ПК. Устанавливаем зависимости из директории /kubespray

```
sudo pip3 install -r requirements.txt
```

11. Настриваем удаленное подключение к кластеру

- Для удаленного подключения к класетру выполним настройку доступа обычного пользователя на локальной ОС
  - Необходимо предварительно знать внешний ip адрес управляющей ноды для вставки его в будущий конфиг на локальной ОС
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



12. Удаленое подключение настроено

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

## Ответ:

1. 5 нод развернуты на Яндекс.Облаке с помощью утилиты `yc`

* Скрипт для создания ВМ

```sh
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


2. Решение задачи №1 выполнено именно там.

* Созданные ВМ для установки на них кластера Kubernetes
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


---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
