# Домашнее задание к занятию "12.1 Компоненты Kubernetes" - Захаров Сергей Николаевич

Вы DevOps инженер в крупной компании с большим парком сервисов. Ваша задача — разворачивать эти продукты в корпоративном кластере. 

## Задача 1: Установить Minikube

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.

### Как поставить на AWS:
```
- создать EC2 виртуальную машину (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) с типом **t3.small**. Для работы потребуется настроить Security Group для доступа по ssh. Не забудьте указать keypair, он потребуется для подключения.
- подключитесь к серверу по ssh (ssh ubuntu@<ipv4_public_ip> -i <keypair>.pem)
- установите миникуб и докер следующими командами:
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  - chmod +x ./kubectl
  - sudo mv ./kubectl /usr/local/bin/kubectl
  - sudo apt-get update && sudo apt-get install docker.io conntrack -y
  - curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
- проверить версию можно командой minikube version
- переключаемся на root и запускаем миникуб: minikube start --vm-driver=none
- после запуска стоит проверить статус: minikube status
- запущенные служебные компоненты можно увидеть командой: kubectl get pods --namespace=kube-system
```
### Для сброса кластера стоит удалить кластер и создать заново:
- minikube delete
- minikube start --vm-driver=none

Возможно, для повторного запуска потребуется выполнить команду: sudo sysctl fs.protected_regular=0

Инструкция по установке Minikube - [ссылка](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**Важно**: t3.small не входит во free tier, следите за бюджетом аккаунта и удаляйте виртуалку.

**Ответ:**

#### Установка minikube на локальной ОС Linux

1. Скачиваем по ссылке minikube
```
root@PC-Ubuntu:~# mc

root@PC-Ubuntu:~# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 69.2M  100 69.2M    0     0  9390k      0  0:00:07  0:00:07 --:--:-- 9895k
```
2. Делаем файл исполняемым
```
root@PC-Ubuntu:~# chmod +x minikube
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep minikube
-rwxr-xr-x  1 root    root     70M мая 31 22:45 minikube
```
3. Запускаем установку в директорию `/usr/local/bin/`
```
sudo install minikube /usr/local/bin/
```
4. Для создания ВМ в Virtualbox переходим в пользовательскую УЗ на локальной ОС и запускаем `minikube start --vm-driver=virtualbox`
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start --vm-driver=virtualbox
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе конфига пользователя
💿  Downloading VM boot image ...
    > minikube-v1.25.2.iso.sha256: 65 B / 65 B [-------------] 100.00% ? p/s 0s
    > minikube-v1.25.2.iso: 237.06 MiB / 237.06 MiB [] 100.00% 9.77 MiB p/s 24s
👍  Запускается control plane узел minikube в кластере minikube
💾  Скачивается Kubernetes v1.23.3 ...
    > preloaded-images-k8s-v17-v1...: 505.68 MiB / 505.68 MiB  100.00% 9.69 MiB
🔥  Creating virtualbox VM (CPUs=2, Memory=3900MB, Disk=20000MB) ...
🐳  Подготавливается Kubernetes v1.23.3 на Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
    ▪ Используется образ gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Компоненты Kubernetes проверяются ...
🌟  Включенные дополнения: storage-provisioner, default-storageclass
🏄  Готово! kubectl настроен для использования кластера "minikube" и "default" пространства имён по умолчанию

```
5. Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Stopped
kubelet: Stopped
apiserver: Stopped
kubeconfig: Stopped

```
6. Запуск
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе существующего профиля
👍  Запускается control plane узел minikube в кластере minikube
🔄  Перезагружается существующий virtualbox VM для "minikube" ...
🐳  Подготавливается Kubernetes v1.23.3 на Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Используется образ gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Компоненты Kubernetes проверяются ...
🌟  Включенные дополнения: storage-provisioner, default-storageclass
🏄  Готово! kubectl настроен для использования кластера "minikube" и "default" пространства имён по умолчанию
```
7. Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```
*Сервисы
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3d12h
```
* Поды
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods --namespace=kube-system
NAME                               READY   STATUS    RESTARTS      AGE
coredns-64897985d-wfr44            1/1     Running   1 (18h ago)   3d15h
etcd-minikube                      1/1     Running   1 (18h ago)   3d15h
kube-apiserver-minikube            1/1     Running   1 (18h ago)   3d15h
kube-controller-manager-minikube   1/1     Running   1 (18h ago)   3d15h
kube-proxy-lqzfd                   1/1     Running   1 (18h ago)   3d15h
kube-scheduler-minikube            1/1     Running   1 (18h ago)   3d15h
storage-provisioner                1/1     Running   4 (49m ago)   3d15h
```

## Задача 2: Запуск Hello World
После установки Minikube требуется его проверить. Для этого подойдет стандартное приложение hello world. А для доступа к нему потребуется ingress.

- развернуть через Minikube тестовое приложение по [туториалу](https://kubernetes.io/ru/docs/tutorials/hello-minikube/#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-minikube)
- установить аддоны ingress и dashboard


**Ответ:**

#### Создание докер-образа для контейнера на основе файлов `Dockerfile` и `server.js`
1. Подготовка файлов
* Dockerfile
```
FROM node:6.14.2
EXPOSE 8080
COPY server.js .
CMD [ "node", "server.js" ]

```
* server.js
```
var http = require('http');

var handleRequest = function(request, response) {
  console.log('Получен запрос на URL: ' + request.url);
  response.writeHead(200);
  response.end('Hello World!');
};
var www = http.createServer(handleRequest);
www.listen(8080);

```
2. Создание образа. 
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker build -t zakharovnpa/k8s-hello-world:05.06.22 .
Sending build context to Docker daemon  2.111GB
Step 1/4 : FROM node:6.14.2
6.14.2: Pulling from library/node
3d77ce4481b1: Pull complete 
7d2f32934963: Pull complete 
0c5cf711b890: Pull complete 
9593dc852d6b: Pull complete 
4e3b8a1eb914: Pull complete 
ddcf13cc1951: Pull complete 
2e460d114172: Pull complete 
d94b1226fbf2: Pull complete 
Digest: sha256:62b9d88be259a344eb0b4e0dd1b12347acfe41c1bb0f84c3980262f8032acc5a
Status: Downloaded newer image for node:6.14.2
 ---> 00165cd5d0c0
Step 2/4 : EXPOSE 8080
 ---> Using cache
 ---> bb7eaf408861
Step 3/4 : COPY server.js .
 ---> Using cache
 ---> dc44ddc3dd2a
Step 4/4 : CMD [ "node", "server.js" ]
 ---> Using cache
 ---> ce35230a77b3
Successfully built ce35230a77b3
Successfully tagged zakharovnpa/k8s-hello-world:05.06.22

```
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker image list
REPOSITORY                                                          TAG               IMAGE ID       CREATED          SIZE
zakharovnpa/k8s-hello-world                                         05.06.22          ce35230a77b3   25 hours ago    660MB
```
#### Перенос образа приложения, созданного на основании Dockerfile и Server.js в DockerHub

* Пушим образ на DockerHub:
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker push zakharovnpa/k8s-hello-world:05.06.22
The push refers to repository [docker.io/zakharovnpa/k8s-hello-world]
a4c7d3a9dd6f: Pushed 
aeaa1edefd60: Mounted from library/node 
6e650662f0e3: Mounted from library/node 
8c825a971eaf: Mounted from library/node 
bf769027dbbd: Mounted from library/node 
f3693db46abb: Mounted from library/node 
bb6d734b467e: Mounted from library/node 
5f349fdc9028: Mounted from library/node 
2c833f307fd8: Mounted from library/node 
05.06.22: digest: sha256:1ea8575845aa74617f31afd497856fc2b12e6f0fe21c002638e67e02ac089d0a size: 2214
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# 

```
[Репозиторий для создания образа](https://hub.docker.com/repository/docker/zakharovnpa/k8s-hello-world)


#### Запуск деплоймента
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create deployment k8s-hello-world --image=zakharovnpa/k8s-hello-world:05.06.22
deployment.apps/k8s-hello-world created
```
* Смотрим информацию о Deployment
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
k8s-hello-world   1/1     1            1           18h
```
* Смотрим информацию о поде
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                               READY   STATUS             RESTARTS         AGE
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0                22m
```
* Смотрим `kubectl` конфигурацию
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/maestro/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Sun, 05 Jun 2022 12:26:01 +04
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: cluster_info
    server: https://192.168.59.100:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sun, 05 Jun 2022 12:26:01 +04
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /home/maestro/.minikube/profiles/minikube/client.crt
    client-key: /home/maestro/.minikube/profiles/minikube/client.key

```
#### Создание сервиса
* Создаем сервис
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl expose deployment k8s-hello-world --type=LoadBalancer --port=8080
service/k8s-hello-world exposed
```
* Смотрим сервис
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get services
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
k8s-hello-world   LoadBalancer   10.100.178.38   <pending>     8080:32429/TCP   3m40s
kubernetes        ClusterIP      10.96.0.1      <none>        443/TCP          5d15h
```

#### Запуск Dashboard
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube dashboard
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:36107/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...

```
![dashboard_01](/12-kubernetes-01-intro/Files/dashboard_01.png)


#### Установка аддонов ingress и dashboard
1.  Смортим какие установлены аддоны (листинг сокращен):
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube addons list
|-----------------------------|----------|--------------|--------------------------------|
|         ADDON NAME          | PROFILE  |    STATUS    |           MAINTAINER           |
|-----------------------------|----------|--------------|--------------------------------|                   |
| default-storageclass        | minikube | enabled ✅   | kubernetes                     |
| storage-provisioner         | minikube | enabled ✅   | google                         |              |
|-----------------------------|----------|--------------|--------------------------------|

```

2. Устанавливаем аддон ingress:
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube addons enable ingress
    ▪ Используется образ k8s.gcr.io/ingress-nginx/controller:v1.1.1
    ▪ Используется образ k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
    ▪ Используется образ k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
🔎  Verifying ingress addon...
🌟  The 'ingress' addon is enabled

```
3. Устанавливаем аддон dashboard:
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube addons enable dashboard
    ▪ Используется образ kubernetesui/dashboard:v2.3.1
    ▪ Используется образ kubernetesui/metrics-scraper:v1.0.7
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

	minikube addons enable metrics-server	


🌟  The 'dashboard' addon is enabled
```

4. Смотрим какие установлены новые аддоны (листинг сокращен):
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube addons list
|-----------------------------|----------|--------------|--------------------------------|
|         ADDON NAME          | PROFILE  |    STATUS    |           MAINTAINER           |
|-----------------------------|----------|--------------|--------------------------------|
| dashboard                   | minikube | enabled ✅   | kubernetes                     |
| default-storageclass        | minikube | enabled ✅   | kubernetes                     |
| ingress                     | minikube | enabled ✅   | unknown (third-party)          |
| storage-provisioner         | minikube | enabled ✅   | google                         |
|-----------------------------|----------|--------------|--------------------------------|

```


## Задача 3: Установить kubectl

Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl.
- подключиться к minikube 
- проверить работу приложения из задания 2, запустив port-forward до кластера

**Ответ:**

#### Установка kubectl

1.  Установка kubectl была выполнена до выполнения Задачи №1.
```
root@PC-Ubuntu:~# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 43.5M  100 43.5M    0     0  9296k      0  0:00:04  0:00:04 --:--:-- 9489k
```
* Делаем файл исполняемым
```
root@PC-Ubuntu:~# chmod +x kubectl
```
* Переносим в каталог `/usr/local/bin/`
```
root@PC-Ubuntu:~# mv kubectl /usr/local/bin/
```
```
root@PC-Ubuntu:~# ls -lha /usr/local/bin/ | grep kubectl
-rwxr-xr-x  1 root root  44M мая 31 23:10 kubectl
```
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# kubectl version
Kustomize Version: v4.5.4
```
#### Подключаемся к minikube и проверяем работу приложения из задания 2, запустив port-forward до кластера
* Находим наш под
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get po -o wide
NAME                               READY   STATUS             RESTARTS          AGE   IP            NODE       NOMINATED NODE   READINESS GATES
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0                 30h   172.17.0.11   minikube   <none>           <none>
```
* Включаем сервис
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl expose deployment k8s-hello-world --type=LoadBalancer --port=8080
service/k8s-hello-world exposed
```
*
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube service list
|----------------------|------------------------------------|--------------|-----------------------------|
|      NAMESPACE       |                NAME                | TARGET PORT  |             URL             |
|----------------------|------------------------------------|--------------|-----------------------------|
| default              | k8s-hello-world                    |         8080 | http://192.168.59.100:32429 |
|----------------------|------------------------------------|--------------|-----------------------------|

```

* Команда `minikube service k8s-hello-world` не дает никакого вывода:
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube service k8s-hello-world
maestro@PC-Ubuntu:~/Рабочий стол$ 

```

* Запускаем port-forwarding с порта 8080 на порт 8080. Работает до тех пор, пока не сделаем Ctrl-C
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl port-forward k8s-hello-world-6969845fcf-5v7xk 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
Handling connection for 8080
```
* В другом окне терминала запускае curl и получаем ответ от сервиса:
```
root@PC-Ubuntu:~# curl http://127.0.0.1:8080
Hello World!
```
* В браузере ответ от сервиса:

![curl_hello-world_01](/12-kubernetes-01-intro/Files/curl_hello-world_01.png)


## Задача 4 (*): собрать через ansible (необязательное)

Профессионалы не делают одну и ту же задачу два раза. Давайте закрепим полученные навыки, автоматизировав выполнение заданий  ansible-скриптами. При выполнении задания обратите внимание на доступные модули для k8s под ansible.
 - собрать роль для установки minikube на aws сервисе (с установкой ingress)
 - собрать роль для запуска в кластере hello world
  
  ---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
