### Подключение к NFS двух разных подов в default и stage
#### Tab 1
```
controlplane $ helm
helm: command not found
controlplane $ 
controlplane $ date
Tue Jul 19 13:50:06 UTC 2022
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   279k      0 --:--:-- --:--:-- --:--:--  279k
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
LAST DEPLOYED: Tue Jul 19 13:50:58 2022
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
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (449 kB/s)     
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
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get pv 
No resources found
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          57s
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   64s
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   72s
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1        <none>        443/TCP                                                                                                     71d
nfs-server-nfs-server-provisioner   ClusterIP   10.106.144.242   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   75s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ kubectl create namespace prod 
namespace/prod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   71d
kube-node-lease   Active   71d
kube-public       Active   71d
kube-system       Active   71d
prod              Active   10s
stage             Active   14s
controlplane $ 
controlplane $ date
Tue Jul 19 13:53:06 UTC 2022
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ 
controlplane $ vi pvc-default.yaml
controlplane $ 
controlplane $ vi pod-nginx-busybox.yaml
controlplane $ 
controlplane $ vi pod-nginx.yaml
controlplane $ 
controlplane $ vi stage-pod-nginx.yaml
controlplane $ 
controlplane $ vi prod-pod-nginx.yaml
controlplane $ 
controlplane $ vi stage-pod-nginx.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 19 14:00 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 pod-nginx.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 pvc-default.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
controlplane $ 
controlplane $ date
Tue Jul 19 14:00:49 UTC 2022
controlplane $ 
controlplane $ mv pod-nginx-busybox.yaml default-pod-nginx-busybox.yaml 
controlplane $ 
controlplane $ mv pod-nginx.yaml default-pod-nginx.yaml 
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 19 14:02 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 pvc-default.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
controlplane $ 
controlplane $ mv pvc-default.yaml default.pvc
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 19 14:02 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default.pvc
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
controlplane $ 
controlplane $ mv default.pvc default-pvc.yaml
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 19 14:02 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
controlplane $ 
controlplane $ date
Tue Jul 19 14:03:16 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          13m
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get pv 
No resources found
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   13m
controlplane $ 
controlplane $ 
controlplane $ date
Tue Jul 19 14:04:28 UTC 2022
controlplane $ 
controlplane $ kubectl apply -f default-pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            nfs            5s
controlplane $ 
controlplane $ cat default-pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   14m
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f default-pod-nginx.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          17m
pod                                   1/1     Running   0          8s
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 2 root root 4.0K Jul 19 14:02 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
controlplane $ 
controlplane $ cp default-pvc.yaml stage-pvc.yaml
controlplane $ 
controlplane $ cp default-pvc.yaml prod-pvc.yaml
controlplane $ 
controlplane $ ls -lha
total 36K
drwxr-xr-x 2 root root 4.0K Jul 19 14:09 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 stage-pvc.yaml
controlplane $ 
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get po,pvc,pv,sc
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     6m23s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   20m
controlplane $ 
controlplane $ kubectl -n prod get po,pvc,pv,sc
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     7m2s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   20m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po,pvc,pv,sc
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     7m7s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   20m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod get po,pvc,pv,sc
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     7m15s

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   21m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n default get po,pvc,pv,sc
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          23m
pod/pod                                   1/1     Running   0          6m18s

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            nfs            10m

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     10m

NAME                              PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/nfs   cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   23m
controlplane $ 
controlplane $ ls -lha
total 36K
drwxr-xr-x 2 root root 4.0K Jul 19 14:09 .
drwx------ 8 root root 4.0K Jul 19 14:00 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  288 Jul 19 14:00 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  289 Jul 19 13:59 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 stage-pvc.yaml
controlplane $ 
controlplane $ vi prod-pod-nginx.yaml 
controlplane $ 
controlplane $ vi stage-pod-nginx.yaml 
controlplane $ 
controlplane $ 
controlplane $ vi default-pv.yaml
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
    creationTimestamp: "2022-07-19T13:50:59Z"
    labels:
      app: nfs-server-provisioner
      app.kubernetes.io/managed-by: Helm
      chart: nfs-server-provisioner-1.1.3
      heritage: Helm
      release: nfs-server
    name: nfs
    resourceVersion: "1555"
    uid: bafb3ba6-bcbf-490f-8e84-5de146214b9f
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
controlplane $ date
Tue Jul 19 14:22:47 UTC 2022
controlplane $ 
controlplane $ ls -lha
total 40K
drwxr-xr-x 2 root root 4.0K Jul 19 14:20 .
drwx------ 8 root root 4.0K Jul 19 14:20 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  194 Jul 19 14:20 default-pv.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  293 Jul 19 14:16 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  295 Jul 19 14:17 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat default-pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-default
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ cat default-pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# ls -lha | grep static
drwxrwsrwx   2 root root 4.0K Jul 19 14:04 static
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 19 14:04 .
drwxr-xr-x 1 root root 4.0K Jul 19 14:08 ..
root@pod:/static# 
root@pod:/static# echo '42' > 42.txt
root@pod:/static# 
root@pod:/static# ls -lha
total 12K
drwxrwsrwx 2 root root 4.0K Jul 19 14:27 .
drwxr-xr-x 1 root root 4.0K Jul 19 14:08 ..
-rw-r--r-- 1 root root    3 Jul 19 14:27 42.txt
root@pod:/static# 
root@pod:/static# cat 42.txt 
42
root@pod:/static# 
root@pod:/static# ls -lha
total 12K
drwxrwsrwx 2 root root 4.0K Jul 19 14:27 .
drwxr-xr-x 1 root root 4.0K Jul 19 14:08 ..
-rw-r--r-- 1 root root    3 Jul 19 14:27 42.txt
root@pod:/static# 
root@pod:/static# exit
exit
controlplane $ 
controlplane $ ls -lha
total 40K
drwxr-xr-x 2 root root 4.0K Jul 19 14:20 .
drwx------ 8 root root 4.0K Jul 19 14:20 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  194 Jul 19 14:20 default-pv.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  293 Jul 19 14:16 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  295 Jul 19 14:17 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 stage-pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f stage-pod-nginx.yaml 
pod/pod-stage created
controlplane $ 
controlplane $ kubectl -n stage get po
NAME        READY   STATUS    RESTARTS   AGE
pod-stage   0/1     Pending   0          16s
controlplane $ 
controlplane $ kubectl -n stage get pvc
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     25m
controlplane $ 
controlplane $ kubectl logs -n stage pod-stage 
controlplane $ 
controlplane $ kubectl logs -n stage pod       
Error from server (NotFound): pods "pod" not found
controlplane $ 
controlplane $ kubectl logs -n stage pod-stage 
controlplane $ 
controlplane $ kubectl apply -f stage-pvc.yaml 
persistentvolumeclaim/pvc unchanged
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME        READY   STATUS    RESTARTS   AGE
pod-stage   0/1     Pending   0          2m17s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME        READY   STATUS    RESTARTS   AGE
pod-stage   0/1     Pending   0          2m23s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME        READY   STATUS    RESTARTS   AGE
pod-stage   0/1     Pending   0          2m52s
controlplane $ 
controlplane $ kubectl -n stage get po,pv
NAME            READY   STATUS    RESTARTS   AGE
pod/pod-stage   0/1     Pending   0          3m6s

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0   2Gi        RWX            Delete           Bound    default/pvc   nfs                     28m
controlplane $ 
controlplane $ kubectl -n stage get po,pvc
NAME            READY   STATUS    RESTARTS   AGE
pod/pod-stage   0/1     Pending   0          3m12s
controlplane $ 
controlplane $ 
controlplane $ cat stage-pvc.yaml 
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ vim stage-pvc.yaml 
controlplane $ 
controlplane $ kubectl apply -f stage-pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po,pvc
NAME            READY   STATUS              RESTARTS   AGE
pod/pod-stage   0/1     ContainerCreating   0          4m53s

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pvc-cd0cfdd7-a047-4213-a283-2f642dfc0961   2Gi        RWX            nfs            5s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po,pvc
NAME            READY   STATUS    RESTARTS   AGE
pod/pod-stage   1/1     Running   0          4m57s

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pvc-cd0cfdd7-a047-4213-a283-2f642dfc0961   2Gi        RWX            nfs            9s
controlplane $ 
controlplane $ 
controlplane $ kubectl exec -n stage pod-stage -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod-stage:/# 
root@pod-stage:/# pwd
/
root@pod-stage:/# 
root@pod-stage:/# ls -lha
total 92K
drwxr-xr-x   1 root root 4.0K Jul 19 14:34 .
drwxr-xr-x   1 root root 4.0K Jul 19 14:34 ..
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 bin
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 boot
drwxr-xr-x   5 root root  360 Jul 19 14:34 dev
drwxr-xr-x   1 root root 4.0K Jul 12 05:00 docker-entrypoint.d
-rwxrwxr-x   1 root root 1.2K Jul 12 05:00 docker-entrypoint.sh
drwxr-xr-x   1 root root 4.0K Jul 19 14:34 etc
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 home
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 lib
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 media
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 opt
dr-xr-xr-x 240 root root    0 Jul 19 14:34 proc
drwx------   2 root root 4.0K Jul 11 00:00 root
drwxr-xr-x   1 root root 4.0K Jul 19 14:34 run
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 sbin
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 srv
drwxrwsrwx   2 root root 4.0K Jul 19 14:34 static
dr-xr-xr-x  13 root root    0 Jul 19 14:34 sys
drwxrwxrwt   1 root root 4.0K Jul 12 05:00 tmp
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 usr
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 var
root@pod-stage:/# 
root@pod-stage:/# cd static/
root@pod-stage:/static# 
root@pod-stage:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 19 14:34 .
drwxr-xr-x 1 root root 4.0K Jul 19 14:34 ..
root@pod-stage:/static# 
root@pod-stage:/static# 
root@pod-stage:/static# echo '43' > 43.txt
root@pod-stage:/static# 
root@pod-stage:/static# ls -lha
total 12K
drwxrwsrwx 2 root root 4.0K Jul 19 14:35 .
drwxr-xr-x 1 root root 4.0K Jul 19 14:34 ..
-rw-r--r-- 1 root root    3 Jul 19 14:35 43.txt
root@pod-stage:/static# 
root@pod-stage:/static# exit
exit
controlplane $ 
controlplane $ 
controlplane $ date
Tue Jul 19 14:37:37 UTC 2022
controlplane $ 
controlplane $ ls -lha
total 40K
drwxr-xr-x 2 root root 4.0K Jul 19 14:34 .
drwx------ 8 root root 4.0K Jul 19 14:34 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  194 Jul 19 14:20 default-pv.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  293 Jul 19 14:16 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  295 Jul 19 14:17 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  200 Jul 19 14:34 stage-pvc.yaml
controlplane $ 
controlplane $ cat default-pod-nginx-busybox.yaml default-pod-nginx.yaml default-pv.yaml default-pvc.yaml prod-pod-nginx.yaml prod-pvc.yaml stage-pod-nginx.yaml stage-pvc.yaml
kind: Pod
metadata:
  name: pod-int-volumes
spec:
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
    - name: busybox
      image: busybox
      command: ["sleep", "3600"]
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      emptyDir: {}
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
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-default
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

---
apiVersion: v1
kind: Pod
metadata:
  name: pod-prod
  namespace: prod
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
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

---
apiVersion: v1
kind: Pod
metadata:
  name: pod-stage
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
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 40K
drwxr-xr-x 2 root root 4.0K Jul 19 14:34 .
drwx------ 8 root root 4.0K Jul 19 14:34 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  194 Jul 19 14:20 default-pv.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  293 Jul 19 14:16 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  295 Jul 19 14:17 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  200 Jul 19 14:34 stage-pvc.yaml
controlplane $ 
controlplane $ cat default-pod-nginx-busybox.yaml
kind: Pod
metadata:
  name: pod-int-volumes
spec:
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
    - name: busybox
      image: busybox
      command: ["sleep", "3600"]
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      emptyDir: {}
controlplane $ 
controlplane $ cat default-pod-nginx.yaml
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
controlplane $ cat default-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-default
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ cat default-pvc.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ ls -lha
total 40K
drwxr-xr-x 2 root root 4.0K Jul 19 14:34 .
drwx------ 8 root root 4.0K Jul 19 14:34 ..
-rw-r--r-- 1 root root  381 Jul 19 13:57 default-pod-nginx-busybox.yaml
-rw-r--r-- 1 root root  270 Jul 19 13:58 default-pod-nginx.yaml
-rw-r--r-- 1 root root  194 Jul 19 14:20 default-pv.yaml
-rw-r--r-- 1 root root  181 Jul 19 13:54 default-pvc.yaml
-rw-r--r-- 1 root root  293 Jul 19 14:16 prod-pod-nginx.yaml
-rw-r--r-- 1 root root  181 Jul 19 14:09 prod-pvc.yaml
-rw-r--r-- 1 root root  295 Jul 19 14:17 stage-pod-nginx.yaml
-rw-r--r-- 1 root root  200 Jul 19 14:34 stage-pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ cat prod-pod-nginx.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-prod
  namespace: prod
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
controlplane $ cat prod-pvc.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ cat stage-pod-nginx.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-stage
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
controlplane $ cat stage-pvc.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi

controlplane $ 
controlplane $ date
Tue Jul 19 14:44:00 UTC 2022
controlplane $ 
controlplane $ 
```
#### Tab 2
```
controlplane $ ssh node 01
ssh: Could not resolve hostname node: Name or service not known
controlplane $ 
controlplane $ 
controlplane $ apt install nfs-common -y
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
node01 $ apt install nfs-common -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 192 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (432 kB/s) 
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
node01 $ 
node01 $ 
node01 $ 
node01 $ date
Tue Jul 19 14:28:03 UTC 2022
node01 $ 
node01 $ find / -name 42.txt
/var/lib/kubelet/pods/453ff40a-8cd8-431c-9f9e-03a931a611ea/volumes/kubernetes.io~empty-dir/data/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0/42.txt
/var/lib/kubelet/pods/b44c9803-995b-4d22-88d0-e1b5249dc3dd/volumes/kubernetes.io~nfs/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0/42.txt
node01 $ 
node01 $ 
node01 $ ls -lha /var/lib/kubelet/pods/b44c9803-995b-4d22-88d0-e1b5249dc3dd/volumes/kubernetes.io~nfs/pvc-52779000-9f67-4ce1-96f2-3d42edae82d0/
total 12K
drwxrwsrwx 2 root root 4.0K Jul 19 14:27 .
drwxr-x--- 3 root root 4.0K Jul 19 14:08 ..
-rw-r--r-- 1 root root    3 Jul 19 14:27 42.txt
node01 $ 
node01 $ find / -name 43.txt
/var/lib/kubelet/pods/453ff40a-8cd8-431c-9f9e-03a931a611ea/volumes/kubernetes.io~empty-dir/data/pvc-cd0cfdd7-a047-4213-a283-2f642dfc0961/43.txt
node01 $ 
node01 $ 
node01 $ date
Tue Jul 19 14:37:05 UTC 2022
node01 $ 
node01 $ 
node01 $ 
node01 $ 
node01 $ 
node01 $ 
node01 $ ls -lha
total 28K
drwx------  3 root root 4.0K Jul 19 13:45 .
drwxr-xr-x 19 root root 4.0K May  2 10:23 ..
-rw-------  1 root root   10 Oct  8  2021 .bash_history
-rw-r--r--  1 root root 3.3K May  8 19:39 .bashrc
-rw-r--r--  1 root root  161 Dec  5  2019 .profile
drwx------  2 root root 4.0K May  2 10:20 .ssh
-rw-r--r--  1 root root  109 Jul 19 13:45 .vimrc
lrwxrwxrwx  1 root root    1 May  2 10:23 filesystem -> /
node01 $ 
node01 $ 
node01 $ exit
logout
Connection to node01 closed.
controlplane $ 
controlplane $ date
Tue Jul 19 14:45:07 UTC 2022
controlplane $ 
controlplane $ 
```
