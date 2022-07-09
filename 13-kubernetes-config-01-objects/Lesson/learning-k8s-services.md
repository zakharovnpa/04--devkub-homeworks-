## 09.07.2022 Ход выполнения работы по развертыванию приложений в ластере

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
