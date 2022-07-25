 ## Ответ на ДЗ - backend в окружениях stage и prod подключаются каждый к своему PV, при репликации остается возможность обмена данными между конейнерами всех backend в stage и между конейнерами всех backend в prod

Задача:
1. [Создание NFS сервера](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#1-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-nfs-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0)
2. [Создание окружения stage](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#2-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-stage)
3. [Репликация stage](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#3-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F-stage)
4. [Тестирование доступа к общему тому для stage](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#4-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0-%D0%BA-%D0%BE%D0%B1%D1%89%D0%B5%D0%BC%D1%83-%D1%82%D0%BE%D0%BC%D1%83)
5. [Логи окружения stage](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#5-%D0%BB%D0%BE%D0%B3%D0%B8-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-stage)
6. [Скрипт для проверок stage](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#6-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BE%D0%BA)
7. [Создание окружения prod](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#7-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-prod)
8. [Репликация prod](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D1%8F-prod)
9. [Тестирование доступа к общему тому для prod](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#9-%D1%82%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0-%D0%BA-%D0%BE%D0%B1%D1%89%D0%B5%D0%BC%D1%83-%D1%82%D0%BE%D0%BC%D1%83-%D0%B4%D0%BB%D1%8F-prod)
10. [Логи окружения prod](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#10-%D0%BB%D0%BE%D0%B3%D0%B8-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-prod)
11. [Скрипт для проверок prod](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#11-%D1%81%D0%BA%D1%80%D0%B8%D0%BF%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BE%D0%BA-prod)



### 1. Создание NFS сервера

* ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
kubectl create namespace stage && \
kubectl create namespace prod && \
mkdir -p My-Procect/stage && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
ls -lha && \
kubectl get namespace stage && \
kubectl get namespace prod && \
kubectl get sc && \
kubectl get pod && \
kubectl get svc && \
kubectl get ns
```
* WorkerNode
```
apt install nfs-common -y
```

### 2. Создание окружения stage. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)
#### Namespace stage
```
kubectl get namespace stage
```

#### Создаем рабочую дирекорию и файлы манифестов
* Описано ранее в скрипте
```
mkdir -p My-Procect/stage && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
ls -lha 
```
#### Манифесты для окружения stage
* stage-pv.yaml

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
* stage-pvc.yaml

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
### 3. Репликация stage.
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)
```
controlplane $ kubectl -n stage get deployments.apps     
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           41m
```
```
controlplane $ kubectl -n stage scale --replicas=3 deploy/fb-pod
deployment.apps/fb-pod scaled
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6d5f85cbb8-6wck8   2/2     Running             0          49m
fb-pod-6d5f85cbb8-d65zs   0/2     ContainerCreating   0          14s
fb-pod-6d5f85cbb8-jpw4l   2/2     Running             0          14s
```
```
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6d5f85cbb8-6wck8   2/2     Running                  0          54m
fb-pod-6d5f85cbb8-88chm   2/2     Running                  0          4m14s
fb-pod-6d5f85cbb8-d65zs   0/2     ContainerStatusUnknown   2          5m10s
fb-pod-6d5f85cbb8-jpw4l   2/2     Running                  0          5m10s
```
### 4. Тестирование доступа к общему тому. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)
```
kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "echo '42' > /static/42.txt"
```
```
kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "ls -lha /static"
```
```
kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
```

### 5. Логи окружения stage. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "echo '42' > /static/42.txt"
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "ls -lha /static"
total 12K
drwxr-xr-x 2 root root 4.0K Jul 23 04:47 .
drwxr-xr-x 1 root root 4.0K Jul 23 04:37 ..
-rw-r--r-- 1 root root    3 Jul 23 04:47 42.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
42
controlplane $ 
```
* Для frontend stage-volume недоступен

```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/42.txt"
cat: /static/42.txt: No such file or directory
command terminated with exit code 1
```
* Поиск файла 42.txt на ноде node01

```
node01 $ find /data/stage/pv -name 42.txt
/data/stage/pv/42.txt
```
```
node01 $ cat /data/stage/pv/42.txt
42, 42, 42
```
* Есть обмен данными. На ноде создался новый файл 43.txt

```
node01 $ echo '43' > /data/stage/pv/43.txt
```
* Файл 43.txt в контейнере
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "ls -lha /static"
total 20K
drwxr-xr-x 2 root root 4.0K Jul 23 05:07 .
drwxr-xr-x 1 root root 4.0K Jul 23 04:37 ..
-rw-r--r-- 1 root root   11 Jul 23 05:02 42.txt
-rw-r--r-- 1 root root    3 Jul 23 05:07 43.txt
```
* Добавление информации в файл 42.txt
```
node01 $ echo '44' >> /data/stage/pv/42.txt
```
* На backend можно прочитать новую информацию
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
42, 42, 42
44
```


### 6. Скрипт для проверок. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)
* Разворачиваем приложения в окружении stage
```
kubectl apply -f .
```
* Скрипт тестирования окружения stage
```
kubectl get po && \
kubectl -n stage get pv && \
kubectl -n stage get pvc
```



### 7. Создание окружения prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

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
kubectl create namespace stage && \
kubectl create namespace prod && \
mkdir -p My-Procect/prod && \
cd My-Procect/prod && \
touch prod-pv.yaml prod-pvc.yaml prod-frontend.yaml prod-backend.yaml && \
ls -lha && \
kubectl get namespace prod && \
kubectl get sc && \
kubectl get pod && \
kubectl get svc && \
kubectl -n prod get sc && \
kubectl -n prod get pod && \
kubectl -n prod get svc
```


#### Манифесты для окружения prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

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
      terminationGracePeriodSeconds: 30

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

```
### 8. Тестирование окружения
```
kubectl -n prod get po
```
```
kubectl -n prod get statefulsets.apps
```
```
kubectl -n prod get storageclasses.storage.k8s.io
```
### 8. Репликация prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

* Реплицируем backend
```
kubectl -n prod scale --replicas=3 statefulset/b-pod
```
```
controlplane $ kubectl -n prod scale --replicas=3 statefulset/b-pod
statefulset.apps/b-pod scaled
```
* Реплицированный backend
```
controlplane $ kubectl -n prod get po
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          15m
b-pod-1   1/1     Running   0          64s
b-pod-2   1/1     Running   0          46s
f-pod-0   1/1     Running   0          15m
```

### 9. Тестирование доступа к общему тому для prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

```
kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
```

```
kubectl -n prod exec b-pod-0 -- sh -c "echo '42' > /static/42.txt"
```

```
kubectl -n prod exec b-pod-0 -- sh -c "cat /static/42.txt"
```


### 10. Логи окружения prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

```
controlplane $ kubectl apply -f .
statefulset.apps/b-pod created
service/db created
service/b-pod created
endpoints/db created
statefulset.apps/f-pod created
service/f-svc created
persistentvolume/pv-prod created
persistentvolumeclaim/pvc-prod created
```
```
controlplane $ kubectl -n prod get po
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          106s
f-pod-0   1/1     Running   0          106s
```
```
controlplane $ kubectl -n prod get deployments.apps 
No resources found in prod namespace.
```
```
controlplane $ kubectl -n prod get statefulsets.apps 
NAME    READY   AGE
b-pod   1/1     2m12s
f-pod   1/1     2m11s
```
```
controlplane $ kubectl -n prod get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   16m
```
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 25 02:13 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:13 ..
```
* На frontend нет общей папки
```
controlplane $ kubectl -n prod exec f-pod-0 -- sh -c "ls -lha /static"
ls: cannot access '/static': No such file or directory
command terminated with exit code 2
```
* Создаем в общей директории файл 42.txt
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "echo '42' > /static/42.txt"
```
* Созданный файл 42.txt в общей директории
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
total 12K
drwxrwsrwx 2 root root 4.0K Jul 25 02:23 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:13 ..
-rw-r--r-- 1 root root    3 Jul 25 02:23 42.txt
```
* Читаем содержимое файла 42.txt
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "cat /static/42.txt"
42
```
* Реплицируем backend
```
controlplane $ kubectl -n prod scale --replicas=3 statefulset/b-pod
statefulset.apps/b-pod scaled
```
* Реплицированный backend
```
controlplane $ kubectl -n prod get po
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          15m
b-pod-1   1/1     Running   0          64s
b-pod-2   1/1     Running   0          46s
f-pod-0   1/1     Running   0          15m
```
* В каждом поде backend
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
total 12K
drwxrwsrwx 2 root root 4.0K Jul 25 02:23 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:13 ..
-rw-r--r-- 1 root root    3 Jul 25 02:23 42.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-1 -- sh -c "ls -lha /static"
total 12K
drwxrwsrwx 2 root root 4.0K Jul 25 02:23 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:28 ..
-rw-r--r-- 1 root root    3 Jul 25 02:23 42.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "ls -lha /static"
total 12K
drwxrwsrwx 2 root root 4.0K Jul 25 02:23 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:28 ..
-rw-r--r-- 1 root root    3 Jul 25 02:23 42.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "cat /static/42.txt"
42
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-1 -- sh -c "cat /static/42.txt"
42
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "cat /static/42.txt"
42
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "echo '43' > /static/43.txt"
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "cat /static/42.txt"
42
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "ls -lha /static"
total 16K
drwxrwsrwx 2 root root 4.0K Jul 25 02:32 .
drwxr-xr-x 1 root root 4.0K Jul 25 02:28 ..
-rw-r--r-- 1 root root    3 Jul 25 02:23 42.txt
-rw-r--r-- 1 root root    3 Jul 25 02:32 43.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-2 -- sh -c "cat /static/43.txt"
43
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "cat /static/43.txt"
43
```
### 10. Логи проверки доступности node01 /data/stage/pv, data/prod/pv
* Tab 1
```
ontrolplane $ kubectl -n prod scale --replicas=3 statefulset/f-pod
statefulset.apps/f-pod scaled
controlplane $ 
controlplane $ kubectl -n prod get pv  
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            nfs            26m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     27m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     27m
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM             STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Bound       stage/pvc-stage   nfs                     39m
pv-stage                                   2Gi        RWX            Retain           Available                     nfs                     7m19s
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod     nfs                     39m
controlplane $ kubectl -n prod get po
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          18m
b-pod-1   1/1     Running   0          30m
b-pod-2   1/1     Running   0          17m
f-pod-0   1/1     Running   0          45m
f-pod-1   1/1     Running   0          18m
f-pod-2   1/1     Running   0          19m

```
* Tab 2
```
ontrolplane $ kubectl -n prod scale --replicas=3 statefulset/f-pod
statefulset.apps/f-pod scaled
controlplane $ 
controlplane $ kubectl -n prod get pv  
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            nfs            26m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     27m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     27m
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM             STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Bound       stage/pvc-stage   nfs                     39m
pv-stage                                   2Gi        RWX            Retain           Available                     nfs                     7m19s
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod     nfs                     39m
```

* Tab 3

```
ontrolplane $ kubectl -n prod scale --replicas=3 statefulset/f-pod
statefulset.apps/f-pod scaled
controlplane $ 
controlplane $ kubectl -n prod get pv  
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            nfs            26m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     26m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     26m
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM           STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Available                   nfs                     27m
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod   nfs                     27m
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv 
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM             STORAGECLASS   REASON   AGE
pv-prod                                    2Gi        RWX            Retain           Bound       stage/pvc-stage   nfs                     39m
pv-stage                                   2Gi        RWX            Retain           Available                     nfs                     7m19s
pvc-86895215-5b8a-4c23-864d-e54c964a66a0   2Gi        RWX            Delete           Bound       prod/pvc-prod     nfs                     39m
```

### 11. Скрипт для проверок prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)




