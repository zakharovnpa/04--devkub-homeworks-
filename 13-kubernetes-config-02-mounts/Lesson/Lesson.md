## Ход выполнения ДЗ по теме "13.2 разделы и монтирование"

Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.
Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
* установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
* добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
* установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner






### Пояснения преподавателя:
1. Данные команды выполнять на локальной ОС, на которой установлен kubectl
2. Все делается через API кластера
3. Инсталляция Helm, NFS будет произведена а кластереKubernetes

В конце установки будет выдан пример создания PVC для этого сервера.

## Подготовка к выполнению ДЗ.
1. На локальной ОС с УЗ, с которой kubectl управляет кластером

### Установка Helm и NFS

```
controlplane $ kubectl get storageclasses.storage.k8s.io
No resources found
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         66d
node01         0         66d
```

#### Установка helm 
```shell script
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
```
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   311k      0 --:--:-- --:--:-- --:--:--  311k
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
```

#### Добавление репозитория чартов 
```shell script
helm repo add stable https://charts.helm.sh/stable && helm repo update
```
```
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
```
#### Установка nfs-server через helm 
```shell script
helm install nfs-server stable/nfs-server-provisioner
```
```
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Jul 14 14:39:43 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
```

#### Для того, чтобы при создании PVC на подах не возникала следующая проблема (поды зависнут в статусе ContainerCreating)
необходимо вначале на всех нодах установить утилиту "nfs-common":
```shell script
Output: mount: /var/lib/kubelet/pods/f760c19e-6ec0-46e8-9a3a-d6187fd927e8/volumes/kubernetes.io~nfs/pvc-d3134d79-c2ce-41a2-af72-0f2d45c5c19e:
bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
```
#### Решение проблемы (необходимо установить на всех нодах !!!):
```
sudo apt install nfs-common - для debian/ubuntu
```
```
controlplane $ sudo apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (1897 kB/s)   
Selecting previously unselected package libtirpc-common.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1_all.deb ...
Unpacking libtirpc-common (1.2.5-1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
```


## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

### Пояснения преподавателя:
1. В одном поде есть нескольо контейнеров и одна общая папка, к которой эти контейнеры имеют доступ на запись и чтение
2. Создать файл, в котором можно обмениваться информацией между контейнерами

### Ход выполнения задания

#### 1. Ручное управление Persistent Volume 
Для постоянного хранения данных в Kubernetes используются несколько объектов:
- PersistentVolume - выделенный том на ноде, в котором хранятся данные; 
- PersistentVolumeClaim - запрос (заявка) на выделение тома на ноде;
- StorageClass - класс хранилища, можно создавать самостоятельно при наличии provisioner.

Пока сосредоточимся на PersistentVolume и PersistentVolumeClaim.

#### 2. Схема работы
При ручном создании томов схема выглядит так:
- админ создает PersistentVolume;
- разработчик указывает характеристики необходимого тома;
- при развертывании приложения происходит какая-то магия и все работает.

#### 3. На ноде Админ создает папку `/data/pv`. 

```
mkmdir -p data/pv
```
#### Создадим PersistentVolume с именем "pv" в поде (можно вместе манифестом пода)

* pv.yaml
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
```shell script
kubectl apply -f pv.yaml
```

4. Создадим PersistentVolumeClaim с именем pvc
* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi

```

```shell script
kubectl apply -f pvc.yaml
```
5. Проверяем запущен нормально ли под

```
kubectl get po
```

6. В данном примере мы использовали самый простой тип PersistentVolume - `hostPath`. 
При его использовании данные помещаются **на ноде** в указанной папке.
Этот тип очень удобен для демонстрации возможностей PersistentVolume.
 
Проверим это
```shell script
# Создаем файл привычным способом
kubectl exec pod -- sh -c "echo 42 > /static/42.txt"
```
```sh
# запускаем на ноде
ls -la /data/pv
cat /data/pv/42.txt
```
```
# Запишем новый файл на ноде
echo 43 | sudo tee /data/pv/43.txt
```
```
# Проверяем наличие файлов в поде
kubectl exec pod -c nginx -- ls -la /static
kubectl exec pod -c nginx -- cat /static/43.txt
```

Таким образом файлы доступны на ноде и в поде.

7.  Постоянство данных с использованием PersistentVolume
Нужно проверить останутся ли данные после удаления пода.
```shell script
kubectl delete po pod
```
```
# запускаем на ноде
ls -la /data/pv
# Данные на ноде остались 
```
```
# Проверим состояние PersistentVolume и PersistentVolumeClaim
kubectl get pv,pvc
# Тут тоже все в порядке. Ничего не удалилось все работает.
```

8. Мы увидим, что данные сохранились.
Пересоздадим под и убедимся, что в поде все так же доступны данные.
```shell script
# Создаем под заново
kubectl apply -f templates/10-pod.yaml
```
```
# Проверяем доступность данных
kubectl exec pod -- ls -la /static
```
Все данные на месте.
Наконец-то все работает как нужно.


## Связывание PersistentVolume и PersistentVolumeClaim

* Пример манифеста PersistentVolumeClaim
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
* Пример манифеста PersistentVolume
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
  persistentVolumeReclaimPolicy: Retain
```

### Ход выполнения ДЗ

1. Манифесты Stage-front-back.yaml

```
# Config Deployment Frontend & Backend
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/data/pv"
              name: my-volume
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc

        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/data/pv"
              name: my-volume
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: stage
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod

```

2. Манифесты Prod

```
```

3. Сервисы

* pv.yaml
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
* pod.yaml
```yml
---
apiVersion: v1
kind: Pod
metadata:
  name: pod
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
      - mountPath: "/data/pv"
        name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```


#### Логи настроек

# Установка helm 
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Добавление репозитория чартов 
helm repo add stable https://charts.helm.sh/stable && helm repo update

# Установка nfs-server через helm 
helm install nfs-server stable/nfs-server-provisioner

# В дальнейшем при создании PVC, на подах может возникнуть следующая проблема (поды зависнут в статусе ContainerCreating):
Output: mount: /var/lib/kubelet/pods/f760c19e-6ec0-46e8-9a3a-d6187fd927e8/volumes/kubernetes.io~nfs/pvc-d3134d79-c2ce-41a2-af72-0f2d45c5c19e:
bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.

# Решение проблемы (необходимо установить на всех нодах !!!):
sudo apt install nfs-common - для debian/ubuntu

1. Перед деплоем создать namespace stage, создать директорию /data/pv

```
controlplane $ 
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ pwd    
/root
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f .
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po, svc
error: arguments in resource/name form must have a single resource and name
controlplane $ 
controlplane $ kubectl get -n stage po,svc
NAME                          READY   STATUS              RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   0/2     ContainerCreating   0          22s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   22s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          33s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   33s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod configured
service/fb-pod unchanged
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n po,svc,pv,pvc
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          11m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          36s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   11m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ping
Usage: ping [-aAbBdDfhLnOqrRUvV64] [-c count] [-i interval] [-I interface]
            [-m mark] [-M pmtudisc_option] [-l preload] [-p pattern] [-Q tos]
            [-s packetsize] [-S sndbuf] [-t ttl] [-T timestamp_option]
            [-w deadline] [-W timeout] [hop1 ...] destination
Usage: ping -6 [-aAbBdDfhLnOqrRUvV] [-c count] [-i interval] [-I interface]
             [-l preload] [-m mark] [-M pmtudisc_option]
             [-N nodeinfo_option] [-p pattern] [-Q tclass] [-s packetsize]
             [-S sndbuf] [-t ttl] [-T timestamp_option] [-w deadline]
             [-W timeout] destination
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- cd / && ls -lha
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "e920216496551a6277af8a57f7c8134c4fe4e33e5e460395f80f8336f435deb1": OCI runtime exec failed: exec failed: unable to start container process: exec: "cd": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha        
total 28K
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls cd  
ls: cannot access 'cd': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls cd /
ls: cannot access 'cd': No such file or directory
/:
app  boot  etc   lib    media  opt   root  sbin  sys  usr
bin  dev   home  lib64  mnt    proc  run   srv   tmp  var
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha
total 28K
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls ls /root/
ls: cannot access 'ls': No such file or directory
/root/:
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls /root/
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha /root/
total 28K
drwx------ 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  570 Jan 31  2010 .bashrc
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .cache
drwxr-xr-x 3 root root 4.0K Jul  4 12:31 .local
-rw-r--r-- 1 root root  148 Aug 17  2015 .profile
-rw------- 1 root root    0 Jun 23 11:23 .python_history
-rw-r--r-- 1 root root  254 Jun 23 11:27 .wget-hsts
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          16m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          5m51s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   16m
controlplane $ 
controlplane $ kubectl apply -f pv.yaml               
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod unchanged
service/fb-pod unchanged
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m34s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           19s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m36s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           21s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m41s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           26s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m43s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           28s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m46s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           31s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Running   0          19m
fb-pod-769d879c86-zmflr   0/1     Pending   0          8m30s
controlplane $ 
controlplane $ kubectl -n stage exec pod -it bash -- ls -lha /root/
Error from server (NotFound): pods "pod" not found
controlplane $ 
controlplane $ kubectl -n stage exec po -it bash -- ls -lha /root/
Error from server (NotFound): pods "po" not found
controlplane $ 
controlplane $ 
```

```
  controlplane $ 
controlplane $ 
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ pwd    
/root
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f .
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po, svc
error: arguments in resource/name form must have a single resource and name
controlplane $ 
controlplane $ kubectl get -n stage po,svc
NAME                          READY   STATUS              RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   0/2     ContainerCreating   0          22s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   22s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          33s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   33s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
error: error validating "stage-front-back.yaml": error validating data: ValidationError(Deployment.spec.template.spec.containers[0]): missing required field "name" in io.k8s.api.core.v1.Container; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod configured
service/fb-pod unchanged
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n po,svc,pv,pvc
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          11m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          36s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   11m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ping
Usage: ping [-aAbBdDfhLnOqrRUvV64] [-c count] [-i interval] [-I interface]
            [-m mark] [-M pmtudisc_option] [-l preload] [-p pattern] [-Q tos]
            [-s packetsize] [-S sndbuf] [-t ttl] [-T timestamp_option]
            [-w deadline] [-W timeout] [hop1 ...] destination
Usage: ping -6 [-aAbBdDfhLnOqrRUvV] [-c count] [-i interval] [-I interface]
             [-l preload] [-m mark] [-M pmtudisc_option]
             [-N nodeinfo_option] [-p pattern] [-Q tclass] [-s packetsize]
             [-S sndbuf] [-t ttl] [-T timestamp_option] [-w deadline]
             [-W timeout] destination
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- cd / && ls -lha
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "e920216496551a6277af8a57f7c8134c4fe4e33e5e460395f80f8336f435deb1": OCI runtime exec failed: exec failed: unable to start container process: exec: "cd": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha        
total 28K
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls cd  
ls: cannot access 'cd': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls cd /
ls: cannot access 'cd': No such file or directory
/:
app  boot  etc   lib    media  opt   root  sbin  sys  usr
bin  dev   home  lib64  mnt    proc  run   srv   tmp  var
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha
total 28K
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls ls /root/
ls: cannot access 'ls': No such file or directory
/root/:
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls /root/
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-65b9777746-ln6qn -c backend -it bash -- ls -lha /root/
total 28K
drwx------ 1 root root 4.0K Jul  4 12:31 .
drwxr-xr-x 1 root root 4.0K Jul 14 16:54 ..
-rw-r--r-- 1 root root  570 Jan 31  2010 .bashrc
drwxr-xr-x 1 root root 4.0K Jul  4 12:31 .cache
drwxr-xr-x 3 root root 4.0K Jul  4 12:31 .local
-rw-r--r-- 1 root root  148 Aug 17  2015 .profile
-rw------- 1 root root    0 Jun 23 11:23 .python_history
-rw-r--r-- 1 root root  254 Jun 23 11:27 .wget-hsts
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          16m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          5m51s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   16m
controlplane $ 
controlplane $ kubectl apply -f pv.yaml               
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod unchanged
service/fb-pod unchanged
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m34s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           19s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m36s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           21s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m41s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           26s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m43s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           28s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,pv,pvc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-65b9777746-ln6qn   2/2     Running   0          17m
pod/fb-pod-769d879c86-zmflr   0/1     Pending   0          6m46s

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.98.176.241   <none>        80:30080/TCP   17m

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           31s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Running   0          19m
fb-pod-769d879c86-zmflr   0/1     Pending   0          8m30s
controlplane $ 
controlplane $ kubectl -n stage exec pod -it bash -- ls -lha /root/
Error from server (NotFound): pods "pod" not found
controlplane $ 
controlplane $ kubectl -n stage exec po -it bash -- ls -lha /root/
Error from server (NotFound): pods "po" not found
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f .
persistentvolume "pv" deleted
persistentvolumeclaim "pvc" deleted
deployment.apps "fb-pod" deleted
service "fb-pod" deleted
Error from server (NotFound): error when deleting "pod.yaml": pods "pod" not found
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Terminating   0          29m
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Terminating   0          29m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Terminating   0          29m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-65b9777746-ln6qn   2/2     Terminating   0          30m
controlplane $ 
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  87156      0 --:--:-- --:--:-- --:--:-- 87156
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
controlplane $ 
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
controlplane $ 
controlplane $ 
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Jul 14 17:24:56 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
controlplane $ 
controlplane $ 
controlplane $ apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (425 kB/s)       
Selecting previously unselected package libtirpc-common.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1_all.deb ...
Unpacking libtirpc-common (1.2.5-1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
controlplane $ 
controlplane $ 
controlplane $ ssh node 01
ssh: Could not resolve hostname node: Name or service not known
controlplane $ 
controlplane $ apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
nfs-common is already the newest version (1:1.3.4-2.5ubuntu3.4).
0 upgraded, 0 newly installed, 0 to remove and 130 not upgraded.
controlplane $ 
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $ 
node01 $ 
node01 $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   311k      0 --:--:-- --:--:-- --:--:--  311k
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
node01 $ 
node01 $ 
node01 $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
node01 $ 
node01 $ 
node01 $ 
node01 $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
Error: INSTALLATION FAILED: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp 127.0.0.1:8080: connect: connection refused
node01 $ 
node01 $ 
node01 $ apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (1746 kB/s)      
Selecting previously unselected package libtirpc-common.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1_all.deb ...
Unpacking libtirpc-common (1.2.5-1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
node01 $ 
node01 $ 
node01 $ exit
logout
Connection to node01 closed.
controlplane $ 
controlplane $ 
controlplane $ cd /root/data/pv
bash: cd: /root/data/pv: Not a directory
controlplane $ 
controlplane $ pwd
/root/My-Project
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ cd / 
controlplane $ 
controlplane $ cd /root/data/pv
bash: cd: /root/data/pv: Not a directory
controlplane $ 
controlplane $ pwd
/
controlplane $ 
controlplane $ cd root/
controlplane $ 
controlplane $ pwd
/root
controlplane $ 
controlplane $ mkdir -p data/pv
mkdir: cannot create directory 'data/pv': File exists
controlplane $ 
controlplane $ mkdir -p /data/pv
controlplane $ 
controlplane $ 
controlplane $ cd data/pv
bash: cd: data/pv: Not a directory
controlplane $ 
controlplane $ pwd       
/root
controlplane $ 
controlplane $ ls -lha
total 60K
drwx------ 10 root root 4.0K Jul 14 17:24 .
drwxr-xr-x 21 root root 4.0K Jul 14 17:29 ..
-rw-------  1 root root   10 Oct  8  2021 .bash_history
-rw-r--r--  1 root root 3.3K May  8 19:34 .bashrc
drwxr-xr-x  3 root root 4.0K Jul 14 17:24 .cache
drwxr-xr-x  3 root root 4.0K Jul 14 17:24 .config
drwxr-xr-x  3 root root 4.0K May  8 19:32 .kube
-rw-r--r--  1 root root  161 Dec  5  2019 .profile
drwxr-xr-x  2 root root 4.0K Jul 14 17:01 .redhat
drwx------  2 root root 4.0K May  2 10:20 .ssh
drwxr-xr-x  6 root root 4.0K Jul 14 16:45 .theia
-rw-r--r--  1 root root  109 Jul 14 16:17 .vimrc
-rw-r--r--  1 root root  165 May  8 19:31 .wget-hsts
drwxr-xr-x  2 root root 4.0K Jul 14 16:56 My-Project
drwxr-xr-x  2 root root 4.0K Jul 14 17:10 data
lrwxrwxrwx  1 root root    1 May  2 10:23 filesystem -> /
controlplane $ 
controlplane $ cd data/
controlplane $ 
controlplane $ ls -lha
total 8.0K
drwxr-xr-x  2 root root 4.0K Jul 14 17:10 .
drwx------ 10 root root 4.0K Jul 14 17:24 ..
-rw-r--r--  1 root root    0 Jul 14 17:10 pv
controlplane $ 
controlplane $ cd pv
bash: cd: pv: Not a directory
controlplane $ 
controlplane $ mkdir -p pv
mkdir: cannot create directory 'pv': File exists
controlplane $ 
controlplane $ rm pv
controlplane $ 
controlplane $ mkdir -p pv
controlplane $ 
controlplane $ cd pv/
controlplane $ 
controlplane $ pwd
/root/data/pv
controlplane $ 
controlplane $ echo Hello! > 42.txt
controlplane $ 
controlplane $ cat 42.txt 
Hello!
controlplane $ 
controlplane $ pwd
/root/data/pv
controlplane $ 
controlplane $ cd /  
controlplane $ 
controlplane $ pwd     
/
controlplane $ 
controlplane $ cd root/
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   66d
kube-node-lease   Active   66d
kube-public       Active   66d
kube-system       Active   66d
stage             Active   39m
controlplane $ 
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get pv
No resources found
controlplane $ 
controlplane $ kubectl -n stage get pvc
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          7s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          12s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          15s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml               
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          29s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          32s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          44s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          45s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          47s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          49s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          50s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          52s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          58s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          63s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          65s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          67s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          85s
controlplane $ 
controlplane $ kubectl -n stage get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   0/1     1            0           92s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          101s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          111s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          113s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-769d879c86-48lsz   0/1     Pending   0          114s
controlplane $ 
```
```
controlplane $ kubectl -n stage describe pod fb-pod-769d879c86-48lsz 
Name:           fb-pod-769d879c86-48lsz
Namespace:      stage
Priority:       0
Node:           <none>
Labels:         app=fb-app
                pod-template-hash=769d879c86
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  ReplicaSet/fb-pod-769d879c86
Containers:
  frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:
      /data/pv from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8dq9j (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-8dq9j:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  4m29s  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  4m4s   default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
```



## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.


### Пояснения преподавателя:

1. Запустить контейнер с сервером NFS для создания общего сетевого ресурса в поде
2. Подключить Backend-ы из Stage и Prod к одному и тому же PV в режиме ReadWriteMany
3. Можно делать с помощью Storage Class и Persistent Volume Clame, который автоматически создастся
4. Для Backend все описано в одном деплойменте

1. Для Frontend создается другой деплоймент
2. Этот деплоймент подключается  к тому же PV, к которому подключаются Backend также в режиме ReadWriteMany
3. Файлы, созданные на Stage Backend должны быть доступны на Prod Backend и на Prod Frontend
4. Показать, что файлы, записаные на Backend доступны на Frontend и наоборот




---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
