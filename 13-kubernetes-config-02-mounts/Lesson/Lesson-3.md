## Попытка №3 выполнить вопрос №2 ДЗ "13.2 разделы и монтирование"

### 1. Берем исходные файлы и ДЗ "13.1 контейнеры, поды, deployment, statefulset, services, endpoints". Добавляем к ним в спецификацию параметры запроса тома

#### 1.1 Тестовая среда

* Исходники манифестов для деплоя приложения в различных подах для тестовой среды

  * Frontend и Backend [stage-front-back.yaml](/13-kubernetes-config-01-objects/Files/stage-front-back.yaml)


* Измененные манифесты

  * Frontend и Backend [mount-stage-front-back.yaml](/13-kubernetes-config-02-mounts/Files/mount-stage-front-back.yaml)



#### 1.2 Продуктовая среда

* Исходники манифестов для деплоя приложений в различных подах для продуктовой среды

  * Frontend [prod-frontend.yaml](/13-kubernetes-config-01-objects/Files/prod-frontend.yaml)
  * Backend [prod-backend.yaml](/13-kubernetes-config-01-objects/Files/prod-backend.yaml)

* Измененные манифесты

  * Frontend [mount-prod-frontend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-frontend.yaml)
  * Backend [mount-prod-backend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-backend.yaml)

### 2. Установка в кластер Kubernetes Halm, NFS
#### 2.1 Control Node
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash &&
```
```
helm repo add stable https://charts.helm.sh/stable && helm repo update
```
```
helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y
```
#### 2.1 Worker Node
```
apt install nfs-common
```

### 3. Создание namespace `stage`, `prod`

```
kubectl create namespace stage
kubectl create namespace prod
```

### 4. Проверка установки NFS, StorageClass, provisioner, Services

#### 4.1 StorageClass
```
kubectl get sc
```
* Правильный ответ:
```
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   91s
```
#### 4.2 Services
```
kubectl get svc
```
* Правильный ответ:
```
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   2m12s
```
#### 4.3 Pod
```
 kubectl get po 
```
* Правильный ответ:
```
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          3m13s
```
### 5. NFS установлен. Создаем запрос (PVC) на том

* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs  # этот storageclass создан автоматически при установке nfs
  accessModes:
    - ReadWriteMany   # режим доступа
  resources:
    requests:
      storage: 2Gi
```

### 6. Создаем поды для Stage

* Для Stage измененные манифесты
  * Добавлена информация о подключении тома
  * Директория для доступа к NFS - "определить" 

  * Frontend и Backend [mount-stage-front-back.yaml](/13-kubernetes-config-02-mounts/Files/mount-stage-front-back.yaml)
```
kubectl apply -f mount-stage-front-back.yaml
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


#### 6.1 Проверяем доступность тома и возможность создания файлов в NFS


### 7. Создаем поды для Prod

* Для Prod измененные манифесты

  * Frontend [mount-prod-frontend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-frontend.yaml)
  * Backend [mount-prod-backend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-backend.yaml)

```
kubectl apply -f mount-prod-frontend.yaml
```
```
kubectl apply -f mount-prod-backend.yaml
```
