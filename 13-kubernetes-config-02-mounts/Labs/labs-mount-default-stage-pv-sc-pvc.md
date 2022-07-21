## Подключение к PV через StorageClass подов в default и stage

### Задача: 
1. Настроить локальный PV на ноде
2. Подключить к PV через PVC директории в контейнерах подов в Namespace Default и Stage
3. Подключить к PV через PVC и StorageClass директории в контейнерах подов в Namespace Default и Stage

### Ответ: такое решение, когда из разных Namespace поды пытаются получить доступ к одному и тоиу же тому, невозможно.

### Ход выполнения
#### 1. Настроить локальный PV на ноде

1. Создаем манифест PV.
  - имя - `pv`
  - storageClassName: "" - по умолчанию. В кластере пока никакого SC нет. Будем устанавливать `nfs-server`
  - accessModes: ReadWriteMany - режим доступа "Читать и записывать для многих"
  - capacity: storage: 2Gi - размер хранилища
  - hostPath: path: /data/pv - директория хранилища на ноде

* pv.yaml

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
2. Как мы видим, нам необходимо создать еще и манифест для StorageClass. При установке `nfs-server` будет создан автоматический SC, 
но мы создадим свой со своими параметрами.
  - назовем объект так, как мы указали в ссылке на него в манифесте PV - `nfs`
  - 

* sc.yaml

```yml
не создавался
```

3. Создаем манифест запроса `PersistentVolumeClaim` на хранилище 


* pvc.yaml

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```


* pod.yanl

```yml
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

#### Логи Задачи 1

```
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  86480      0 --:--:-- --:--:-- --:--:-- 87156
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
controlplane $ 
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
LAST DEPLOYED: Wed Jul 20 15:28:23 2022
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
controlplane $ apt install nfs-common -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 194 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (405 kB/s)      
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
Preparing to unpack .../3-keyutils_1.6-6ubuntu1.1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1.1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1.1) ...
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
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ vi pod.yaml
controlplane $ 
controlplane $ mv pod.yaml pod-without-pvc.yaml 
controlplane $ 
controlplane $ vi pod-with-pvc.yaml 
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   3m42s
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv                            
No resources found
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     72d
nfs-server-nfs-server-provisioner   ClusterIP   10.101.45.66   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   3m58s
controlplane $ 
controlplane $ kubectl describe svc nfs-server-nfs-server-provisioner 
Name:              nfs-server-nfs-server-provisioner
Namespace:         default
Labels:            app=nfs-server-provisioner
                   app.kubernetes.io/managed-by=Helm
                   chart=nfs-server-provisioner-1.1.3
                   heritage=Helm
                   release=nfs-server
Annotations:       meta.helm.sh/release-name: nfs-server
                   meta.helm.sh/release-namespace: default
Selector:          app=nfs-server-provisioner,release=nfs-server
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.101.45.66
IPs:               10.101.45.66
Port:              nfs  2049/TCP
TargetPort:        nfs/TCP
Endpoints:         192.168.1.4:2049
Port:              nfs-udp  2049/UDP
TargetPort:        nfs-udp/UDP
Endpoints:         192.168.1.4:2049
Port:              nlockmgr  32803/TCP
TargetPort:        nlockmgr/TCP
Endpoints:         192.168.1.4:32803
Port:              nlockmgr-udp  32803/UDP
TargetPort:        nlockmgr-udp/UDP
Endpoints:         192.168.1.4:32803
Port:              mountd  20048/TCP
TargetPort:        mountd/TCP
Endpoints:         192.168.1.4:20048
Port:              mountd-udp  20048/UDP
TargetPort:        mountd-udp/UDP
Endpoints:         192.168.1.4:20048
Port:              rquotad  875/TCP
TargetPort:        rquotad/TCP
Endpoints:         192.168.1.4:875
Port:              rquotad-udp  875/UDP
TargetPort:        rquotad-udp/UDP
Endpoints:         192.168.1.4:875
Port:              rpcbind  111/TCP
TargetPort:        rpcbind/TCP
Endpoints:         192.168.1.4:111
Port:              rpcbind-udp  111/UDP
TargetPort:        rpcbind-udp/UDP
Endpoints:         192.168.1.4:111
Port:              statd  662/TCP
TargetPort:        statd/TCP
Endpoints:         192.168.1.4:662
Port:              statd-udp  662/UDP
TargetPort:        statd-udp/UDP
Endpoints:         192.168.1.4:662
Session Affinity:  None
Events:            <none>
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ date   
Wed Jul 20 15:36:19 UTC 2022
controlplane $ 
controlplane $ kubectl apply -f pod-without-pvc.yaml 
pod/pod-without-pvc created
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          8m24s
pod-without-pvc                       1/1     Running   0          8s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl edit pod pod-without-pvc 
error: pods "pod-without-pvc" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-593576940.yaml"
error: Edit cancelled, no valid changes were saved.
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          13m
pod-without-pvc                       1/1     Running   0          4m51s
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod-without-pvc" deleted
Error from server (NotFound): error when deleting "pod-with-pvc.yaml": pods "pod" not found
controlplane $ 
controlplane $ kubectl delete -f pod-without-pvc.yaml 
Error from server (NotFound): error when deleting "pod-without-pvc.yaml": pods "pod-without-pvc" not found
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          14m
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pod-with-pvc.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          15m
pod                                   0/1     Pending   0          3s
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pod
controlplane $ 
controlplane $ kubectl logs pod pod
error: container pod is not valid for pod pod
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ vi pv.yaml
controlplane $ 
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pod
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          19m
pod                                   0/1     Pending   0          4m21s
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv 
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     15s
controlplane $ 
controlplane $ kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     28s
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          24m
pod                                   0/1     Pending   0          9m6s
controlplane $ 
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   0/1     Pending   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   0/1     Pending   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   0/1     Pending   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   0/1     Pending   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS              RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running             0          27m
pod                                   0/1     ContainerCreating   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   1/1     Running   0          11m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          27m
pod                                   1/1     Running   0          11m
controlplane $ 
controlplane $ 
controlplane $ date
Wed Jul 20 15:55:44 UTC 2022
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 20 15:54 .
drwx------ 8 root root 4.0K Jul 20 15:54 ..
-rw-r--r-- 1 root root  266 Jul 20 15:31 pod-with-pvc.yaml
-rw-r--r-- 1 root root  116 Jul 20 15:30 pod-without-pvc.yaml
-rw-r--r-- 1 root root  186 Jul 20 15:47 pv.yaml
-rw-r--r-- 1 root root  178 Jul 20 15:54 pvc.yaml
controlplane $ 
controlplane $ kubectl logs pod
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/20 15:55:35 [notice] 1#1: using the "epoll" event method
2022/07/20 15:55:35 [notice] 1#1: nginx/1.23.1
2022/07/20 15:55:35 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/20 15:55:35 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/20 15:55:35 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/20 15:55:35 [notice] 1#1: start worker processes
2022/07/20 15:55:35 [notice] 1#1: start worker process 30
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# ls -lha | grep static
drwxrwsrwx   2 root root 4.0K Jul 20 15:55 static
root@pod:/# 
root@pod:/# kubectl get pv,pvc,sc,svc
bash: kubectl: command not found
root@pod:/# 
root@pod:/# 
root@pod:/# 
root@pod:/# exit
exit
command terminated with exit code 127
controlplane $ 
controlplane $ kubectl get pv,pvc,sc,svc
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv                                         2Gi        RWX            Retain           Available                 nfs                     10m
persistentvolume/pvc-5b699f03-7a98-40e3-80c5-e62a3dbfb3ec   2Gi        RWO            Delete           Bound       default/pvc   nfs                     3m26s

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pvc-5b699f03-7a98-40e3-80c5-e62a3dbfb3ec   2Gi        RWO            nfs            3m26s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   30m

NAME                                        TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
service/kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     72d
service/nfs-server-nfs-server-provisioner   ClusterIP   10.101.45.66   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   30m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 20 15:54 .
drwx------ 8 root root 4.0K Jul 20 15:54 ..
-rw-r--r-- 1 root root  266 Jul 20 15:31 pod-with-pvc.yaml
-rw-r--r-- 1 root root  116 Jul 20 15:30 pod-without-pvc.yaml
-rw-r--r-- 1 root root  186 Jul 20 15:47 pv.yaml
-rw-r--r-- 1 root root  178 Jul 20 15:54 pvc.yaml
controlplane $ 
controlplane $ cat pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ cat pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
controlplane $ 
controlplane $ 
controlplane $ kubectl edit pvc pvc   
error: persistentvolumeclaims "pvc" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-3574444333.yaml"
error: Edit cancelled, no valid changes were saved.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ls -lha /tmp
total 88K
drwxrwxrwt 18 root root 4.0K Jul 20 16:04 .
drwxr-xr-x 20 root root 4.0K Jul 20 15:27 ..
drwxrwxrwt  2 root root 4.0K May  2 10:20 .ICE-unix
drwxrwxrwt  2 root root 4.0K May  2 10:20 .Test-unix
drwxrwxrwt  2 root root 4.0K May  2 10:20 .X11-unix
drwxrwxrwt  2 root root 4.0K May  2 10:20 .XIM-unix
drwxrwxrwt  2 root root 4.0K May  2 10:20 .font-unix
drwxr-xr-x  2 root root 4.0K May  2 10:24 4e15c3fe-ac03-42c5-809b-17b854249267
drwxr-xr-x  2 root root 4.0K May  2 10:24 github-remote
drwxr-xr-x  2 root root 4.0K May  2 10:24 http-remote
-rw-------  1 root root 1.3K Jul 20 16:03 kubectl-edit-2041251330.yaml
-rw-------  1 root root 3.3K Jul 20 15:41 kubectl-edit-2662299670.yaml
-rw-------  1 root root 1.8K Jul 20 16:03 kubectl-edit-3574444333.yaml
-rw-------  1 root root 3.5K Jul 20 15:41 kubectl-edit-593576940.yaml
drwx------  2 root root 4.0K May  2 10:20 netplan_o4qw481v
drwx------  3 root root 4.0K May  2 10:20 snap.lxd
drwx------  3 root root 4.0K May  8 19:30 systemd-private-8331619705d04508a430ef0383463737-fwupd.service-snfJVe
drwx------  3 root root 4.0K May  2 10:20 systemd-private-8331619705d04508a430ef0383463737-systemd-logind.service-8DUzMh
drwx------  3 root root 4.0K Jul 20 16:03 systemd-private-8331619705d04508a430ef0383463737-systemd-resolved.service-cGb8Yi
drwx------  3 root root 4.0K May  8 19:46 systemd-private-8331619705d04508a430ef0383463737-systemd-timesyncd.service-k2J6gi
drwxr-xr-x  2 root root 4.0K May  2 10:24 theia_upload
drwx------  2 root root 4.0K May  8 19:34 tmp7y9g2e5o

controlplane $ 
controlplane $ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM         STORAGECLASS   REASON   AGE
pv                                         2Gi        RWX            Retain           Available                 nfs                     31m
pvc-5b699f03-7a98-40e3-80c5-e62a3dbfb3ec   2Gi        RWO            Delete           Bound       default/pvc   nfs                     24m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     31m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl describe pv pv 
Name:            pv
Labels:          <none>
Annotations:     <none>
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Available
Claim:           
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv pv -o yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"PersistentVolume","metadata":{"annotations":{},"name":"pv"},"spec":{"accessModes":["ReadWriteMany"],"capacity":{"storage":"2Gi"},"hostPath":{"path":"/data/pv"},"storageClassName":"nfs"}}
  creationTimestamp: "2022-07-20T15:47:52Z"
  finalizers:
  - kubernetes.io/pv-protection
  name: pv
  resourceVersion: "3698"
  uid: 3a74d61a-6a5c-4a42-8360-f4208c076941
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
    type: ""
  persistentVolumeReclaimPolicy: Retain
  storageClassName: nfs
  volumeMode: Filesystem
status:
  phase: Available
```
### 2. Подключить к PV через PVC директории в контейнерах подов в Namespace Default и Stage

1. PV не принадлежит Namespace, поэтому это будет один манифест
* pv.yaml
```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```

2. Создаем манифесты Pod, PVC для Default 
* default-pod.yaml
```yml
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
* default-pvc.yaml

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

```


2. Создаем манифесты Pod, PVC для  Stage

* stage-pod.yaml
```yml
apiVersion: v1
kind: Pod
metadata:
  name: pod
  namespace: stage
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

* stage-pvc.yaml

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
namespace: stage
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi

```
### Ответ: такое решение, когда из разных Namespace поды пытаются получить доступ к одному и тоиу же тому, невозможно.
#### Логи

```
controlplane $ 
controlplane $ 
controlplane $ date
Wed Jul 20 16:29:03 UTC 2022
controlplane $ 
controlplane $ mkdir -p My-project
controlplane $ 
controlplane $ cd My-project/
controlplane $ 
controlplane $ vi pv.yaml
controlplane $ 
controlplane $ vi default-pvc.yaml
controlplane $ 
controlplane $ vi default-pod.yaml
controlplane $ 
controlplane $ vi stage-pvc.yaml
controlplane $ 
controlplane $ vi stage-pod.yaml
controlplane $ 
controlplane $ kubectl create namespace stage 
namespace/stage created
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   72d
kube-node-lease   Active   72d
kube-public       Active   72d
kube-system       Active   72d
stage             Active   6s
controlplane $ 
controlplane $ date
Wed Jul 20 16:32:45 UTC 2022
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 20 16:32 .
drwx------ 8 root root 4.0K Jul 20 16:32 ..
-rw-r--r-- 1 root root  266 Jul 20 16:31 default-pod.yaml
-rw-r--r-- 1 root root  179 Jul 20 16:31 default-pvc.yaml
-rw-r--r-- 1 root root  186 Jul 20 16:30 pv.yaml
-rw-r--r-- 1 root root  285 Jul 20 16:32 stage-pod.yaml
-rw-r--r-- 1 root root  193 Jul 20 16:31 stage-pvc.yaml
controlplane $ 
controlplane $ cat pv
cat: pv: No such file or directory
controlplane $ 
controlplane $ cat pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat default-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ cat default-pod.yaml
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
controlplane $ 
controlplane $ 
controlplane $ cat stage-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
namespace: stage
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ cat stage-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod
  namespace: stage
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
controlplane $ 
controlplane $ 
controlplane $ date
Wed Jul 20 16:34:06 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   6m53s
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get pv 
No resources found
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          7m10s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f .
pod/pod created
persistentvolumeclaim/pvc created
persistentvolume/pv created
pod/pod created
error: error validating "stage-pvc.yaml": error validating data: ValidationError(PersistentVolumeClaim): unknown field "namespace" in io.k8s.api.core.v1.PersistentVolumeClaim; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          8m56s
pod                                   1/1     Running   0          64s
controlplane $ 
controlplane $ kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Bound    default/pvc   nfs                     71s
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            77s
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   9m20s
controlplane $ 
controlplane $ kubectl logs pod pod
error: container pod is not valid for pod pod
controlplane $ 
controlplane $ kubectl logs pod    
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/20 16:35:24 [notice] 1#1: using the "epoll" event method
2022/07/20 16:35:24 [notice] 1#1: nginx/1.23.1
2022/07/20 16:35:24 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/20 16:35:24 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/20 16:35:24 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/20 16:35:24 [notice] 1#1: start worker processes
2022/07/20 16:35:24 [notice] 1#1: start worker process 30
controlplane $ 
controlplane $ kubectl exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# ls -lha | grep static
drwxr-xr-x   2 root root 4.0K Jul 20 16:35 static
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# echo '42' > 42.txt
root@pod:/static# 
root@pod:/static# ls -lha
total 12K
drwxr-xr-x 2 root root 4.0K Jul 20 16:38 .
drwxr-xr-x 1 root root 4.0K Jul 20 16:35 ..
-rw-r--r-- 1 root root    3 Jul 20 16:38 42.txt
root@pod:/static# 
root@pod:/static# 
root@pod:/static# exit
exit
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          5m
controlplane $ 
controlplane $ kubectl -n stage get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   13m
controlplane $ 
controlplane $ kubectl -n stage get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Bound    default/pvc   nfs                     5m15s
controlplane $ 
controlplane $ kubectl -n stage get pvc
No resources found in stage namespace.
controlplane $ 
controlplane $ 
controlplane $ vi stage-pvc.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9   2Gi        RWX            nfs            7s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME   READY   STATUS              RESTARTS   AGE
pod    0/1     ContainerCreating   0          6m36s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          6m40s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# ls -lha
total 92K
drwxr-xr-x   1 root root 4.0K Jul 20 16:41 .
drwxr-xr-x   1 root root 4.0K Jul 20 16:41 ..
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 bin
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 boot
drwxr-xr-x   5 root root  360 Jul 20 16:41 dev
drwxr-xr-x   1 root root 4.0K Jul 19 19:20 docker-entrypoint.d
-rwxrwxr-x   1 root root 1.2K Jul 19 19:19 docker-entrypoint.sh
drwxr-xr-x   1 root root 4.0K Jul 20 16:41 etc
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 home
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 lib
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 media
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 opt
dr-xr-xr-x 244 root root    0 Jul 20 16:41 proc
drwx------   2 root root 4.0K Jul 11 00:00 root
drwxr-xr-x   1 root root 4.0K Jul 20 16:41 run
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 sbin
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 srv
drwxrwsrwx   2 root root 4.0K Jul 20 16:41 static
dr-xr-xr-x  13 root root    0 Jul 20 16:41 sys
drwxrwxrwt   1 root root 4.0K Jul 19 19:20 tmp
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 usr
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 var
root@pod:/# 
root@pod:/# ls static/
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# ls
root@pod:/static# 
root@pod:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 20 16:41 .
drwxr-xr-x 1 root root 4.0K Jul 20 16:41 ..
root@pod:/static# 
root@pod:/static# echo '43' > 43.txt
root@pod:/static# 
root@pod:/static# exit
exit
controlplane $ 
controlplane $ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pv                                         2Gi        RWX            Retain           Bound    default/pvc   nfs                     8m48s
pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9   2Gi        RWX            Delete           Bound    stage/pvc     nfs                     2m26s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pv                                         2Gi        RWX            Retain           Bound    default/pvc   nfs                     9m13s
pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9   2Gi        RWX            Delete           Bound    stage/pvc     nfs                     2m51s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage describe pv pv
Name:            pv
Labels:          <none>
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           default/pvc
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ kubectl -n stage describe pv pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9 
Name:            pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9
Labels:          <none>
Annotations:     EXPORT_block:
                   
                   EXPORT
                   {
                     Export_Id = 1;
                     Path = /export/pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9;
                     Pseudo = /export/pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9;
                     Access_Type = RW;
                     Squash = no_root_squash;
                     SecType = sys;
                     Filesystem_id = 1.1;
                     FSAL {
                       Name = VFS;
                     }
                   }
                 Export_Id: 1
                 Project_Id: 0
                 Project_block: 
                 Provisioner_Id: d0061fa2-f69e-405f-ba71-d2bc6f3eec8a
                 kubernetes.io/createdby: nfs-dynamic-provisioner
                 pv.kubernetes.io/provisioned-by: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           stage/pvc
Reclaim Policy:  Delete
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:      NFS (an NFS mount that lasts the lifetime of a pod)
    Server:    10.105.88.189
    Path:      /export/pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9
    ReadOnly:  false
Events:        <none>
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat default-pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ cat stage-pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   19m
controlplane $ 
controlplane $ kubectl -n stage get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   19m
controlplane $ 
controlplane $ 
controlplane $ kubectl describe storageclasses.storage.k8s.io nfs
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
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io -o yaml
apiVersion: v1
items:
- allowVolumeExpansion: true
  apiVersion: storage.k8s.io/v1
  kind: StorageClass
  metadata:
    annotations:
      meta.helm.sh/release-name: nfs-server
      meta.helm.sh/release-namespace: default
    creationTimestamp: "2022-07-20T16:27:25Z"
    labels:
      app: nfs-server-provisioner
      app.kubernetes.io/managed-by: Helm
      chart: nfs-server-provisioner-1.1.3
      heritage: Helm
      release: nfs-server
    name: nfs
    resourceVersion: "2980"
    uid: b4628178-887d-46a0-b34b-65138fff2a67
  mountOptions:
  - vers=3
  provisioner: cluster.local/nfs-server-nfs-server-provisioner
  reclaimPolicy: Delete
  volumeBindingMode: Immediate
kind: List
metadata:
  resourceVersion: ""
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            17m
controlplane $ 
controlplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pv
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWX
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type    Reason                 Age   From                                                                                                                      Message
  ----    ------                 ----  ----                                                                                                                      -------
  Normal  ExternalProvisioning   17m   persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           17m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  17m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  Successfully provisioned volume pvc-e9621760-9af1-4889-9a2d-7191c56af672
controlplane $ 
controlplane $ 
controlplane $ ping nfs-server
ping: nfs-server: Name or service not known
controlplane $ 
controlplane $ ping nfs-common
ping: nfs-common: Name or service not known
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            26m
controlplane $ 
controlplane $ kubectl get -n stage pvc pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9   2Gi        RWX            nfs            20m
controlplane $ 
controlplane $ kubectl describe -n stage pvc pvc
Name:          pvc
Namespace:     stage
StorageClass:  nfs
Status:        Bound
Volume:        pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWX
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type    Reason                 Age   From                                                                                                                      Message
  ----    ------                 ----  ----                                                                                                                      -------
  Normal  ExternalProvisioning   20m   persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           20m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  External provisioner is provisioning volume for claim "stage/pvc"
  Normal  ProvisioningSucceeded  20m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  Successfully provisioned volume pvc-befd0ddc-87cf-41c6-81b1-ee5711739aa9
controlplane $ 
controlplane $ 
controlplane $ kubectl describe pvc pvc
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pv
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWX
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type    Reason                 Age   From                                                                                                                      Message
  ----    ------                 ----  ----                                                                                                                      -------
  Normal  ExternalProvisioning   27m   persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           27m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  27m   cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_65e90db0-4105-444d-b3f6-7724803cea4f  Successfully provisioned volume pvc-e9621760-9af1-4889-9a2d-7191c56af672
controlplane $ 
controlplane $ cat default-pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat stage-pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ cat pv.yaml        
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ cp pv.yaml stage-pv.yaml
controlplane $ 
controlplane $ vi stage-pv.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          32m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n default get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          40m
pod                                   1/1     Running   0          32m
controlplane $ 
controlplane $ kubectl apply -f stage-pv.yaml  
persistentvolume/pv unchanged
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Jul 20 17:06 .
drwx------ 8 root root 4.0K Jul 20 17:06 ..
-rw-r--r-- 1 root root  266 Jul 20 16:31 default-pod.yaml
-rw-r--r-- 1 root root  179 Jul 20 16:31 default-pvc.yaml
-rw-r--r-- 1 root root  186 Jul 20 16:30 pv.yaml
-rw-r--r-- 1 root root  285 Jul 20 16:32 stage-pod.yaml
-rw-r--r-- 1 root root  205 Jul 20 17:06 stage-pv.yaml
-rw-r--r-- 1 root root  198 Jul 20 16:41 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ cat pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat stage-pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ mv pv.yaml default-pv.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Jul 20 17:09 .
drwx------ 8 root root 4.0K Jul 20 17:06 ..
-rw-r--r-- 1 root root  266 Jul 20 16:31 default-pod.yaml
-rw-r--r-- 1 root root  186 Jul 20 16:30 default-pv.yaml
-rw-r--r-- 1 root root  179 Jul 20 16:31 default-pvc.yaml
-rw-r--r-- 1 root root  285 Jul 20 16:32 stage-pod.yaml
-rw-r--r-- 1 root root  205 Jul 20 17:06 stage-pv.yaml
-rw-r--r-- 1 root root  198 Jul 20 16:41 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod" deleted
persistentvolume "pv" deleted
persistentvolumeclaim "pvc" deleted
pod "pod" deleted
persistentvolume "pv" deleted
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f .
pod/pod created
persistentvolume/pv created
persistentvolumeclaim/pvc created
pod/pod created
persistentvolume/pv unchanged
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          44m
pod                                   1/1     Running   0          14s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          26s
controlplane $ 
controlplane $ kubectl -n stage get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pv                                         2Gi        RWX            Retain           Bound    default/pvc   nfs                     41s
pvc-35cb3b31-036e-4f39-853e-ca617ea4f3bc   2Gi        RWX            Delete           Bound    stage/pvc     nfs                     41s
controlplane $ 
controlplane $ 
controlplane $ kubectl describe -n stage pv pv
Name:            pv
Labels:          <none>
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           default/pvc
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ 
controlplane $ kubectl describe -n default pv pv
Name:            pv
Labels:          <none>
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           default/pvc
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod pod -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "fd77eecbc044dbd316dc3d13001ac4b3c527dd72541d28d97f15eab5d3715b09": OCI runtime exec failed: exec failed: unable to start container process: exec: "pod": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl exec pod -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# ls -lha | i grep static
bash: i: command not found
root@pod:/# 
root@pod:/# ls -lha | grep static
drwxr-xr-x   2 root root 4.0K Jul 20 16:38 static
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# ls
42.txt
root@pod:/static# 
root@pod:/static# 
root@pod:/static# 
root@pod:/static# ls -lha
total 12K
drwxr-xr-x 2 root root 4.0K Jul 20 16:38 .
drwxr-xr-x 1 root root 4.0K Jul 20 17:11 ..
-rw-r--r-- 1 root root    3 Jul 20 16:38 42.txt
root@pod:/static# 
root@pod:/static# 
root@pod:/static# exit
exit
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Jul 20 17:09 .
drwx------ 8 root root 4.0K Jul 20 17:06 ..
-rw-r--r-- 1 root root  266 Jul 20 16:31 default-pod.yaml
-rw-r--r-- 1 root root  186 Jul 20 16:30 default-pv.yaml
-rw-r--r-- 1 root root  179 Jul 20 16:31 default-pvc.yaml
-rw-r--r-- 1 root root  285 Jul 20 16:32 stage-pod.yaml
-rw-r--r-- 1 root root  205 Jul 20 17:06 stage-pv.yaml
-rw-r--r-- 1 root root  198 Jul 20 16:41 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ 
```

controlplane $ cat default-pod.yaml
```yml
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
controlplane $ 
controlplane $ cat default-pv.yaml
```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
controlplane $ 
controlplane $ cat default-pvc.yaml
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
```
controlplane $ 
controlplane $ ls -lha
total 32K
drwxr-xr-x 2 root root 4.0K Jul 20 17:09 .
drwx------ 8 root root 4.0K Jul 20 17:06 ..
-rw-r--r-- 1 root root  266 Jul 20 16:31 default-pod.yaml
-rw-r--r-- 1 root root  186 Jul 20 16:30 default-pv.yaml
-rw-r--r-- 1 root root  179 Jul 20 16:31 default-pvc.yaml
-rw-r--r-- 1 root root  285 Jul 20 16:32 stage-pod.yaml
-rw-r--r-- 1 root root  205 Jul 20 17:06 stage-pv.yaml
-rw-r--r-- 1 root root  198 Jul 20 16:41 stage-pvc.yaml
```
controlplane $ 
controlplane $ cat stage-pod.yaml
```yml
apiVersion: v1
kind: Pod
metadata:
  name: pod
  namespace: stage
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
controlplane $ 
controlplane $ cat stage-pv.yaml
```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
controlplane $ 
controlplane $ cat stage-pvc.yaml
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
```

### Создаем свой StorageClass
* sc.yaml

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
### Ответ: такое решение, когда из разных Namespace поды пытаются получить доступ к одному и тоиу же тому, невозможно.
