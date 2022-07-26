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
mkdir -p My-Procect/stage && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
ls -lha
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

* Тестирование stage
```
kubectl get namespace stage && \
kubectl get sc && \
kubectl get pod && \
kubectl get svc && \
kubectl get ns
```
* Репликация
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

#### Проверка доступности общих файлов для всех контейнеров всех реплик

##### Для пода fb-pod-6d5f85cbb8-6wck8
* frontend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/43.txt"
43
```
##### Для пода fb-pod-6d5f85cbb8-88chm
* frontend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c frontend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c backend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c backend -- sh -c "cat /static/43.txt"
43
```
##### Для пода fb-pod-6d5f85cbb8-jpw4l
* frontend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c frontend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -- sh -c "cat /static/42.txt"
42, 42, 42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -- sh -c "cat /static/43.txt"
43
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



### 7. Создание окружения prod. Подключатсья к NFS будет только Backend
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)

#### Скрипт запуска NFS, Namespace

* WorkerNode
```
apt install nfs-common -y
```

* ControlNode
```
echo "curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash" && \
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
echo "helm repo add stable https://charts.helm.sh/stable" && \
helm repo add stable https://charts.helm.sh/stable && \
echo "helm repo update" && \
helm repo update && \
echo "helm install nfs-server stable/nfs-server-provisioner" && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
kubectl create namespace stage && \
kubectl create namespace prod && \
mkdir -p My-Procect/stage && \
mkdir -p My-Procect/prod && \
cd My-Procect/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
ls -lha && \
cd ../prod/ && \
touch prod-pv.yaml prod-pvc.yaml prod-frontend.yaml prod-backend.yaml && \
ls -lha
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

```
kubectl get namespace prod && \
kubectl get sc && \
kubectl get pod && \
kubectl get svc && \
kubectl -n prod get sc && \
kubectl -n prod get pod && \
kubectl -n prod get svc
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
### 10. Логи при запуске stage, prod на разные PV, с индивидуальными PVC.
* Условия запуска:
  * Сначала запустил все PV
  * Потом все PVC
  * Потом развернул backend, frontend
   
* Вывод: 
  * идет путаница. 
  * PVC запрашивает неверный PV, при правильном указании имени PV, 
  * директории data/stage/pv, data/prod/pv создаются некорректно. Одна создалась - другая нет
  * файлы из stage попали в директорию data/prod/pv
  * файлы из prod сохраниются только локально в контейнере, на NFS не попадают.

* Tab 1
```
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/prod
controlplane $ 
controlplane $ cd ../stage/
controlplane $ 
controlplane $ vi stage-pv.yaml 
controlplane $ 
controlplane $ vi stage-pvc.yaml 
controlplane $ 
controlplane $ vi stage-front-back.yaml 
controlplane $ 
controlplane $ vi stage-front-back.yaml 
controlplane $ 
controlplane $ cd ../prod/
controlplane $ 
controlplane $ vi prod-pv.yaml 
controlplane $ 
controlplane $ vi prod-pvc.yaml 
controlplane $ 
controlplane $ cat prod-pv.yaml 
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
controlplane $ 
controlplane $ cat prod-pvc.yaml 
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
controlplane $ 
controlplane $ vi prod-pv.yaml 
controlplane $ 
controlplane $ cat prod-pv.yaml 
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
controlplane $ 
controlplane $ vi prod-frontend.yaml 
controlplane $ 
controlplane $ vi prod-backend.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get sc 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   7m48s
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     77d
nfs-server-nfs-server-provisioner   ClusterIP   10.98.251.71   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   7m53s
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/prod
controlplane $ 
controlplane $ kubectl apply -f prod-pv.yaml 
persistentvolume/pv-prod created
controlplane $ 
controlplane $ kubectl get ns 
NAME              STATUS   AGE
default           Active   77d
kube-node-lease   Active   77d
kube-public       Active   77d
kube-system       Active   77d
prod              Active   8m36s
stage             Active   8m36s
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-prod   2Gi        RWX            Retain           Available           nfs                     21s
controlplane $ 
controlplane $ cd ../stage/
controlplane $ 
controlplane $ kubectl apply -f stage-pv.yaml 
persistentvolume/pv-stage created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Available           nfs                     55s
pv-stage   2Gi        RWX            Retain           Available           nfs                     5s
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Available           nfs                     113s
pv-stage   2Gi        RWX            Retain           Available           nfs                     63s
controlplane $ 
controlplane $ kubectl apply -f stage-pvc.yaml 
persistentvolumeclaim/pvc-stage created
controlplane $ 
controlplane $ 
controlplane $ cd ../prod/
controlplane $ 
controlplane $ kubectl apply -f prod-pvc.yaml  
persistentvolumeclaim/pvc-prod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Bound    stage/pvc-stage   nfs                     2m38s
pv-stage   2Gi        RWX            Retain           Bound    prod/pvc-prod     nfs                     108s
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl -n stage get pvc
NAME        STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-stage   Bound    pv-prod   2Gi        RWX            nfs            68s
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pv-stage   2Gi        RWX            nfs            60s
controlplane $ 
controlplane $ pwd
/root/My-Procect/prod
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 25 03:23 .
drwxr-xr-x 4 root root 4.0K Jul 25 03:15 ..
-rw-r--r-- 1 root root 1.4K Jul 25 03:23 prod-backend.yaml
-rw-r--r-- 1 root root  770 Jul 25 03:22 prod-frontend.yaml
-rw-r--r-- 1 root root  196 Jul 25 03:20 prod-pv.yaml
-rw-r--r-- 1 root root  201 Jul 25 03:20 prod-pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f prod-frontend.yaml 
statefulset.apps/f-pod created
service/f-svc created
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pv-stage   2Gi        RWX            nfs            2m36s
controlplane $ 
controlplane $ kubectl -n prod get pv 
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Bound    stage/pvc-stage   nfs                     5m18s
pv-stage   2Gi        RWX            Retain           Bound    prod/pvc-prod     nfs                     4m28s
controlplane $ 
controlplane $ kubectl apply -f prod-backend.yaml  
statefulset.apps/b-pod created
service/db created
service/b-pod created
endpoints/db created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME       STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pv-stage   2Gi        RWX            nfs            3m16s
controlplane $ 
controlplane $ cd ../stage/
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Jul 25 03:18 .
drwxr-xr-x 4 root root 4.0K Jul 25 03:15 ..
-rw-r--r-- 1 root root  993 Jul 25 03:18 stage-front-back.yaml
-rw-r--r-- 1 root root  198 Jul 25 03:17 stage-pv.yaml
-rw-r--r-- 1 root root  203 Jul 25 03:17 stage-pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          16m
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6d5f85cbb8-fn577   2/2     Running   0          109s
controlplane $ 
controlplane $ kubectl -n prod get po
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          3m2s
f-pod-0   1/1     Running   0          3m40s
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 25 03:30 .
drwxr-xr-x 1 root root 4.0K Jul 25 03:30 ..
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "echo '42' > /static/42.txt"
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-fn577 -c backend -- sh -c "echo '43' > /static/43.txt"
controlplane $ 
controlplane $ kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Bound    stage/pvc-stage   nfs                     14m
pv-stage   2Gi        RWX            Retain           Bound    prod/pvc-prod     nfs                     13m
controlplane $ 
controlplane $ kubectl describe pv pv-prod 
Name:            pv-prod
Labels:          <none>
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           stage/pvc-stage
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/prod/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ 
controlplane $ kubectl describe pv pv-stage 
Name:            pv-stage
Labels:          <none>
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs
Status:          Bound
Claim:           prod/pvc-prod
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        2Gi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /data/stage/pv
    HostPathType:  
Events:            <none>
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-fn577 -c backend -- sh -c "echo '45' >> /static/43.txt"
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-0 -- sh -c "echo '44' > /static/44.txt"
Error from server (NotFound): pods "fb-pod-0" not found
controlplane $ 
controlplane $ kubectl -n prod exec fb-pod-0 -- sh -c "echo '44' > /static/44.txt"
Error from server (NotFound): pods "fb-pod-0" not found
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "echo '44' > /static/44.txt"
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "cat /static/44.txt"
44
controlplane $ 
controlplane $ kubectl -n prod describe po b-pod-0 
Name:         b-pod-0
Namespace:    prod
Priority:     0
Node:         controlplane/172.30.1.2
Start Time:   Mon, 25 Jul 2022 03:29:45 +0000
Labels:       app=b-app
              controller-revision-hash=b-pod-544f8d9858
              statefulset.kubernetes.io/pod-name=b-pod-0
Annotations:  cni.projectcalico.org/containerID: dabeaee31abca22e495b53f83239ea4c103ddb07a9f2e8bbc06070ab9ff983fe
              cni.projectcalico.org/podIP: 192.168.0.6/32
              cni.projectcalico.org/podIPs: 192.168.0.6/32
Status:       Running
IP:           192.168.0.6
IPs:
  IP:           192.168.0.6
Controlled By:  StatefulSet/b-pod
Containers:
  backend:
    Container ID:   containerd://7d2d50e8a1caea7651904dbf1b68a14c4c1ce2fe988a2d408ffaacaddf0bd0da
    Image:          zakharovnpa/k8s-backend:12.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:3dc17ecbe40bda123426b20274b539f72123d51fb8a3d7880b5755a4e50dbc99
    Port:           9000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 25 Jul 2022 03:30:03 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      DATABASE_URL:  postgres://postgres:postgres@db:5432/news
    Mounts:
      /static from prod-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-dnglm (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  prod-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc-prod
    ReadOnly:   false
  kube-api-access-dnglm:
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
  Normal  Scheduled  16m   default-scheduler  Successfully assigned prod/b-pod-0 to controlplane
  Normal  Pulling    16m   kubelet            Pulling image "zakharovnpa/k8s-backend:12.07.22"
  Normal  Pulled     16m   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:12.07.22" in 16.831222455s
  Normal  Created    16m   kubelet            Created container backend
  Normal  Started    16m   kubelet            Started container backend
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get pv 
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM             STORAGECLASS   REASON   AGE
pv-prod    2Gi        RWX            Retain           Bound    stage/pvc-stage   nfs                     49m
pv-stage   2Gi        RWX            Retain           Bound    prod/pvc-prod     nfs                     48m
```
* Tab 2
```
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
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
0 upgraded, 6 newly installed, 0 to remove and 194 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 1s (433 kB/s) 
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
node01 $ pwd      
/root
node01 $ 
node01 $ cd ..
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 25 03:16 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 220 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 25 03:09 root
drwxr-xr-x  36 root root 1.2K Jul 25 03:16 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 25 03:25 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 25 03:16 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 218 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 25 03:09 root
drwxr-xr-x  36 root root 1.2K Jul 25 03:16 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 25 03:27 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 25 03:16 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 225 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 25 03:09 root
drwxr-xr-x  36 root root 1.2K Jul 25 03:16 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 25 03:30 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  20 root root 4.0K Jul 25 03:31 .
drwxr-xr-x  20 root root 4.0K Jul 25 03:31 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x   3 root root 4.0K Jul 25 03:31 data
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 25 03:16 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 231 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 25 03:09 root
drwxr-xr-x  36 root root 1.2K Jul 25 03:16 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 25 03:33 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ cd data/
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 20 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 prod
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 20 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 prod
node01 $ 
node01 $ cd prod/
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x 3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 3 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x 2 root root 4.0K Jul 25 03:34 pv
node01 $ 
node01 $ cd pv/
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x 2 root root 4.0K Jul 25 03:34 .
drwxr-xr-x 3 root root 4.0K Jul 25 03:31 ..
-rw-r--r-- 1 root root    3 Jul 25 03:34 43.txt
node01 $ 
node01 $ find / -name 43.txt
/data/prod/pv/43.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ find / -name 42.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ find / -name 43.txt
/data/prod/pv/43.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ cat /data/prod/pv/43.txt
43
45
node01 $ 
node01 $ find / -name 44.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ pwd
/data/prod/pv
node01 $ 
node01 $ cd ..
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x 3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 3 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x 2 root root 4.0K Jul 25 03:34 pv
node01 $ 
node01 $ 
node01 $ cd ..
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 20 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 prod
node01 $ 
node01 $ cd ..
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  20 root root 4.0K Jul 25 03:31 .
drwxr-xr-x  20 root root 4.0K Jul 25 03:31 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x   3 root root 4.0K Jul 25 03:31 data
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 25 03:16 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 230 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 25 03:09 root
drwxr-xr-x  36 root root 1.2K Jul 25 03:16 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 25 03:44 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ 
node01 $ 
node01 $ cd data/
node01 $ 
node01 $ ls -lha
total 12K
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 .
drwxr-xr-x 20 root root 4.0K Jul 25 03:31 ..
drwxr-xr-x  3 root root 4.0K Jul 25 03:31 prod
node01 $ 
node01 $ find / -name 44.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ find / -name 42.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ pwd
/data
node01 $ find / -name 43.txt
/data/prod/pv/43.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ find / -name 42.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ find / -name 44.txt
find: '/proc/41200/task/41200/net': Invalid argument
find: '/proc/41200/net': Invalid argument
node01 $ 
node01 $ 
node01 $ 

```

### 11. Скрипт для проверок prod. 
[К оглавлению](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-02-mounts/Labs/labs-stage-prod-backend-replicas-pv-ok.md#%D0%BE%D1%82%D0%B2%D0%B5%D1%82-%D0%BD%D0%B0-%D0%B4%D0%B7---backend-%D0%B2-%D0%BE%D0%BA%D1%80%D1%83%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F%D1%85-stage-%D0%B8-prod-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D1%8E%D1%82%D1%81%D1%8F-%D0%BA%D0%B0%D0%B6%D0%B4%D1%8B%D0%B9-%D0%BA-%D1%81%D0%B2%D0%BE%D0%B5%D0%BC%D1%83-pv-%D0%BF%D1%80%D0%B8-%D1%80%D0%B5%D0%BF%D0%BB%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8-%D0%BE%D1%81%D1%82%D0%B0%D0%B5%D1%82%D0%BC%D1%8F-%D0%B2%D0%BE%D0%B7%D0%BC%D0%BE%D0%B6%D0%BD%D0%BE%D1%81%D1%82%D1%8C-%D0%BE%D0%B1%D0%BC%D0%B5%D0%BD%D0%B0-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D0%BC%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-stage-%D0%B8-%D0%BC%D0%B5%D0%B6%D0%B4%D1%83-%D0%BA%D0%BE%D0%BD%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0%D0%BC%D0%B8-%D0%B2%D1%81%D0%B5%D1%85-backend-%D0%B2-prod)




