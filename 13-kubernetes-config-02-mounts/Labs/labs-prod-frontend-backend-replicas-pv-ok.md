## Ответ на ДЗ 13.2-2 - frontend и backend в окружении prod подключаются к общему PV, при репликации остается возможность обмена данными между конейнерами всех frontend и между конейнерами всех backend в prod.


### 1. Создание окружения prod. Подключатсья к NFS будут и Frontend и Backend

#### Скрипт запуска NFS, Namespace

* WorkerNode
```
apt install nfs-common -y
```

* ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
kubectl create namespace prod && \
mkdir -p My-Project && \
cd My-Project && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
ls -lha
```
#### Манифесты для окружения prod. 

* prod-pv.yaml

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-prod
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/prod/pv
```
* prod-pvc.yaml

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-prod
  namespace: prod
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
* prod-frontend.yaml

```yml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: f-app
  name: f-pod
  namespace: prod
spec:
  replicas: 1
  serviceName: b-pod
  selector:
    matchLabels:
      app: f-app
  template:
    metadata:
      labels:
        app: f-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:12.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: BASE_URL
            value: "http://b-pod:9000"
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: prod-volume
      terminationGracePeriodSeconds: 30
      volumes:
        - name: prod-volume
          persistentVolumeClaim:
            claimName: pvc-prod

---
apiVersion: v1
kind: Service
metadata:
  namespace: prod      
  name: f-svc
spec:
  type: NodePort
  selector:
    app: f-app
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
# The END
```
* prod-backend.yaml

```yml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: b-app
  name: b-pod
  namespace: prod
spec:
  serviceName: db
  replicas: 1
  selector:
    matchLabels:
      app: b-app
  template:
    metadata:
      labels:
        app: b-app
    spec:
      containers:
        - image: zakharovnpa/k8s-backend:12.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: "postgres://postgres:postgres@db:5432/news"
          name: backend
          ports:
          - containerPort: 9000
          volumeMounts:
            - mountPath: "/static"
              name: prod-volume
      terminationGracePeriodSeconds: 30
      volumes:
        - name: prod-volume
          persistentVolumeClaim:
            claimName: pvc-prod

# Config Service ClasterIP
---
apiVersion: v1
kind: Service
metadata:
  name: db
  namespace: prod
spec:
  ports:
    - name: db      
      port: 5432
      targetPort: 5432

# Config Service ClasterIP
---
apiVersion: v1
kind: Service
metadata:
  name: b-pod
  namespace: prod
spec:
  selector:
    app: b-app   
  ports:
    - name: b-pod
      port: 9000
      targetPort: 9000

# Config Service EndPoint    
---
apiVersion: v1
kind: Endpoints
metadata:
  name: db  
  namespace: prod
subsets:
  - addresses:
      - ip: 10.128.0.23
    ports:
      - port: 5432
        name: db
