### Подключение к NFS пода в namespace stage


#### Файлы

```
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 18 13:26 .
drwx------ 8 root root 4.0K Jul 18 13:26 ..
-rw-r--r-- 1 root root 1.1K Jul 18 13:21 mount-stage-front-back.yaml
-rw-r--r-- 1 root root  270 Jul 18 12:55 pod.yaml
-rw-r--r-- 1 root root  199 Jul 18 13:26 pvc-stage.yaml
-rw-r--r-- 1 root root  180 Jul 18 12:55 pvc.yaml
```
```
controlplane $ cat pvc.yaml 
```
```yml
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
```
```
controlplane $ cat pvc-stage.yaml 
```
```yml
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
```
```
controlplane $ cat pod.yaml 
```
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
```
controlplane $ cat mount-stage-front-back.yaml 
```
```yml
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
            - mountPath: "/static"
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/static"
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
#### Лог 1
```
Initialising Kubernetes... done

controlplane $ date
Mon Jul 18 12:54:52 UTC 2022
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ vi pod.yaml
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   272k      0 --:--:-- --:--:-- --:--:--  279k
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
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Mon Jul 18 12:57:01 2022
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
0 upgraded, 6 newly installed, 0 to remove and 192 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (448 kB/s)    
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
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          37s
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   41s
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1     <none>        443/TCP                                                                                                     70d
nfs-server-nfs-server-provisioner   ClusterIP   10.99.50.88   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   79s
controlplane $ 
controlplane $ ls -lha
total 16K
drwxr-xr-x 2 root root 4.0K Jul 18 12:55 .
drwx------ 8 root root 4.0K Jul 18 12:56 ..
-rw-r--r-- 1 root root  270 Jul 18 12:55 pod.yaml
-rw-r--r-- 1 root root  180 Jul 18 12:55 pvc.yaml
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
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
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
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-bdba834f-9043-4096-87d0-e532abdff6a7   2Gi        RWX            nfs            6s
controlplane $ 
controlplane $ kubectl apply -f pod.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          3m11s
pod                                   1/1     Running   0          11s
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -c nginx -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl exec po -c nginx -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl exec po pod -c -it bash --  
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl exec po pod -c nginx -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl exec po pod -c nginx -it bash   
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Error from server (NotFound): pods "po" not found
controlplane $ 
controlplane $ kubectl exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# 
root@pod:/# ls -lha
total 92K
drwxr-xr-x   1 root root 4.0K Jul 18 13:00 .
drwxr-xr-x   1 root root 4.0K Jul 18 13:00 ..
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 bin
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 boot
drwxr-xr-x   5 root root  360 Jul 18 13:00 dev
drwxr-xr-x   1 root root 4.0K Jul 12 05:00 docker-entrypoint.d
-rwxrwxr-x   1 root root 1.2K Jul 12 05:00 docker-entrypoint.sh
drwxr-xr-x   1 root root 4.0K Jul 18 13:00 etc
drwxr-xr-x   2 root root 4.0K Jun 30 21:35 home
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 lib
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 media
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 opt
dr-xr-xr-x 247 root root    0 Jul 18 13:00 proc
drwx------   2 root root 4.0K Jul 11 00:00 root
drwxr-xr-x   1 root root 4.0K Jul 18 13:00 run
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 sbin
drwxr-xr-x   2 root root 4.0K Jul 11 00:00 srv
drwxrwsrwx   2 root root 4.0K Jul 18 12:59 static
dr-xr-xr-x  13 root root    0 Jul 18 13:00 sys
drwxrwxrwt   1 root root 4.0K Jul 12 05:00 tmp
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 usr
drwxr-xr-x   1 root root 4.0K Jul 11 00:00 var
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 18 12:59 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:00 ..
root@pod:/static# 
root@pod:/static# echo '42' > 42.txt
root@pod:/static# 
root@pod:/static# cat 42.txt 
42
root@pod:/static# 
root@pod:/static# ls lha
ls: cannot access 'lha': No such file or directory
root@pod:/static# 
root@pod:/static# echo '43' > 43.txt
root@pod:/static# 
root@pod:/static# cat 43.txt 
43
root@pod:/static# 
root@pod:/static# 
root@pod:/static# 
root@pod:/static# exit
exit
controlplane $ 
controlplane $ pwd
/root/My-Project
controlplane $ 
controlplane $ ls -lha
total 16K
drwxr-xr-x 2 root root 4.0K Jul 18 12:55 .
drwx------ 8 root root 4.0K Jul 18 12:56 ..
-rw-r--r-- 1 root root  270 Jul 18 12:55 pod.yaml
-rw-r--r-- 1 root root  180 Jul 18 12:55 pvc.yaml
controlplane $ 
controlplane $ date
Mon Jul 18 13:20:13 UTC 2022
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
default           Active   70d
kube-node-lease   Active   70d
kube-public       Active   70d
kube-system       Active   70d
prod              Active   8s
stage             Active   13s
controlplane $ 
controlplane $ 
controlplane $ vi mount-stage-front-back.yaml
controlplane $ 
controlplane $ 
controlplane $ kubectl ge pod.yaml 
error: unknown command "ge" for "kubectl"

Did you mean this?
        set
        get
        cp
controlplane $ 
controlplane $ kubectl ge po       
error: unknown command "ge" for "kubectl"

Did you mean this?
        set
        get
        cp
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          25m
pod                                   1/1     Running   0          22m
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f mount-stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          25m
pod                                   1/1     Running   0          22m
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-x8t7t   0/2     Pending   0          18s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-x8t7t   0/2     Pending   0          26s
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-x8t7t   0/2     Pending   0          34s
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-x8t7t   0/2     Pending   0          86s
controlplane $ 
controlplane $ 
controlplane $ kubectl describe -n stage po fb-pod-6c4fbd7c86-x8t7t 
Name:           fb-pod-6c4fbd7c86-x8t7t
Namespace:      stage
Priority:       0
Node:           <none>
Labels:         app=fb-app
                pod-template-hash=6c4fbd7c86
Annotations:    <none>
Status:         Pending
IP:             
IPs:            <none>
Controlled By:  ReplicaSet/fb-pod-6c4fbd7c86
Containers:
  frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4rcqr (ro)
  backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4rcqr (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-4rcqr:
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
  Warning  FailedScheduling  2m    default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Jul 18 13:21 .
drwx------ 8 root root 4.0K Jul 18 13:21 ..
-rw-r--r-- 1 root root 1.1K Jul 18 13:21 mount-stage-front-back.yaml
-rw-r--r-- 1 root root  270 Jul 18 12:55 pod.yaml
-rw-r--r-- 1 root root  180 Jul 18 12:55 pvc.yaml
controlplane $ 
controlplane $ cp pvc.yaml pvc-stage.yaml
controlplane $ 
controlplane $ vi pvc-stage.yaml 
controlplane $ 
controlplane $ vi pvc-stage.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc-stage.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n pvc
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
controlplane $ 
controlplane $ kubectl get -n stage pvc
NAME   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pvc-cf8d6053-bde5-41f4-829d-d5ed3c58a8c1   2Gi        RWX            nfs            20s
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-x8t7t   2/2     Running   0          4m37s
controlplane $ 
controlplane $ 
controlplane $ kubectl exec -n stage fb-pod-6c4fbd7c86-x8t7t -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl exec -n stage fb-pod-6c4fbd7c86-x8t7t -c backend -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl exec fb-pod-6c4fbd7c86-x8t7t -c backend -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-x8t7t -c backend -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-x8t7t -c backend -it bash   
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl exec -n stage fb-pod-6c4fbd7c86-x8t7t -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage logs fb-pod-6c4fbd7c86-x8t7t 
Defaulted container "frontend" out of: frontend, backend
Error from server (BadRequest): container "frontend" in pod "fb-pod-6c4fbd7c86-x8t7t" is terminated
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-w5mvj   2/2     Running   0          2m26s
fb-pod-6c4fbd7c86-x8t7t   0/2     Error     1          7m34s
controlplane $ 
controlplane $ 
controlplane $ kubectl describe -n stage po fb-pod-6c4fbd7c86-w5mvj 
Name:         fb-pod-6c4fbd7c86-w5mvj
Namespace:    stage
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Mon, 18 Jul 2022 13:27:26 +0000
Labels:       app=fb-app
              pod-template-hash=6c4fbd7c86
Annotations:  cni.projectcalico.org/containerID: fa1f7b84d627d8002fd086c7043b6101d4e18ee5cf5761d00937faa69ac43af6
              cni.projectcalico.org/podIP: 192.168.1.6/32
              cni.projectcalico.org/podIPs: 192.168.1.6/32
Status:       Running
IP:           192.168.1.6
IPs:
  IP:           192.168.1.6
Controlled By:  ReplicaSet/fb-pod-6c4fbd7c86
Containers:
  frontend:
    Container ID:   containerd://2a5e823478bdf2886af59875c425cfc660c52ed772e935558827f4bfd9a33b82
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 18 Jul 2022 13:27:32 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8mbbf (ro)
  backend:
    Container ID:   containerd://adc8fb93ebe9ed1d2336daee083dc1ff3fa45d35631d6ce921874c3ae2c537a1
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 18 Jul 2022 13:27:53 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8mbbf (ro)
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
  kube-api-access-8mbbf:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m16s  default-scheduler  Successfully assigned stage/fb-pod-6c4fbd7c86-w5mvj to node01
  Normal  Pulling    3m15s  kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     3m10s  kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 4.570097373s
  Normal  Created    3m10s  kubelet            Created container frontend
  Normal  Started    3m10s  kubelet            Started container frontend
  Normal  Pulling    3m10s  kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     2m49s  kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 21.202869459s
  Normal  Created    2m49s  kubelet            Created container backend
  Normal  Started    2m49s  kubelet            Started container backend
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-w5mvj   2/2     Running   0          3m28s
fb-pod-6c4fbd7c86-x8t7t   0/2     Error     1          8m36s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-w5mvj -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Defaulted container "frontend" out of: frontend, backend
root@fb-pod-6c4fbd7c86-w5mvj:/app# 
root@fb-pod-6c4fbd7c86-w5mvj:/app# 
root@fb-pod-6c4fbd7c86-w5mvj:/app# cd 
root@fb-pod-6c4fbd7c86-w5mvj:~# 
root@fb-pod-6c4fbd7c86-w5mvj:~# pwd
/root
root@fb-pod-6c4fbd7c86-w5mvj:~# 
root@fb-pod-6c4fbd7c86-w5mvj:~# 
root@fb-pod-6c4fbd7c86-w5mvj:~# cd /
root@fb-pod-6c4fbd7c86-w5mvj:/# 
root@fb-pod-6c4fbd7c86-w5mvj:/# pwd
/
root@fb-pod-6c4fbd7c86-w5mvj:/# 
root@fb-pod-6c4fbd7c86-w5mvj:/# ls -lha
total 96K
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 .
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 ..
drwxr-xr-x   1 root root 4.0K Jul  4 12:30 app
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 bin
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 boot
drwxr-xr-x   5 root root  360 Jul 18 13:27 dev
drwxr-xr-x   1 root root 4.0K Jun 23 04:13 docker-entrypoint.d
-rwxrwxr-x   1 root root 1.2K Jun 23 04:13 docker-entrypoint.sh
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 etc
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 home
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 lib
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 media
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 opt
dr-xr-xr-x 238 root root    0 Jul 18 13:27 proc
drwx------   2 root root 4.0K Jun 22 00:00 root
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 run
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 sbin
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 srv
drwxrwsrwx   2 root root 4.0K Jul 18 13:26 static
dr-xr-xr-x  13 root root    0 Jul 18 13:27 sys
drwxrwxrwt   1 root root 4.0K Jun 23 04:13 tmp
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 usr
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 var
root@fb-pod-6c4fbd7c86-w5mvj:/# 
root@fb-pod-6c4fbd7c86-w5mvj:/# cd static/
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 18 13:26 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:27 ..
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# echo '54' > 54.txt
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# ls -lha
total 12K
drwxrwsrwx 2 root root 4.0K Jul 18 13:32 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:27 ..
-rw-r--r-- 1 root root    3 Jul 18 13:32 54.txt
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# exit
exit
controlplane $ 
controlplane $ kubectl exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# cd /
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# ls -lha
total 16K
drwxrwsrwx 2 root root 4.0K Jul 18 13:16 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:00 ..
-rw-r--r-- 1 root root    3 Jul 18 13:03 42.txt
-rw-r--r-- 1 root root    3 Jul 18 13:16 43.txt
root@pod:/static# 
root@pod:/static# 
```

#### Лог 2
```
node01 $ 
node01 $ 
node01 $ find / -name 42.txt
/var/lib/kubelet/pods/2c4eeb82-18f6-4ce9-90ba-1967804a1894/volumes/kubernetes.io~empty-dir/data/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
/var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
node01 $ 
node01 $ 
node01 $ cat /var/lib/kubelet/pods/2c4eeb82-18f6-4ce9-90ba-1967804a1894/volumes/kubernetes.io~empty-dir/data/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
42
node01 $ 
node01 $ cat /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
42
node01 $ 
node01 $ cat /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/43.txt
43
node01 $ 
node01 $ ls -lha /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/      
total 16K
drwxrwsrwx 2 root root 4.0K Jul 18 13:16 .
drwxr-x--- 3 root root 4.0K Jul 18 13:00 ..
-rw-r--r-- 1 root root    3 Jul 18 13:03 42.txt
-rw-r--r-- 1 root root    3 Jul 18 13:16 43.txt
node01 $ 
node01 $ find / -name 54.txt
find: '/proc/54241/task/54241/net': Invalid argument
find: '/proc/54241/net': Invalid argument
/var/lib/kubelet/pods/2c4eeb82-18f6-4ce9-90ba-1967804a1894/volumes/kubernetes.io~empty-dir/data/pvc-cf8d6053-bde5-41f4-829d-d5ed3c58a8c1/54.txt
/var/lib/kubelet/pods/ad61abd5-a6ae-4869-9624-9dce18b93aca/volumes/kubernetes.io~nfs/pvc-cf8d6053-bde5-41f4-829d-d5ed3c58a8c1/54.txt
node01 $ 
node01 $ 
node01 $ 
```

#### Лог 3
```
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          37m
pod                                   1/1     Running   0          34m
controlplane $ 
controlplane $ kubectl get po -n stage
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-w5mvj   2/2     Running   0          7m32s
fb-pod-6c4fbd7c86-x8t7t   0/2     Error     1          12m
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-w5mvj -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-w5mvj:/app# 
root@fb-pod-6c4fbd7c86-w5mvj:/app# cd /
root@fb-pod-6c4fbd7c86-w5mvj:/# 
root@fb-pod-6c4fbd7c86-w5mvj:/# ls -lha
total 80K
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 .
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 ..
drwxr-xr-x   1 root root 4.0K Jul  4 12:31 app
drwxr-xr-x   1 root root 4.0K Jun 23 00:52 bin
drwxr-xr-x   2 root root 4.0K Mar 19 13:44 boot
drwxr-xr-x   5 root root  360 Jul 18 13:27 dev
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 etc
drwxr-xr-x   2 root root 4.0K Mar 19 13:44 home
drwxr-xr-x   1 root root 4.0K Jun 23 00:52 lib
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 media
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 opt
dr-xr-xr-x 241 root root    0 Jul 18 13:27 proc
drwx------   1 root root 4.0K Jul  4 12:31 root
drwxr-xr-x   1 root root 4.0K Jul 18 13:27 run
drwxr-xr-x   1 root root 4.0K Jun 23 00:51 sbin
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 srv
drwxrwsrwx   2 root root 4.0K Jul 18 13:32 static
dr-xr-xr-x  13 root root    0 Jul 18 13:27 sys
drwxrwxrwt   1 root root 4.0K Jul  4 12:31 tmp
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 usr
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 var
root@fb-pod-6c4fbd7c86-w5mvj:/# 
root@fb-pod-6c4fbd7c86-w5mvj:/# cd static/
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# ls -lha
total 12K
drwxrwsrwx 2 root root 4.0K Jul 18 13:32 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:27 ..
-rw-r--r-- 1 root root    3 Jul 18 13:32 54.txt
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# cat 54.txt 
54
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
root@fb-pod-6c4fbd7c86-w5mvj:/static# 
```
