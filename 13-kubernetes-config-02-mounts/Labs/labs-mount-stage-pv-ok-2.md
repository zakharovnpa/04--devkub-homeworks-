### Успешное подключение - 2 

#### Только логи
* Tab 1
```
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ 
controlplane $ vi stage-front-back.yaml
controlplane $ 
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ date  
Thu Jul 21 16:18:36 UTC 2022
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   73d
kube-node-lease   Active   73d
kube-public       Active   73d
kube-system       Active   73d
stage             Active   73s
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          4m12s
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get sc 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   4m26s
controlplane $ 
controlplane $ kubectl get -n stage po, pv, pvc
error: arguments in resource/name form must have a single resource and name
controlplane $ 
controlplane $ kubectl get -n stage po,pv,pvc
No resources found
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ date
Thu Jul 21 16:19:49 UTC 2022
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod unchanged
service/fb-pod unchanged
controlplane $ 
controlplane $ kubectl get -n stage po,pv,pvc
NAME                         READY   STATUS              RESTARTS   AGE
pod/fb-pod-57bdd94bd-dwdbb   0/2     ContainerCreating   0          20s
controlplane $ 
controlplane $ date
Thu Jul 21 16:20:16 UTC 2022
controlplane $ 
controlplane $ kubectl get -n stage po,pv,pvc
NAME                         READY   STATUS    RESTARTS   AGE
pod/fb-pod-57bdd94bd-dwdbb   2/2     Running   0          37s
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c backend -- sh -c "echo '43' > /157/cache/43.txt"
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c frontend -- sh -c "echo '42' > /static/42.txt"  
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c frontend -- ls -la /static 
total 16
drwxrwxrwx 2 root root 4096 Jul 21 16:21 .
drwxr-xr-x 1 root root 4096 Jul 21 16:19 ..
-rw-r--r-- 1 root root    3 Jul 21 16:21 42.txt
-rw-r--r-- 1 root root    3 Jul 21 16:21 43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c backend -- ls -la /157/cache   
total 16
drwxrwxrwx 2 root root 4096 Jul 21 16:21 .
drwxr-xr-x 3 root root 4096 Jul 21 16:20 ..
-rw-r--r-- 1 root root    3 Jul 21 16:21 42.txt
-rw-r--r-- 1 root root    3 Jul 21 16:21 43.txt
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po fb-pod-57bdd94bd-dwdbb -o yaml | grep nodeName
  nodeName: node01
controlplane $ 
controlplane $ kubectl -n stage get po fb-pod-57bdd94bd-dwdbb -o yaml | grep uid     
    uid: 7dc48f85-85b1-4447-b840-7077aebca5d2
  uid: 4a084123-5349-42c4-8e60-a54bebca749c
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c backend -- cat /157/cache/43.txt
43
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-dwdbb -c frontend -- cat /static/42.txt 
42
controlplane $ 
controlplane $ 
controlplane $ date
Thu Jul 21 16:27:07 UTC 2022
controlplane $ 
controlplane $ ls -lha
total 12K
drwxr-xr-x 2 root root 4.0K Jul 21 16:17 .
drwx------ 8 root root 4.0K Jul 21 16:17 ..
-rw-r--r-- 1 root root 1.1K Jul 21 16:17 stage-front-back.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat stage-front-back.yaml 
# Config Deployment Frontend & Backend with Volume
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
            - mountPath: "/157/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
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

controlplane $ 
```
* Tab 2

```
node01 $ date
Thu Jul 21 16:25:47 UTC 2022
node01 $ 
node01 $ find /var/lib/kubelet -name 42.txt
/var/lib/kubelet/pods/4a084123-5349-42c4-8e60-a54bebca749c/volumes/kubernetes.io~empty-dir/my-volume/42.txt
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
/var/lib/kubelet/pods/4a084123-5349-42c4-8e60-a54bebca749c/volumes/kubernetes.io~empty-dir/my-volume/43.txt
node01 $ 
node01 $ find /var/lib/kubelet/ -name my-volume | grep volumes
/var/lib/kubelet/pods/4a084123-5349-42c4-8e60-a54bebca749c/volumes/kubernetes.io~empty-dir/my-volume
node01 $ 
node01 $ find /var/lib/kubelet/ -name my-volume | grep volumes | xargs ls -la
total 16
drwxrwxrwx 2 root root 4096 Jul 21 16:21 .
drwxr-xr-x 3 root root 4096 Jul 21 16:19 ..
-rw-r--r-- 1 root root    3 Jul 21 16:21 42.txt
-rw-r--r-- 1 root root    3 Jul 21 16:21 43.txt
node01 $ 
node01 $   
```
