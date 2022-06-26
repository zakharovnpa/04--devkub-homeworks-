## Лекция по теме "Развертывание кластера на собственных серверах. Часть 1"

Андрей
Копылов

### 1Андрей Копылов
TechLead
PremiumBonus
Андрей КопыловПлан занятия
1. Требования к серверам
2. Установка Control Plane
3. Установка рабочей ноды
4. Итоги
5. Домашнее задание

### 3Требования к серверам

### 4Требования для Control Plane
- CPU — от 2 ядер
- ОЗУ — от 2 ГБ
- Диск — от 50 ГБ

### 5Требования для рабочей ноды
- CPU — от 1 ядра
- ОЗУ — от 1 ГБ
- Диск — от 100 ГБ

### 6Установка Control Plane

### 7Установка зависимостей
```
- apt install apt-transport-https ca-certiﬁcates curl

- sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
https://packages.cloud.google.com/apt/doc/apt-key.gpg

- echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee \
/etc/apt/sources.list.d/kubernetes.list

- apt install kubelet kubeadm kubectl containerd
```

### 8Инициализация кластера
```
- kubeadm init
 --apiserver-advertise-address=192.168.7.4 — этот адрес слушает apiserver
 --control-plane-endpoint=master-1.k8s.lan — адрес для будущих подключений control plane
 --pod-network-cidr 10.244.0.0/16 — сеть для подов укажем сразу
``` 
 
### 9Установка рабочей ноды

### 10Установка зависимостей
```
- apt install apt-transport-https ca-certiﬁcates curl
- sudo curl -fsSLo \
/usr/share/keyrings/kubernetes-archive-keyring.gpg \
https://packages.cloud.google.com/apt/doc/apt-key.gpg

- echo "deb \
[signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee \
/etc/apt/sources.list.d/kubernetes.list

- apt install kubelet kubeadm kubectl
```

### 11Подключение к кластеру
```
- kubeadm join
- --token <token> — токен нам скажет мастер
- master-1.k8s.lan:6443
- --discovery-token-ca-cert-hash sha256:<hash> — как и весь хеш
```
Полную команду для подключения выдает мастер после
инициализации.

  
### 12Проверка статуса кластера
```
- kubectl get nodes — покажет все ноды кластера;
- kubectl get pods — покажет поды в default namespace.
```

### 13Итоги
Сегодня мы изучили:
- Требования к серверам кластера;
- Зависимости kubernetes;
- Установку кластера вручную.

### Практическая часть лекции

#### Создание ВМ в Яндекс.Облако   
- 00:22:40 - старт создания ВМ
- 00:24:30 - ВМ создалсь

```
root@mx-netology:~/netology-project/learning-kubernetes# ./list-vms.sh 
+----------------------+-------+---------------+---------+---------------+-------------+
|          ID          | NAME  |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-------+---------------+---------+---------------+-------------+
| fhm2kk0m6jpq9008haef | node1 | ru-central1-a | RUNNING | 51.250.68.170 | 10.128.0.10 |
| fhmj1nt3vp8hu7dl1b2o | node2 | ru-central1-a | RUNNING | 51.250.93.30  | 10.128.0.17 |
| fhmqrrgb2gufeq0p9607 | cp1   | ru-central1-a | RUNNING | 51.250.86.215 | 10.128.0.30 |
+----------------------+-------+---------------+---------+---------------+-------------+
```
#### Подключене к новым ВМ (нодам)
- 00:27:25 - выполняем подключени к каждой ноде для установленя ssh соединения
#### Установка мнимально необходмого ПО на управляющую ноду сз1 - 00:28:46
- 00:31:05 - старт команд
```
{
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl containerd
    sudo apt-mark hold kubelet kubeadm kubectl
}

``` 
#### Окончане установки ПО на ноду cp1  -00:33:20
1. Смотрим ip адрес интерфейса eth0 ноды cp1
```
root@cp1:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether d0:0d:1a:de:e0:b1 brd ff:ff:ff:ff:ff:ff
    inet 10.128.0.30/24 brd 10.128.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::d20d:1aff:fede:e0b1/64 scope link 
       valid_lft forever preferred_lft forever

```
#### Инициализация кластера    -00:33:25
```
# Инициализация кластера
kubeadm init \
  --apiserver-advertise-address=10.128.0.30 \   # ip адрес интерфейса eth0 ноды cp1, на котором разворачвается кластер. 
  --pod-network-cidr 10.244.0.0/16 \           # настройк сети для кластера нод
  --apiserver-cert-extra-sans=51.250.86.215  # внешний адрес уластера, на который можно будет удаленное подключаться. Н
                                               # На это адрес будет выписан сертифкат
```
- Готовые команды для создания кластера
```
kubeadm init \
  --apiserver-advertise-address=10.128.0.30 \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-cert-extra-sans=51.250.86.215
```


#### Запуск создания кластера  `kubeadm init`  -00:36:30
- Получили ошибку
```
[init] Using Kubernetes version: v1.24.2
[preflight] Running pre-flight checks
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
	[ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher

```
- 00:37:40 - исправляем ошибку
```
# При проверке возникнет ошибка. Исправим ее.
# Для сохранения работоспособности после перезагрузки сервера выполним такие команды:
modprobe br_netfilter 
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-arptables=1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf
```
- Проверка установки  `sysctl -p /etc/sysctl.conf`
```
root@cp1:~# sysctl -p /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
```
#### Вторая попытка нцализации кластера   -00:37:48
```
kubeadm init \
  --apiserver-advertise-address=10.128.0.30 \
  --pod-network-cidr 10.244.0.0/16 \
  --apiserver-cert-extra-sans=51.250.86.215
```
#### Окончание инициализации кластера   -00:39:50
```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.128.0.30:6443 --token prrf8x.l3hg5d6vo06c3y56 \
	--discovery-token-ca-cert-hash sha256:c39159ad4513b4455bb8fc75b10ed8a1ef7cab3a4823f4fde3e7ba439712dd58
```
- 00:40:50 - мы получили команду для присоединения рабочих нод к кластеру
```
kubeadm join 10.128.0.30:6443 --token prrf8x.l3hg5d6vo06c3y56 \
	--discovery-token-ca-cert-hash sha256:c39159ad4513b4455bb8fc75b10ed8a1ef7cab3a4823f4fde3e7ba439712dd58
```
- 00:41:40 - To start using your cluster, you need to run the following as a regular user:
```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
- Проверяем подключение к кластеру. Подключения пока еще нет
```
root@cp1:~# kubectl get nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```
- 00:42:30 - Выполняем команды как рекомендует Kubernetes:
```
{
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
```
- Успешное подключение к кластеру
```
root@cp1:~# kubectl get nodes
NAME   STATUS     ROLES           AGE   VERSION
cp1    NotReady   control-plane   14m   v1.24.2

```
- 00:42:45 - получилось но не до конца. На надо с кластером общаться под обычным пользователем.
- 00:43:10 - подключение под обычным пользователем:
```
yc-user@cp1:~$ kubectl get nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```
- Под обычным пользователем подключены к кластеру
```
yc-user@cp1:~$ kubectl get nodes
NAME   STATUS     ROLES           AGE   VERSION
cp1    NotReady   control-plane   19m   v1.24.2
```
- 00:44:00 - В дальнейшем подключимся к кластеру с уделенного ПК
#### Определение причны состояния ноды cp1 `NotReady`    - 00:44:20
- 00:44:50 - Нода cp1 в состоянии NotReady по причине `container runtime network not ready`
```
yc-user@cp1:~$ kubectl describe nodes cp1 | grep KubeletNotReady
  Ready            False   Sun, 26 Jun 2022 07:30:25 +0000   Sun, 26 Jun 2022 07:09:43 +0000   KubeletNotReady              container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:Network plugin returns error: cni plugin not initialized
```
- Причина - не установлено ни одного плагина для работы сети
#### Установка сетевого плагина Flanel  - 00:45:50
- Установка CNI flannel
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

```
yc-user@cp1:~$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
Warning: policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
podsecuritypolicy.policy/psp.flannel.unprivileged created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.apps/kube-flannel-ds created
```
- Результат выполненя: Status Ready
```
yc-user@cp1:~$ kubectl get nodes
NAME   STATUS   ROLES           AGE   VERSION
cp1    Ready    control-plane   33m   v1.24.2

```


### 14Домашнее задание
Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера
Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 15Задавайте вопросы и
пишите отзыв о лекции!
Андрей Копылов
Андрей Копылов
16
