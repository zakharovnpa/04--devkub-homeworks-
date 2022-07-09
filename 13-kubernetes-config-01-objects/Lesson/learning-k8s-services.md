## 09.07.2022 Ход выполнения работы по развертыванию приложений в кластере

### 1. Развернули кластер, подключились
* На сервере cp1
```
yc-user@cp1:~$ {
>     mkdir -p $HOME/.kube
>     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
>     sudo chown $(id -u):$(id -g) $HOME/.kube/config
> }
yc-user@cp1:~$ 
yc-user@cp1:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE     VERSION
cp1     Ready    control-plane   10m     v1.24.2
node1   Ready    <none>          8m50s   v1.24.2
node2   Ready    <none>          8m50s   v1.24.2

```
* На локальной ОС
```
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/stage/main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes 
NAME    STATUS   ROLES           AGE     VERSION
cp1     Ready    control-plane   10m     v1.24.2
node1   Ready    <none>          9m16s   v1.24.2
node2   Ready    <none>          9m16s   v1.24.2
```
### 1. Тестирование нового кластера

#### 1. Какие в кластере namespace
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get namespaces 
NAME              STATUS   AGE
default           Active   76m
kube-node-lease   Active   76m
kube-public       Active   76m
kube-system       Active   76m

```
#### 2. Какие в кластере pods в namespace "default"
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod
No resources found in default namespace.
```
#### 3. Какие в кластере pods в namespace "kube-system"
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -n kube-system
NAME                              READY   STATUS    RESTARTS   AGE
calico-node-bmgmz                 1/1     Running   0          77m
calico-node-dvbft                 1/1     Running   0          77m
calico-node-rz7h4                 1/1     Running   0          77m
coredns-666959ff67-c5hk8          1/1     Running   0          76m
coredns-666959ff67-lhvbr          1/1     Running   0          75m
dns-autoscaler-59b8867c86-mnc9b   1/1     Running   0          75m
kube-apiserver-cp1                1/1     Running   1          79m
kube-controller-manager-cp1       1/1     Running   1          79m
kube-proxy-9wc4h                  1/1     Running   0          78m
kube-proxy-fxwsp                  1/1     Running   0          78m
kube-proxy-xddwl                  1/1     Running   0          78m
kube-scheduler-cp1                1/1     Running   1          79m
nginx-proxy-node1                 1/1     Running   0          77m
nginx-proxy-node2                 1/1     Running   0          77m
nodelocaldns-qjljl                1/1     Running   0          75m
nodelocaldns-wllfz                1/1     Running   0          75m
nodelocaldns-xxk2l                1/1     Running   0          75m

```
#### 4. Какие в кластере nodes в namespace "default"

```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get nodes -o wide
NAME    STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
cp1     Ready    control-plane   82m   v1.24.2   10.128.0.7    <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node1   Ready    <none>          81m   v1.24.2   10.128.0.31   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node2   Ready    <none>          81m   v1.24.2   10.128.0.29   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6

```

### 2. Разворачиваем приложения
#### 1. Файлы - конфиги

* maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat web-fb-app.yaml

```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
#      app: fb
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
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-svc
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
#    app: fb-app
#    app: fb
    app: fb-pod

```
* maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ cat db-app.yaml

```yml
# Config PostgreSQL StatefulSet
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
#  name: db-svc
  name: db
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432
```
#### 2. Создание деплойментов приложений и сетевых служб.

```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl apply -f .
statefulset.apps/db created
service/db created
deployment.apps/fb-pod created
service/fb-svc created
```
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -o wide
NAME                      READY   STATUS              RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running             0          33s   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-mtgh5   0/2     ContainerCreating   0          33s   <none>        node2   <none>           <none>
```
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          47s   10.233.90.1   node1   <none>           <none>
fb-pod-65b9777746-mtgh5   2/2     Running   0          47s   10.233.96.2   node2   <none>           <none>

```
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get service -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db           NodePort    10.233.38.124   <none>        5432:32285/TCP   2m11s   app=db
fb-svc       NodePort    10.233.30.110   <none>        80:30080/TCP     2m11s   app=fb-pod
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          88m     <none>
```
```py
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl get endpoints -o wide
NAME         ENDPOINTS          AGE
db           10.233.90.1:5432   2m27s
fb-svc       <none>             2m27s
kubernetes   10.128.0.7:6443    88m

```
```go
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl exec fb-pod-65b9777746-mtgh5 -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-65b9777746-mtgh5:/app# 
root@fb-pod-65b9777746-mtgh5:/app# 
root@fb-pod-65b9777746-mtgh5:/app# cd
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# ping db
PING db.default.svc.cluster.local (10.233.38.124) 56(84) bytes of data.
64 bytes from db.default.svc.cluster.local (10.233.38.124): icmp_seq=1 ttl=64 time=0.074 ms
64 bytes from db.default.svc.cluster.local (10.233.38.124): icmp_seq=2 ttl=64 time=0.073 ms
^C
--- db.default.svc.cluster.local ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1ms
rtt min/avg/max/mdev = 0.073/0.073/0.074/0.008 ms
root@fb-pod-65b9777746-mtgh5:~# 
root@fb-pod-65b9777746-mtgh5:~# curl db:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-mtgh5:~# 

```
