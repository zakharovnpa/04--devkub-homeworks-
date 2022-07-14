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

#### 3. На ноде Админ создает папку. Создадим PersistentVolume с именем "pv" в поде (можно вместе манифестом пода)

* pv.yaml
```yml
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
kubectl apply -f templates/pv.yaml
```

4. Создадим PersistentVolumeClaim с именем pvc
* pvc.yaml
```yml
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
kubectl apply -f templates/pvc.yaml
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
