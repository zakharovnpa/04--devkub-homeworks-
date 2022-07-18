## Логи ЛР по запуску сервера NFS и днамического создания PV

* Работа проводилась на сайте `https://killercoda.com/playgrounds/scenario/kubernetes`

### Лог Tab 1

#### 1. До установки NFS проверка наличия StorageClass, Services, Pod
```
controlplane $ 
controlplane $ date
Sat Jul 16 16:24:28 UTC 2022
```
```
controlplane $ kubectl get po
No resources found in default namespace.
```
```
controlplane $ kubectl get pvc
No resources found in default namespace.
```
```
controlplane $ kubectl get sc 
No resources found
```
```
controlplane $ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   68d
```
* на какие ноды можно подключать тома
```
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
```
* Есть ли драйвер Storage Interface
```
controlplane $ kubectl get csidrivers
No resources found
```
```
controlplane $ kubectl get pv 
No resources found
```
#### 2. Установка NFS и автоматическое создание StorageClass

```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

helm repo add stable https://charts.helm.sh/stable && helm repo update

helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y

```
* pvc.yaml
```yml
controlplane $ cat pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs  # было исправлено на имя StorageClass
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
     
```

* Манифест нашего пода `pod.yaml`
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
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
        
```

* Установка helm 
```
controlplane $ date
Sat Jul 16 16:26:56 UTC 2022
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  63386      0 --:--:-- --:--:-- --:--:-- 63386
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
bash: /: Is a directory
```
* Добавление репозитория чартов 
```
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
```
* Установка nfs-server через helm 
```
controlplane $ helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Sat Jul 16 16:27:11 2022
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
Fetched 404 kB in 0s (1843 kB/s)    
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

#### 3. После установки NFS проверка наличия StorageClass, Services, Pod

```
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   91s
```
```
controlplane $ kubectl get pv
No resources found
```
```
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
```
```
controlplane $ kubectl get csidrivers
No resources found
```
```
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   2m12s
```
```
controlplane $ kubectl get pvc
No resources found in default namespace.
```
```
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          3m13s
```
```
controlplane $ kubectl get pv
No resources found
```
```
controlplane $ kubectl get pv
No resources found
```
```
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          12m
```
```
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   12m
```
```
controlplane $ kubectl get csidrivers
No resources found
```
```
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
```

#### 4. Применение запроса PVC
```
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
```
```
controlplane $ kubectl get pvc
NAME   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Pending                                      my-nfs         15s
```
```
controlplane $ kubectl get pvc
NAME   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Pending                                      my-nfs         30s
```
* Показан пример состояния Pending для PVC по причине не соотвектствия имени `storageClassName` в PVC и имени самого StorageClass
```
controlplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  my-nfs
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   <none>
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type     Reason              Age               From                         Message
  ----     ------              ----              ----                         -------
  Warning  ProvisioningFailed  8s (x5 over 53s)  persistentvolume-controller  storageclass.storage.k8s.io "my-nfs" not found
```
* Исправляем
```
controlplane $ kubectl delete -f pvc.yaml 
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
```
```
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            nfs            36s
```
```
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            Delete           Bound    default/pvc   nfs                     55s
```
* Pod с сервером NFS работает
```
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          21m
```
* pvc.yaml
```
controlplane $ cat pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs  # было исправлено на имя StorageClass
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
     
```
* PVC с файлом `pvc.yaml`. Статус - Bound
```
controlplane $ date
Sat Jul 16 16:49:04 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            nfs            3m44s
```
* Pod с нашим приложением nginx запустился с файлом `pvc.yaml`. Статус - Running
```
controlplane $ date
Sat Jul 16 16:53:09 UTC 2022
controlplane $ 
controlplane $ kubectl apply -f pod.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          26m
pod                                   1/1     Running   0          16s
```
* Логи пода
```
controlplane $ kubectl logs pod
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/16 16:53:43 [notice] 1#1: using the "epoll" event method
2022/07/16 16:53:43 [notice] 1#1: nginx/1.23.0
2022/07/16 16:53:43 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/16 16:53:43 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/16 16:53:43 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/16 16:53:43 [notice] 1#1: start worker processes
2022/07/16 16:53:43 [notice] 1#1: start worker process 30
```
* Логи provisioner
```
controlplane $ date
Sat Jul 16 16:58:00 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl logs nfs-server-nfs-server-provisioner-0 
I0716 16:27:18.841580       1 main.go:64] Provisioner cluster.local/nfs-server-nfs-server-provisioner specified
I0716 16:27:18.841617       1 main.go:88] Setting up NFS server!
I0716 16:27:18.963693       1 server.go:149] starting RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 16:27:18.963772       1 server.go:160] ending RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 16:27:18.964061       1 server.go:134] Running NFS server!
I0716 16:47:09.312605       1 provision.go:450] using service SERVICE_NAME=nfs-server-nfs-server-provisioner cluster IP 10.96.246.57 as NFS server IP
```
```
controlplane $ cat pod.yaml 
```
* Манифест нашего пода `pod.yaml`
```
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

### Лог Tab 2. Установка nfs-common на WorkerNode

```
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $  apt install nfs-common
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
Fetched 404 kB in 0s (1688 kB/s)      
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
node01 $ 
```

### Лог Terminal 0
```
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   48m
controlplane $ 
controlplane $ kubectl get sc -o yaml
apiVersion: v1
items:
- allowVolumeExpansion: true
  apiVersion: storage.k8s.io/v1
  kind: StorageClass
  metadata:
    annotations:
      meta.helm.sh/release-name: nfs-server
      meta.helm.sh/release-namespace: default
    creationTimestamp: "2022-07-16T16:27:12Z"
    labels:
      app: nfs-server-provisioner
      app.kubernetes.io/managed-by: Helm
      chart: nfs-server-provisioner-1.1.3
      heritage: Helm
      release: nfs-server
    name: nfs
    resourceVersion: "2857"
    uid: 43b045e3-51f7-4270-9821-f6f666374870
  mountOptions:
  - vers=3
  provisioner: cluster.local/nfs-server-nfs-server-provisioner
  reclaimPolicy: Delete
  volumeBindingMode: Immediate
kind: List
metadata:
  resourceVersion: ""
```

```yml
controlplane $ kubectl describe sc nfs 
Name:                  nfs
IsDefaultClass:        No
Annotations:           meta.helm.sh/release-name=nfs-server,meta.helm.sh/release-namespace=default
Provisioner:           cluster.local/nfs-server-nfs-server-provisioner
Parameters:            <none>
AllowVolumeExpansion:  True
MountOptions:
  vers=3
ReclaimPolicy:      Delete
VolumeBindingMode:  Immediate
Events:             <none>
controlplane $ 
controlplane $ date
Sat Jul 16 17:16:39 UTC 2022
controlplane $ 
controlplane $ kubectl get pvc       
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            nfs            29m
controlplane $ 
controlplane $ kubectl get pvc -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"PersistentVolumeClaim","metadata":{"annotations":{},"name":"pvc","namespace":"default"},"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"2Gi"}},"storageClassName":"nfs"}}
      pv.kubernetes.io/bind-completed: "yes"
      pv.kubernetes.io/bound-by-controller: "yes"
      volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
      volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
    creationTimestamp: "2022-07-16T16:47:09Z"
    finalizers:
    - kubernetes.io/pvc-protection
    name: pvc
    namespace: default
    resourceVersion: "5051"
    uid: 40c0b077-37e5-4193-bf44-992074b9d4c6
  spec:
    accessModes:
    - ReadWriteOnce
    resources:
      requests:
        storage: 2Gi
    storageClassName: nfs
    volumeMode: Filesystem
    volumeName: pvc-40c0b077-37e5-4193-bf44-992074b9d4c6
  status:
    accessModes:
    - ReadWriteOnce
    capacity:
      storage: 2Gi
    phase: Bound
kind: List
metadata:
  resourceVersion: ""
```

```
controlplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pvc-40c0b077-37e5-4193-bf44-992074b9d4c6
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type    Reason                 Age   From                                                                                                                      Message
  ----    ------                 ----  ----                                                                                                                      -------
  Normal  ExternalProvisioning   30m   persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           30m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_90a580d2-f958-4efa-a4f8-fae144863a9a  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  30m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_90a580d2-f958-4efa-a4f8-fae144863a9a  Successfully provisioned volume pvc-40c0b077-37e5-4193-bf44-992074b9d4c6
```

```
controlplane $ kubectl get po pod
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          24m
```

```
controlplane $ kubectl get po pod -o wide
NAME   READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
pod    1/1     Running   0          24m   192.168.1.5   node01   <none>           <none>
```

```yml
controlplane $ kubectl get po pod -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: d086c7043b6101d4e18ee5cf5761d00937faa69ac43af618a52be92bfcace8fd
    cni.projectcalico.org/podIP: 192.168.1.5/32
    cni.projectcalico.org/podIPs: 192.168.1.5/32
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"pod","namespace":"default"},"spec":{"containers":[{"image":"nginx","name":"nginx","volumeMounts":[{"mountPath":"/static","name":"my-volume"}]}],"volumes":[{"name":"my-volume","persistentVolumeClaim":{"claimName":"pvc"}}]}}
  creationTimestamp: "2022-07-16T16:53:39Z"
  name: pod
  namespace: default
  resourceVersion: "5768"
  uid: 99302fea-c717-43a3-98f5-8b4b753b678b
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /static
      name: my-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-zvt6b
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: node01
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: my-volume
    persistentVolumeClaim:
      claimName: pvc
  - name: kube-api-access-zvt6b
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:53:39Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:53:44Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:53:44Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:53:39Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://674cd8d7fc9e55f7270d72e6650ba8d8e6e74fe08104288f48ba42dfde5588b8
    image: docker.io/library/nginx:latest
    imageID: docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-16T16:53:43Z"
  hostIP: 172.30.2.2
  phase: Running
  podIP: 192.168.1.5
  podIPs:
  - ip: 192.168.1.5
  qosClass: BestEffort
  startTime: "2022-07-16T16:53:39Z"
```

```
controlplane $ kubectl describe po pod                                 
Name:         pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sat, 16 Jul 2022 16:53:39 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: d086c7043b6101d4e18ee5cf5761d00937faa69ac43af618a52be92bfcace8fd
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:  192.168.1.5
Containers:
  nginx:
    Container ID:   containerd://674cd8d7fc9e55f7270d72e6650ba8d8e6e74fe08104288f48ba42dfde5588b8
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 16 Jul 2022 16:53:43 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zvt6b (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-zvt6b:
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
  Normal  Scheduled  25m   default-scheduler  Successfully assigned default/pod to node01
  Normal  Pulling    25m   kubelet            Pulling image "nginx"
  Normal  Pulled     24m   kubelet            Successfully pulled image "nginx" in 3.587555698s
  Normal  Created    24m   kubelet            Created container nginx
  Normal  Started    24m   kubelet            Started container nginx
```

```
controlplane $ kubectl get po nfs-server-nfs-server-provisioner-0 -o wide
NAME                                  READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
nfs-server-nfs-server-provisioner-0   1/1     Running   0          51m   192.168.1.4   node01   <none>           <none>
```

```
controlplane $ kubectl get po nfs-server-nfs-server-provisioner-0 -o yaml
```

```yml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 636bde238ae70e4ce280fcadd24674b2352c57e9695bcaca4409462d9c802b59
    cni.projectcalico.org/podIP: 192.168.1.4/32
    cni.projectcalico.org/podIPs: 192.168.1.4/32
  creationTimestamp: "2022-07-16T16:27:12Z"
  generateName: nfs-server-nfs-server-provisioner-
  labels:
    app: nfs-server-provisioner
    chart: nfs-server-provisioner-1.1.3
    controller-revision-hash: nfs-server-nfs-server-provisioner-64bd6d7f65
    heritage: Helm
    release: nfs-server
    statefulset.kubernetes.io/pod-name: nfs-server-nfs-server-provisioner-0
  name: nfs-server-nfs-server-provisioner-0
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: StatefulSet
    name: nfs-server-nfs-server-provisioner
    uid: 3643b097-5ddc-4043-996c-031874c186c3
  resourceVersion: "2891"
  uid: b988d1c3-dc57-4bcd-99d8-3a285a880e4f
spec:
  containers:
  - args:
    - -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    env:
    - name: POD_IP
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: status.podIP
    - name: SERVICE_NAME
      value: nfs-server-nfs-server-provisioner
    - name: POD_NAMESPACE
      valueFrom:
        fieldRef:
          apiVersion: v1
          fieldPath: metadata.namespace
    image: quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    imagePullPolicy: IfNotPresent
    name: nfs-server-provisioner
    ports:
    - containerPort: 2049
      name: nfs
      protocol: TCP
    - containerPort: 2049
      name: nfs-udp
      protocol: UDP
    - containerPort: 32803
      name: nlockmgr
      protocol: TCP
    - containerPort: 32803
      name: nlockmgr-udp
      protocol: UDP
    - containerPort: 20048
      name: mountd
      protocol: TCP
    - containerPort: 20048
      name: mountd-udp
      protocol: UDP
    - containerPort: 875
      name: rquotad
      protocol: TCP
    - containerPort: 875
      name: rquotad-udp
      protocol: UDP
    - containerPort: 111
      name: rpcbind
      protocol: TCP
    - containerPort: 111
      name: rpcbind-udp
      protocol: UDP
    - containerPort: 662
      name: statd
      protocol: TCP
    - containerPort: 662
      name: statd-udp
      protocol: UDP
    resources: {}
    securityContext:
      capabilities:
        add:
        - DAC_READ_SEARCH
        - SYS_RESOURCE
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /export
      name: data
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-6vkg6
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostname: nfs-server-nfs-server-provisioner-0
  nodeName: node01
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: nfs-server-nfs-server-provisioner
  serviceAccountName: nfs-server-nfs-server-provisioner
  subdomain: nfs-server-nfs-server-provisioner
  terminationGracePeriodSeconds: 100
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - emptyDir: {}
    name: data
  - name: kube-api-access-6vkg6
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:27:12Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:27:19Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:27:19Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-16T16:27:12Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://45f0a7e4ea4d6303ab5de47fa93728e6f1ed0616ece4d444773eaf7f99324c14
    image: quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    imageID: quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    lastState: {}
    name: nfs-server-provisioner
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-16T16:27:18Z"
  hostIP: 172.30.2.2
  phase: Running
  podIP: 192.168.1.4
  podIPs:
  - ip: 192.168.1.4
  qosClass: BestEffort
  startTime: "2022-07-16T16:27:12Z"
```

```
controlplane $ kubectl describe po nfs-server-nfs-server-provisioner-0 
Name:         nfs-server-nfs-server-provisioner-0
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sat, 16 Jul 2022 16:27:12 +0000
Labels:       app=nfs-server-provisioner
              chart=nfs-server-provisioner-1.1.3
              controller-revision-hash=nfs-server-nfs-server-provisioner-64bd6d7f65
              heritage=Helm
              release=nfs-server
              statefulset.kubernetes.io/pod-name=nfs-server-nfs-server-provisioner-0
Annotations:  cni.projectcalico.org/containerID: 636bde238ae70e4ce280fcadd24674b2352c57e9695bcaca4409462d9c802b59
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  StatefulSet/nfs-server-nfs-server-provisioner
Containers:
  nfs-server-provisioner:
    Container ID:  containerd://45f0a7e4ea4d6303ab5de47fa93728e6f1ed0616ece4d444773eaf7f99324c14
    Image:         quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    Image ID:      quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    Ports:         2049/TCP, 2049/UDP, 32803/TCP, 32803/UDP, 20048/TCP, 20048/UDP, 875/TCP, 875/UDP, 111/TCP, 111/UDP, 662/TCP, 662/UDP
    Host Ports:    0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP
    Args:
      -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    State:          Running
      Started:      Sat, 16 Jul 2022 16:27:18 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      POD_IP:          (v1:status.podIP)
      SERVICE_NAME:   nfs-server-nfs-server-provisioner
      POD_NAMESPACE:  default (v1:metadata.namespace)
    Mounts:
      /export from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6vkg6 (ro)
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
  kube-api-access-6vkg6:
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
  Normal  Scheduled  52m   default-scheduler  Successfully assigned default/nfs-server-nfs-server-provisioner-0 to node01
  Normal  Pulling    52m   kubelet            Pulling image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0"
  Normal  Pulled     52m   kubelet            Successfully pulled image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0" in 5.436767439s
  Normal  Created    52m   kubelet            Created container nfs-server-provisioner
  Normal  Started    52m   kubelet            Started container nfs-server-provisioner
controlplane $ 
controlplane $ 
controlplane $ 
```
