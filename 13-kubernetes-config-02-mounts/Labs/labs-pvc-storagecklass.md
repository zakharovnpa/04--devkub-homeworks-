## ЛР по запуску сервера NFS и днамческого создания PV

---

### Устанавливаем NFS



### Манифест для создания PVC

* Манифест автоматически сгенерровался после выполнения установки 

`helm install nfs-server stable/nfs-server-provisioner`
* pvc.yaml
```yml
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

### В манифесте пода, в спецификаци указать имя PersistentVolumeClaim

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
          name: my-volume   # \
  volumes:                   #   >- имя должно быть одинаковое - my-volume
    - name: my-volume       # /
      persistentVolumeClaim:
        claimName: nfs   # имя должно быть повторено в pvc.yaml
```                                                                   
* pvc.yml                                                             
                                                                      
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
        storage: 100Mi
```
* storageclass.yml - не применялся при деплое

```yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-nfs
provisioner: cluster.local/nfs-server-nfs-server-provisioner
parameters:
  server: nfs-server-nfs-server-provisioner-0
  path: /share
  readOnly: "false"
```
#### После установки nfs-common появился StorageClass и provisioner
* Значит StorageClass деплоить не надо


```
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   4m54s

```

```
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

```
* #kubectl get sc nfs -o yaml
```yml
---
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    meta.helm.sh/release-name: nfs-server
    meta.helm.sh/release-namespace: default
  creationTimestamp: "2022-07-16T13:50:07Z"
  labels:
    app: nfs-server-provisioner
    app.kubernetes.io/managed-by: Helm
    chart: nfs-server-provisioner-1.1.3
    heritage: Helm
    release: nfs-server
  name: nfs
  resourceVersion: "2235"
  uid: ffa90acf-ec31-43ff-8e8c-e6f0c75561c3
mountOptions:
- vers=3
provisioner: cluster.local/nfs-server-nfs-server-provisioner
reclaimPolicy: Delete
volumeBindingMode: Immediate
```

#### Деплоим приложение, PVC

#### Логи с этими манифестами
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
          name: my-volume   # \
  volumes:                   #   >- имя должно быть одинаковое - my-volume
    - name: my-volume       # /
      persistentVolumeClaim:
        claimName: nfs   # имя должно быть повторено в pvc.yam
```
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
        storage: 100Mi
```


* Логи термнал 0
```
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   4m54s
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io -o wide
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   6m59s
controlplane $ 
controlplane $ kubectl get sc -o wide
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   7m9s
controlplane $ 
controlplane $ kubectl describe sc        
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
controlplane $ kubectl get sc nfs -o yaml
allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    meta.helm.sh/release-name: nfs-server
    meta.helm.sh/release-namespace: default
  creationTimestamp: "2022-07-16T13:50:07Z"
  labels:
    app: nfs-server-provisioner
    app.kubernetes.io/managed-by: Helm
    chart: nfs-server-provisioner-1.1.3
    heritage: Helm
    release: nfs-server
  name: nfs
  resourceVersion: "2235"
  uid: ffa90acf-ec31-43ff-8e8c-e6f0c75561c3
mountOptions:
- vers=3
provisioner: cluster.local/nfs-server-nfs-server-provisioner
reclaimPolicy: Delete
volumeBindingMode: Immediate
controlplane $ 
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ touch pod.yaml
controlplane $ 
controlplane $ touch pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f pod.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
error: error parsing pvc.yaml: error converting YAML to JSON: yaml: line 2: mapping values are not allowed in this context
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
error: error parsing pvc.yaml: error converting YAML to JSON: yaml: line 2: mapping values are not allowed in this context
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
error: error parsing pvc.yaml: error converting YAML to JSON: yaml: line 2: mapping values are not allowed in this context
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
error: error parsing pvc.yaml: error converting YAML to JSON: yaml: line 2: mapping values are not allowed in this context
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          34m
pod                                   0/1     Pending   0          7m34s
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1       <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.102.102.93   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   35m
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   35m
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          36m
pod                                   0/1     Pending   0          9m14s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl describe po nfs-server-nfs-server-provisioner-0 
Name:         nfs-server-nfs-server-provisioner-0
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Sat, 16 Jul 2022 13:50:07 +0000
Labels:       app=nfs-server-provisioner
              chart=nfs-server-provisioner-1.1.3
              controller-revision-hash=nfs-server-nfs-server-provisioner-64bd6d7f65
              heritage=Helm
              release=nfs-server
              statefulset.kubernetes.io/pod-name=nfs-server-nfs-server-provisioner-0
Annotations:  cni.projectcalico.org/containerID: 94d8d0b736094e169e9e1cf73373585f653038b0edf669269ba595a0ffe7d585
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  StatefulSet/nfs-server-nfs-server-provisioner
Containers:
  nfs-server-provisioner:
    Container ID:  containerd://647c68eefe68aed51c5021a48e3cc1f5996b23f7e776a5e86d6c1e2d00100a81
    Image:         quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    Image ID:      quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    Ports:         2049/TCP, 2049/UDP, 32803/TCP, 32803/UDP, 20048/TCP, 20048/UDP, 875/TCP, 875/UDP, 111/TCP, 111/UDP, 662/TCP, 662/UDP
    Host Ports:    0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP
    Args:
      -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    State:          Running
      Started:      Sat, 16 Jul 2022 13:50:13 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      POD_IP:          (v1:status.podIP)
      SERVICE_NAME:   nfs-server-nfs-server-provisioner
      POD_NAMESPACE:  default (v1:metadata.namespace)
    Mounts:
      /export from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-s9sh6 (ro)
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
  kube-api-access-s9sh6:
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
  Normal  Scheduled  36m   default-scheduler  Successfully assigned default/nfs-server-nfs-server-provisioner-0 to node01
  Normal  Pulling    36m   kubelet            Pulling image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0"
  Normal  Pulled     36m   kubelet            Successfully pulled image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0" in 5.375309182s
  Normal  Created    36m   kubelet            Created container nfs-server-provisioner
  Normal  Started    36m   kubelet            Started container nfs-server-provisioner
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ date
Sat Jul 16 14:28:02 UTC 2022
controlplane $ 
controlplane $ kubectl describe pvc
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pvc-42a5f26d-3b05-42b7-9089-d598258408d5
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      100Mi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                 Age                    From                                                                                                                      Message
  ----    ------                 ----                   ----                                                                                                                      -------
  Normal  ExternalProvisioning   4m56s (x2 over 4m56s)  persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           4m56s                  cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_6a47c896-9f8c-4fd3-8fc0-196a58122f70  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  4m56s                  cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_6a47c896-9f8c-4fd3-8fc0-196a58122f70  Successfully provisioned volume pvc-42a5f26d-3b05-42b7-9089-d598258408d5
controlplane $ 
controlplane $ 
controlplane $ kubectl describe pod pod 
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-q2rwm (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  nfs
    ReadOnly:   false
  kube-api-access-q2rwm:
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
  Warning  FailedScheduling  12m    default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "nfs" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  6m43s  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "nfs" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-42a5f26d-3b05-42b7-9089-d598258408d5   100Mi      RWO            nfs            7m11s
controlplane $ 
controlplane $ kubectl logs pod    
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl describe pvc pvc 
Name:          pvc
Namespace:     default
StorageClass:  nfs
Status:        Bound
Volume:        pvc-42a5f26d-3b05-42b7-9089-d598258408d5
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
               volume.kubernetes.io/storage-provisioner: cluster.local/nfs-server-nfs-server-provisioner
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      100Mi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                 Age                    From                                                                                                                      Message
  ----    ------                 ----                   ----                                                                                                                      -------
  Normal  ExternalProvisioning   7m58s (x2 over 7m58s)  persistentvolume-controller                                                                                               waiting for a volume to be created, either by external provisioner "cluster.local/nfs-server-nfs-server-provisioner" or manually created by system administrator
  Normal  Provisioning           7m58s                  cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_6a47c896-9f8c-4fd3-8fc0-196a58122f70  External provisioner is provisioning volume for claim "default/pvc"
  Normal  ProvisioningSucceeded  7m58s                  cluster.local/nfs-server-nfs-server-provisioner_nfs-server-nfs-server-provisioner-0_6a47c896-9f8c-4fd3-8fc0-196a58122f70  Successfully provisioned volume pvc-42a5f26d-3b05-42b7-9089-d598258408d5
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          41m
pod                                   0/1     Pending   0          14m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl logs pod pod
error: container pod is not valid for pod pod
controlplane $ 
controlplane $ kubectl logs -f nfs 
Error from server (NotFound): pods "nfs" not found
controlplane $ 
controlplane $ kubectl logs -f nfs-server-nfs-server-provisioner-0 
I0716 13:50:13.259010       1 main.go:64] Provisioner cluster.local/nfs-server-nfs-server-provisioner specified
I0716 13:50:13.260308       1 main.go:88] Setting up NFS server!
I0716 13:50:13.403898       1 server.go:149] starting RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 13:50:13.403979       1 server.go:160] ending RLIMIT_NOFILE rlimit.Cur 1048576, rlimit.Max 1048576
I0716 13:50:13.404289       1 server.go:134] Running NFS server!
I0716 14:23:12.806603       1 provision.go:450] using service SERVICE_NAME=nfs-server-nfs-server-provisioner cluster IP 10.102.102.93 as NFS server IP
^C
controlplane $ 
```
* Логи Tab 1

```
Initialising Kubernetes... done

controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && /
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  61977      0 --:--:-- --:--:-- --:--:-- 61977
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
LAST DEPLOYED: Sat Jul 16 13:50:06 2022
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
controlplane $ 
```
* Логи Tab 2

```
Initialising Kubernetes... done

controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && /
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  61977      0 --:--:-- --:--:-- --:--:-- 61977
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
LAST DEPLOYED: Sat Jul 16 13:50:06 2022
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
controlplane $ 
```


