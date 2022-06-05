## Ход выполнения ДЗ к занятию "12.1 Компоненты Kubernetes"

Вы DevOps инженер в крупной компании с большим парком сервисов. Ваша задача — разворачивать эти продукты в корпоративном кластере. 

## Задача 1: Установить Minikube

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.

### Как поставить на AWS:
- создать EC2 виртуальную машину (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) с типом **t3.small**. Для работы потребуется настроить Security Group для доступа по ssh. Не забудьте указать keypair, он потребуется для подключения.
- подключитесь к серверу по ssh `(ssh ubuntu@<ipv4_public_ip> -i <keypair>.pem)`
- установите миникуб и докер следующими командами:
  
```
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  
  - chmod +x ./kubectl
  - sudo mv ./kubectl /usr/local/bin/kubectl
  - sudo apt-get update && sudo apt-get install docker.io conntrack -y
  - curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```
  
- проверить версию можно командой `minikube version`
- переключаемся на root и запускаем миникуб:` minikube start --vm-driver=none`
- после запуска стоит проверить статус: `minikube status`
- запущенные служебные компоненты можно увидеть командой: `kubectl get pods --namespace=kube-system`

### Для сброса кластера стоит удалить кластер и создать заново:
- `minikube delete`
- `minikube start --vm-driver=none`

Возможно, для повторного запуска потребуется выполнить команду: `sudo sysctl fs.protected_regular=0`

Инструкция по установке Minikube - [ссылка](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**Важно**: t3.small не входит во free tier, следите за бюджетом аккаунта и удаляйте виртуалку.

**Ответ:**
1. Все ответы на ДЗ должны располагаться каждый в своем репозитории
* Репозиторий ДЗ
2. ДЗ выполнять, используя PyCharm, запуская его от пользователя root
```
root@PC-Ubuntu:~# whereis pycharm
pycharm: /opt/pycharm-community-2022.1/bin/pycharm64.vmoptions /opt/pycharm-community-2022.1/bin/pycharm.svg /opt/pycharm-community-2022.1/bin/pycharm.png /opt/pycharm-community-2022.1/bin/pycharm.sh
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# cd /opt/pycharm-community-2022.1/bin
root@PC-Ubuntu:/opt/pycharm-community-2022.1/bin# 
root@PC-Ubuntu:/opt/pycharm-community-2022.1/bin# ./pycharm.sh
```
![screen-pycharm-root](/12-kubernetes-01-intro/Files/screen-pycharm-root.png)

3. Устанавливаем локально kubectl [Установка и настройка kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)
4. Устанавливаем локально на ВМ minikube [Установка Minikube](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**Ответ:**

#### Ход выполнения вопроса №1
1. Проверка того, что Linux и процессор поддерживает виртуализацию. Вывод не должен быть пкстым.
```
root@PC-Ubuntu:~# grep -E --color 'vmx|svm' /proc/cpuinfo
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
root@PC-Ubuntu:~# 

```
#### Установка minikube

2. Скачиваем по ссылке minikube
```
root@PC-Ubuntu:~# mc

root@PC-Ubuntu:~# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 69.2M  100 69.2M    0     0  9390k      0  0:00:07  0:00:07 --:--:-- 9895k
```
3. Делаем файл исполняемым
```
root@PC-Ubuntu:~# chmod +x minikube
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep minikube
-rwxr-xr-x  1 root    root     70M мая 31 22:45 minikube
```
4. Запускаем установку в директорию `/usr/local/bin/`
```
sudo install minikube /usr/local/bin/
```
5. 
```
minikube start --vm-driver=virtualbox
```

6. Результат выполнения командв установки
```
root@PC-Ubuntu:~# minikube start --vm-driver=virtualbox
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе конфига пользователя
🛑  The "virtualbox" driver should not be used with root privileges.
💡  If you are running minikube within a VM, consider using --driver=none:
📘    https://minikube.sigs.k8s.io/docs/reference/drivers/none/

❌  Exiting due to DRV_AS_ROOT: The "virtualbox" driver should not be used with root privileges.

```
* Установка Cubectl
```
root@PC-Ubuntu:~# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 43.5M  100 43.5M    0     0  9296k      0  0:00:04  0:00:04 --:--:-- 9489k
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rw-r--r--  1 root    root     44M мая 31 23:10 kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# chmod +x kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rwxr-xr-x  1 root    root     44M мая 31 23:10 kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# mv kubectl /usr/local/bin/
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha /usr/local/bin/ | grep kubectl
-rwxr-xr-x  1 root root  44M мая 31 23:10 kubectl

```


7. Проверяем статус minikube
```
root@PC-Ubuntu:~# minikube status
🤷  Profile "minikube" not found. Run "minikube profile list" to view all profiles.
👉  To start a cluster, run: "minikube start"

```
8. Для создания ВМ в Virtualbox переходим в пользовательскую УЗ и запускаем `minikube start --vm-driver=none`. Получаем ошибку.
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start --vm-driver=none
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер none на основе конфига пользователя

🤷  Exiting due to PROVIDER_NONE_NOT_FOUND: The 'none' provider was not found: running the 'none' driver as a regular user requires sudo permissions

maestro@PC-Ubuntu:~/Рабочий стол$ 
```
9. Для создания ВМ в Virtualbox переходим в пользовательскую УЗ на локальной ОС и запускаем `minikube start --vm-driver=virtualbox`
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
* 10 Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Stopped
kubelet: Stopped
apiserver: Stopped
kubeconfig: Stopped

```
* 11 Запуск
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
* 12 Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3d12h
```
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
#### Создание докер-образа для контейнера на основе файлов
* Dockerfile
```
FROM node:6.14.2
EXPOSE 8080
COPY server.js .
CMD [ "node", "server.js" ]

```
server.js
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
* Создание образа
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker build .
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
 ---> Running in ffba5dc28dd7
Removing intermediate container ffba5dc28dd7
 ---> bb7eaf408861
Step 3/4 : COPY server.js .
 ---> dc44ddc3dd2a
Step 4/4 : CMD [ "node", "server.js" ]
 ---> Running in c180a54ca83c
Removing intermediate container c180a54ca83c
 ---> ce35230a77b3
Successfully built ce35230a77b3

```

```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker image list
REPOSITORY                                                          TAG               IMAGE ID       CREATED          SIZE
node/hellow-world                                                   1.0               ce35230a77b3   44 minutes ago   660MB
node                                                                6.14.2            00165cd5d0c0   3 years ago      660MB
```
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker run --name=hellow-world -d ce35230a77b3
d5790a5e17fe6b56ac951eda96d0c9aee5bf364d91dcc1451451703ad7369a1b
```
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker ps
CONTAINER ID   IMAGE          COMMAND            CREATED         STATUS         PORTS      NAMES
d5790a5e17fe   ce35230a77b3   "node server.js"   6 seconds ago   Up 5 seconds   8080/tcp   hellow-world

```
#### Запуск 
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create deployment hello-world --image=node/hellow-world:1.0
deployment.apps/hello-world created
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get deployments
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   0/1     1            0           10s
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get deployments
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
hello-world   0/1     1            0           10s
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube dashboard
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
🎉  Opening http://127.0.0.1:33807/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                         READY   STATUS             RESTARTS   AGE
hello-world-9b56d5d7-q2sww   0/1     ImagePullBackOff   0          9m56s

```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get events
LAST SEEN   TYPE      REASON              OBJECT                            MESSAGE
18m         Normal    Scheduled           pod/hello-world-9b56d5d7-q2sww    Successfully assigned default/hello-world-9b56d5d7-q2sww to minikube
17m         Normal    Pulling             pod/hello-world-9b56d5d7-q2sww    Pulling image "node/hellow-world:1.0"
17m         Warning   Failed              pod/hello-world-9b56d5d7-q2sww    Failed to pull image "node/hellow-world:1.0": rpc error: code = Unknown desc = Error response from daemon: pull access denied for node/hellow-world, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
17m         Warning   Failed              pod/hello-world-9b56d5d7-q2sww    Error: ErrImagePull
3m48s       Normal    BackOff             pod/hello-world-9b56d5d7-q2sww    Back-off pulling image "node/hellow-world:1.0"
17m         Warning   Failed              pod/hello-world-9b56d5d7-q2sww    Error: ImagePullBackOff
18m         Normal    SuccessfulCreate    replicaset/hello-world-9b56d5d7   Created pod: hello-world-9b56d5d7-q2sww
18m         Normal    ScalingReplicaSet   deployment/hello-world            Scaled up replica set hello-world-9b56d5d7 to 1

```
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/maestro/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Fri, 03 Jun 2022 20:41:53 +04
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
        last-update: Fri, 03 Jun 2022 20:41:53 +04
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
* Экспорт переменных для работы  Docker и Minikebe
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube -p minikube docker-env
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.59.100:2376"
export DOCKER_CERT_PATH="/home/maestro/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"

# To point your shell to minikube's docker-daemon, run:
# eval $(minikube -p minikube docker-env)

```
* После редактирования .bashrc:
```
source .bashrc
```


#### Перенос образа приложения, созданного на основании Dockerfile и Server.js в DockerHub
```
root@PC-Ubuntu:/home/maestro/.minikube/machines/minikube# docker build -t zakharovnpa/k8s-hello-world:05.06.22 .
Sending build context to Docker daemon  3.121GB
Step 1/4 : FROM node:6.14.2
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
REPOSITORY                                                          TAG               IMAGE ID       CREATED         SIZE
node/hellow-world                                                   1.0               ce35230a77b3   25 hours ago    660MB
zakharovnpa/k8s-hello-world                                         05.06.22          ce35230a77b3   25 hours ago    660MB
registry                                                            latest            773dbf02e42e   9 days ago      24.1MB
some_docker_build                                                   latest            b79a8a0840b1   3 weeks ago     427MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             latest            b79a8a0840b1   3 weeks ago     427MB
registry.gitlab.com/zakharovnpa/gitlablesson                        latest            e87a0e154f99   3 weeks ago     427MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             <none>            e87a0e154f99   3 weeks ago     427MB
docker                                                              dind              c89d806adeb8   4 weeks ago     236MB
docker                                                              latest            da88b5cbcdd8   4 weeks ago     219MB
gitlab/gitlab-runner                                                latest            89944ac4ab2c   4 weeks ago     691MB
registry.gitlab.com/gitlab-org/gitlab-runner/gitlab-runner-helper   x86_64-f761588f   257667c17e33   4 weeks ago     66.9MB
centos                                                              7                 eeb6ee3f44bd   8 months ago    204MB
docker                                                              20.10.5-dind      0a9822c8848d   14 months ago   258MB
docker                                                              20.10.5           1588477122de   14 months ago   241MB
node                                                                6.14.2            00165cd5d0c0   3 years ago     660MB
```
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

#### Тестирование работы приложения
1. Запуск создания Deployment
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create deployment k8s-hello-world --image=zakharovnpa/k8s-hello-world:05.06.22
deployment.apps/k8s-hello-world created
```
2. 

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

4. Смортим какие установлены новые аддоны (листинг сокращен):
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
#### Разворачивание через Minikube тестового приложения
1. 

## Задача 3: Установить kubectl

Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl.
- подключиться к minikube 
- проверить работу приложения из задания 2, запустив port-forward до кластера

**Ответ:**
#### 1. Подключаемся к minikube 
```

```
    

#### 2.Установка kubectl
1. Установлен

```
root@PC-Ubuntu:~# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 43.5M  100 43.5M    0     0  9296k      0  0:00:04  0:00:04 --:--:-- 9489k
```
```
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rw-r--r--  1 root    root     44M мая 31 23:10 kubectl
```
```
root@PC-Ubuntu:~# chmod +x kubectl
```
```
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rwxr-xr-x  1 root    root     44M мая 31 23:10 kubectl
```
```
root@PC-Ubuntu:~# mv kubectl /usr/local/bin/
```
```
root@PC-Ubuntu:~# ls -lha | grep kubectl
```
```
root@PC-Ubuntu:~# ls -lha /usr/local/bin/ | grep kubectl
-rwxr-xr-x  1 root root  44M мая 31 23:10 kubectl

```
```
maestro@PC-Ubuntu:~/Рабочий стол$ whereis kubectl
kubectl: /usr/local/bin/kubectl

```

## Задача 4 (*): собрать через ansible (необязательное)

Профессионалы не делают одну и ту же задачу два раза. Давайте закрепим полученные навыки, автоматизировав выполнение заданий  ansible-скриптами. При выполнении задания обратите внимание на доступные модули для k8s под ansible.
 - собрать роль для установки minikube на aws сервисе (с установкой ingress)
 - собрать роль для запуска в кластере hello world
  
  ---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
