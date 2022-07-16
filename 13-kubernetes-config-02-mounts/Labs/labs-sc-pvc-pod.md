## Успешная ЛР по запуску сервера NFS и днамческого создания PV

#### Установка NFS, запуск StorageClass на Control Node

#### Установка NFS Worker Node

#### Логи по запуску
* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
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
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```

* Лог Tab 1
```
controlplane $ 
controlplane $ date
Sat Jul 16 16:24:28 UTC 2022
controlplane $ 
controlplane $ kubectl get po
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get sc 
No resources found
controlplane $ 
controlplane $ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   68d
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
controlplane $ 
controlplane $ kubectl get csidrivers
No resources found
controlplane $ 
controlplane $ kubectl get pv 
No resources found
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ date
Sat Jul 16 16:26:56 UTC 2022
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && /
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  63386      0 --:--:-- --:--:-- --:--:-- 63386
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
controlplane $ 
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   91s
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
controlplane $ 
controlplane $ kubectl get csidrivers
No resources found
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   2m12s
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          3m13s
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ 
controlplan./
bash: ./: Is a directory
controlplane $ 
controlplane $  
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          12m
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   12m
controlplane $ 
controlplane $ kubectl get csidrivers
No resources found
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         68d
node01         0         68d
controlplane $ 
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Pending                                      my-nfs         15s
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Pending                                      my-nfs         30s
controlplane $ 
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
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f pvc.yaml 
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            nfs            36s
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            Delete           Bound    default/pvc   nfs                     55s
controlplane $ 
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          21m
controlplane $ 
controlplane $ cat pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
      
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ date
Sat Jul 16 16:49:04 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-40c0b077-37e5-4193-bf44-992074b9d4c6   2Gi        RWO            nfs            3m44s
controlplane $ 
controlplane $ 
controlplane $ 
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
controlplane $ 
controlplane $ 
controlplane $ kubectl logs po pod
Error from server (NotFound): pods "po" not found
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
2022/07/16 16:53:43 [notice] 1#1: using the "epoll" event method
2022/07/16 16:53:43 [notice] 1#1: nginx/1.23.0
2022/07/16 16:53:43 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/16 16:53:43 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/16 16:53:43 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/16 16:53:43 [notice] 1#1: start worker processes
2022/07/16 16:53:43 [notice] 1#1: start worker process 30
controlplane $ 
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
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat pod.yaml 
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
        
controlplane $ 
controlplane $ 
```

* Лог Tab 2

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
