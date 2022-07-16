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


## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.


### Пояснения преподавателя:

1. Запустить контейнер с сервером NFS для создания общего сетевого ресурса в поде
2. Подключить Backend-ы из Stage и Prod к одному и тому же PV в режиме ReadWriteMany
3. Можно делать с помощью Storage Class и Persistent Volume Clame, который автоматически создастся
4. Для Backend все описано в одном StatefuSset (деплойменте)

1. Для Frontend создается другой StatefuSet (деплоймент)
2. Этот StatefuSset подключается  к тому же PV, к которому подключаются Backend также в режиме ReadWriteMany
3. Файлы, созданные на Stage Backend должны быть доступны на Prod Backend и на Prod Frontend
4. Показать, что файлы, записаные на Backend доступны на Frontend и наоборот


#### Ход выполнения заданя 2

##### 1. Запуск на ноде в отдельном поде сервера NFS


1. Для NFS использовать контейнер на основе образа Multitool
2. Это будет аналог сетевой общей папки для подключения к ней наших пирложенй
3. Сделать PV, который будет иметь доступ к серверу NFS
4. Если на используется NFS, то создать папку на ноде и указать ее в качестве PV

* Манфест StatefulSet для NFS на multitool

```yml

```
* 


##### 2. Подключить Backend-ы из Stage и Prod к одному и тому же PV

1. В манифесте StatefulSet Backend Stage
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;


2. В манифесте StatefuSet Backend Prod
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;

##### 3. Подключить Frontend из Prod к тому же PV с NFS, что Backend 

1. В манифесте StatefuSet Frontend Prod
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;

##### 4. Порядок запуска

1. PV
2. PVC
3. Pod

##### 5. Примеры манифестов

* Пример манифеста PersistentVolume `pv.yaml`
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""      # сюда записать имя
  accessModes:
    - ReadWriteOnce       #режим подключения - чтать и записывать только одному
  capacity:
    storage: 2Gi
  hostPath:           # тип хранилища
    path: /data/pv
```
* Пример манифеста PersistentVolumeClaim `pvc.yaml`
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
* Пример манифеста пода с примонтированием PV `pod.yaml`
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

### Ход выполнения задания

#### Подключение и отключение provisioner

Для динамического выделения томов необходимо подключить один или больше `provisioner`.

Косвенным признаком наличия `provisioner` Является наличие StorageClass. StorageClass мы рассмотрим чуть ниже.

* Посмотреть список StorageClass
kubectl get storageclasses.storage.k8s.io

```
controlplane $ kubectl get storageclasses.storage.k8s.io
No resources found
```

* Посмотреть список StorageClass (короткое имя)
kubectl get sc

```
controlplane $ kubectl get sc
No resources found
```

* Показывает ноды, к которым могут быть примонтированы тома
kubectl get csinodes

* CSIDriver 
kubectl get csidrivers

```
controlplane $ kubectl get csidrivers
No resources found
```

Если StorageClass нет, то и `provisioner` тоже нет. Необходимо произвести его установку.

#### Инсталляця NFS

* Установка helm 
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

```
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  63028      0 --:--:-- --:--:-- --:--:-- 63028
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
```
```
node01 $ helm --help
The Kubernetes package manager

Common actions for Helm:

- helm search:    search for charts
- helm pull:      download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts

Environment variables:

| Name                               | Description                                                                       |
|------------------------------------|-----------------------------------------------------------------------------------|
| $HELM_CACHE_HOME                   | set an alternative location for storing cached files.                             |
| $HELM_CONFIG_HOME                  | set an alternative location for storing Helm configuration.                       |
| $HELM_DATA_HOME                    | set an alternative location for storing Helm data.                                |
| $HELM_DEBUG                        | indicate whether or not Helm is running in Debug mode                             |
| $HELM_DRIVER                       | set the backend storage driver. Values are: configmap, secret, memory, sql.       |
| $HELM_DRIVER_SQL_CONNECTION_STRING | set the connection string the SQL storage driver should use.                      |
| $HELM_MAX_HISTORY                  | set the maximum number of helm release history.                                   |
| $HELM_NAMESPACE                    | set the namespace used for the helm operations.                                   |
| $HELM_NO_PLUGINS                   | disable plugins. Set HELM_NO_PLUGINS=1 to disable plugins.                        |
| $HELM_PLUGINS                      | set the path to the plugins directory                                             |
| $HELM_REGISTRY_CONFIG              | set the path to the registry config file.                                         |
| $HELM_REPOSITORY_CACHE             | set the path to the repository cache directory                                    |
| $HELM_REPOSITORY_CONFIG            | set the path to the repositories file.                                            |
| $KUBECONFIG                        | set an alternative Kubernetes configuration file (default "~/.kube/config")       |
| $HELM_KUBEAPISERVER                | set the Kubernetes API Server Endpoint for authentication                         |
| $HELM_KUBECAFILE                   | set the Kubernetes certificate authority file.                                    |
| $HELM_KUBEASGROUPS                 | set the Groups to use for impersonation using a comma-separated list.             |
| $HELM_KUBEASUSER                   | set the Username to impersonate for the operation.                                |
| $HELM_KUBECONTEXT                  | set the name of the kubeconfig context.                                           |
| $HELM_KUBETOKEN                    | set the Bearer KubeToken used for authentication.                                 |

Helm stores cache, configuration, and data based on the following configuration order:

- If a HELM_*_HOME environment variable is set, it will be used
- Otherwise, on systems supporting the XDG base directory specification, the XDG variables will be used
- When no other location is set a default location will be used based on the operating system

By default, the default directories depend on the Operating System. The defaults are listed below:

| Operating System | Cache Path                | Configuration Path             | Data Path               |
|------------------|---------------------------|--------------------------------|-------------------------|
| Linux            | $HOME/.cache/helm         | $HOME/.config/helm             | $HOME/.local/share/helm |
| macOS            | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm      |
| Windows          | %TEMP%\helm               | %APPDATA%\helm                 | %APPDATA%\helm          |

Usage:
  helm [command]

Available Commands:
  completion  generate autocompletion scripts for the specified shell
  create      create a new chart with the given name
  dependency  manage a chart's dependencies
  env         helm client environment information
  get         download extended information of a named release
  help        Help about any command
  history     fetch release history
  install     install a chart
  lint        examine a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      install, list, or uninstall Helm plugins
  pull        download a chart from a repository and (optionally) unpack it in local directory
  push        push a chart to remote
  registry    login to or logout from a registry
  repo        add, list, remove, update, and index chart repositories
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  show        show information of a chart
  status      display the status of the named release
  template    locally render templates
  test        run tests for a release
  uninstall   uninstall a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client version information

Flags:
      --debug                       enable verbose output
  -h, --help                        help for helm
      --kube-apiserver string       the address and the port for the Kubernetes API server
      --kube-as-group stringArray   group to impersonate for the operation, this flag can be repeated to specify multiple groups.
      --kube-as-user string         username to impersonate for the operation
      --kube-ca-file string         the certificate authority file for the Kubernetes API server connection
      --kube-context string         name of the kubeconfig context to use
      --kube-token string           bearer token used for authentication
      --kubeconfig string           path to the kubeconfig file
  -n, --namespace string            namespace scope for this request
      --registry-config string      path to the registry config file (default "/root/.config/helm/registry/config.json")
      --repository-cache string     path to the file containing cached repository indexes (default "/root/.cache/helm/repository")
      --repository-config string    path to the file containing repository names and URLs (default "/root/.config/helm/repositories.yaml")

Use "helm [command] --help" for more information about a command.
```


* Добавление репозитория чартов 
```
helm repo add stable https://charts.helm.sh/stable && helm repo update
```
```
controlplane $  helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
```

#### Установка nfs-server через helm 
```
helm install nfs-server stable/nfs-server-provisioner
```
```
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sat Jul 16 05:47:05 2022
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

* В дальнейшем при создании PVC, на подах может возникнуть следующая проблема (поды зависнут в статусе ContainerCreating):
```
Output: mount: /var/lib/kubelet/pods/f760c19e-6ec0-46e8-9a3a-d6187fd927e8/volumes/kubernetes.io~nfs/pvc-d3134d79-c2ce-41a2-af72-0f2d45c5c19e:
bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
```

* Решение проблемы (необходимо установить на всех нодах !!!):
```
sudo apt install nfs-common - для debian/ubuntu
```

#### Скрипт для установки Helm  NFS 

* на ControlNode
``` 
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && /
helm repo add stable https://charts.helm.sh/stable && helm repo update && /
helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y

```
* на Worker Node
```
 apt install nfs-common
``` 

#### Манифесты для тестирования работы StorageClass, NFS

* pod.yaml
```yaml
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
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```
* pvc.yaml

```yml
---
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
* sc.yaml

```yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-nfs
provisioner: example.com/external-nfs
parameters:
  server: nfs-server.example.com
  path: /share
  readOnly: "false"
```

#### Тестироване

```shell script
kubectl apply -f pod.yaml
kubectl apply -f pvc.yaml
```
* После этого будет создан PersistentVolume.
Создана связка PersistentVolumeClaim-PersistentVolume.
И запущен Pod (какой з подов имеется ввиду). 

* Ага, как бы не так. Смотри логи

#### Логи ЛР по этой теме:

1. Манифесты:

* pod.yaml

```yaml
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
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```
* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: my-nfs
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
* storageclass.yml
```yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-nfs
provisioner: cluster.local/nfs-server-nfs-server-provisioner
parameters:
  server: nfs-server.example.com
  path: /share
  readOnly: "false"
```
* Logs -0

```
controlplane $ kubectl apply -f pod.yaml
error: the path "pod.yaml" does not exist
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f pod.yaml
pod/pod created
controlplane $ kubectl apply -f pvc.yaml
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          15m
pod/pod                                   0/1     Pending   0          86s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     24s
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          15m
pod/pod                                   0/1     Pending   0          105s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     43s
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          17m
pod/pod                                   0/1     Pending   0          4m5s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     3m3s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f sc.yaml 
storageclass.storage.k8s.io/my-nfs created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
pod/pod                                   0/1     Pending   0          4m30s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     3m28s
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
pod/pod                                   0/1     Pending   0          4m36s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     3m34s
controlplane $ 
controlplane $ kubectl get po,pv,pvc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
pod/pod                                   0/1     Pending   0          4m49s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     3m47s
controlplane $ 
controlplane $ kubectl get po,pv,pvc,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
pod/pod                                   0/1     Pending   0          4m56s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     3m54s

NAME                                 PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/my-nfs   example.com/external-nfs                          Delete          Immediate           false                  33s
storageclass.storage.k8s.io/nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   18m
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pv,pvc,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          18m
pod/pod                                   0/1     Pending   0          5m19s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     4m17s

NAME                                 PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/my-nfs   example.com/external-nfs                          Delete          Immediate           false                  56s
storageclass.storage.k8s.io/nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   18m
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml
The PersistentVolumeClaim "pvc" is invalid: spec: Forbidden: spec is immutable after creation except resources.requests for bound claims
  core.PersistentVolumeClaimSpec{
        ... // 2 identical fields
        Resources:        {Requests: {s"storage": {i: {...}, s: "2Gi", Format: "BinarySI"}}},
        VolumeName:       "",
-       StorageClassName: nil,
+       StorageClassName: &"my-nfs",
        VolumeMode:       &"Filesystem",
        DataSource:       nil,
        DataSourceRef:    nil,
  }

controlplane $ kubectl delete -y .
error: unknown shorthand flag: 'y' in -y
See 'kubectl delete --help' for usage.
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod" deleted
persistentvolumeclaim "pvc" deleted
storageclass.storage.k8s.io "my-nfs" deleted
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f .
pod/pod created
persistentvolumeclaim/pvc created
storageclass.storage.k8s.io/my-nfs created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc   
NAME   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Pending                                      my-nfs         26m
controlplane $ 
controlplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  my-nfs
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   volume.beta.kubernetes.io/storage-provisioner: example.com/external-nfs
               volume.kubernetes.io/storage-provisioner: example.com/external-nfs
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type     Reason                Age                  From                         Message
  ----     ------                ----                 ----                         -------
  Warning  ProvisioningFailed    26m                  persistentvolume-controller  storageclass.storage.k8s.io "my-nfs" not found
  Normal   ExternalProvisioning  87s (x101 over 26m)  persistentvolume-controller  waiting for a volume to be created, either by external provisioner "example.com/external-nfs" or manually created by system administrator
controlplane $ 

```
* Logs - 1
```
Initialising Kubernetes... done

controlplane $ 
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && /
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   157k      0 --:--:-- --:--:-- --:--:--  160k
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
bash: /: Is a directory
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update && /
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
bash: /: Is a directory
controlplane $ helm install nfs-server stable/nfs-server-provisioner && /
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sat Jul 16 11:14:59 2022
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
bash: /: Is a directory
controlplane $ apt install nfs-common -y && ssh node01 && /
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
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (1709 kB/s)    
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
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $ 
node01 $ apt install nfs-common -y && exit
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
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (2069 kB/s)
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
logout
Connection to node01 closed.
bash: /: Is a directory
controlplane $ 
```
* Logs - 2

```

controlplane $ kubectl get po,pv,pvc,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          22m
pod/pod                                   0/1     Pending   0          54s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                      my-nfs         54s

NAME                                 PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/my-nfs   example.com/external-nfs                          Delete          Immediate           false                  54s
storageclass.storage.k8s.io/nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   22m
controlplane $ 
controlplane $ kubectl get po,pv,pvc,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          22m
pod/pod                                   0/1     Pending   0          70s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                      my-nfs         70s

NAME                                 PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/my-nfs   example.com/external-nfs                          Delete          Immediate           false                  70s
storageclass.storage.k8s.io/nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   22m
controlplane $ 
controlplane $ kubectl get sc
NAME     PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
my-nfs   example.com/external-nfs                          Delete          Immediate           false                  115s
nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   23m
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pv,pvc,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          25m
pod/pod                                   0/1     Pending   0          3m44s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                      my-nfs         3m44s

NAME                                 PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/my-nfs   example.com/external-nfs                          Delete          Immediate           false                  3m44s
storageclass.storage.k8s.io/nfs      cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   25m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
controlplane $ 
controlplane $ 
controlplane $ kubectl get csidrivers
No resources found
controlplane $ 
controlplane $ 
controlplane $ kubectl logs -f nfs-server-nfs-server-provisioner-0 
I0716 11:15:07.597112       1 main.go:64] Provisioner cluster.local/nfs-server-nfs-server-provisioner specified
I0716 11:15:07.597976       1 main.go:88] Setting up NFS server!
I0716 11:15:07.727210       1 server.go:149] starting RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 11:15:07.727307       1 server.go:160] ending RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 11:15:07.727659       1 server.go:134] Running NFS server!

^C
controlplane $ 
controlplane $ 
controlplane $ kubectl describe po nfs-server-nfs-server-provisioner-0 
Name:         nfs-server-nfs-server-provisioner-0
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sat, 16 Jul 2022 11:15:01 +0000
Labels:       app=nfs-server-provisioner
              chart=nfs-server-provisioner-1.1.3
              controller-revision-hash=nfs-server-nfs-server-provisioner-64bd6d7f65
              heritage=Helm
              release=nfs-server
              statefulset.kubernetes.io/pod-name=nfs-server-nfs-server-provisioner-0
Annotations:  cni.projectcalico.org/containerID: ae7233e81fcded580bc83a2b91cd59e39122335ed3d26637ff07875e29d617e7
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  StatefulSet/nfs-server-nfs-server-provisioner
Containers:
  nfs-server-provisioner:
    Container ID:  containerd://d8defccb4cc24c6c7100e19bab498c49be557d8af92e102e33a4b1a3bb085159
    Image:         quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    Image ID:      quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    Ports:         2049/TCP, 2049/UDP, 32803/TCP, 32803/UDP, 20048/TCP, 20048/UDP, 875/TCP, 875/UDP, 111/TCP, 111/UDP, 662/TCP, 662/UDP
    Host Ports:    0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP
    Args:
      -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    State:          Running
      Started:      Sat, 16 Jul 2022 11:15:07 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      POD_IP:          (v1:status.podIP)
      SERVICE_NAME:   nfs-server-nfs-server-provisioner
      POD_NAMESPACE:  default (v1:metadata.namespace)
    Mounts:
      /export from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lzckt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-lzckt:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  39m   default-scheduler  Successfully assigned default/nfs-server-nfs-server-provisioner-0 to node01
  Normal  Pulling    39m   kubelet            Pulling image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0"
  Normal  Pulled     39m   kubelet            Successfully pulled image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0" in 5.620265356s
  Normal  Created    39m   kubelet            Created container nfs-server-provisioner
  Normal  Started    39m   kubelet            Started container nfs-server-provisioner
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pvc pvc
Error from server (NotFound): pods "pvc" not found
controlplane $ 
controlplane $ kubectl logs pvc
Error from server (NotFound): pods "pvc" not found
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pod pod
error: container pod is not valid for pod pod
controlplane $ 
controlplane $ kubectl logs pod    
controlplane $ 
controlplane $ kubectl logs pod
controlplane $ 
controlplane $ kubectl logs -f pod                                 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl describe po pod                                 
Name:         pod
Namespace:    default
Priority:     0
Node:         <none>
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ltszg (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-ltszg:
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
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  24m   default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  24m   default-scheduler  0/2 nodes are available: 2 pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  24m   default-scheduler  0/2 nodes are available: 2 pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
controlplane $ 
controlplane $ 
```




```shell script
kubectl exec pod -- ls -la /static
kubectl exec pod -- sh -c "echo 'dynamic' > /static/dynamic.txt"
```
# Определим в какой папке у нас хранятся данные
```
kubectl get pv -o yaml | grep '^\s*path:'
```
# На ноде ищем файл. Например
```
sudo ls -la /var/snap/microk8s/common/default-storage/default-pvc-pvc-7bd66d4c-189e-44d1-ad0f-bc091491525e
```





---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
