 ## Ответ на ДЗ - backend в окружениях stage и prod подключаются каждый к своему PV, при репликации остаетмя возможность обмена данными между конейнерами всех backend в stage и между конейнерами всех backend в prod

### Создание NFS сервера

* ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \ apt install nfs-common -y
```
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y
```


* WorkerNode
```
apt install nfs-common -y
```

### Создание окружения stage
#### Namespace stage
```
kubectl create namespace stage
```
#### Манифесты для окружения stage

* pv.yaml

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/stage/pv
```
* pvc.yaml

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-stage
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
* stage-front-back.yaml

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
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/static"
              name: volume-stage
      volumes:
       - name: volume-stage
         persistentVolumeClaim:
           claimName: pvc-stage
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
#### Репликация stage
```
kubectl scale fb-pod-0 --replicas=3
```
#### Команды тестирование доступа к общему тому





### Манифесты для окружения prod

### Логи окружения stage

### Логи окружения prod
