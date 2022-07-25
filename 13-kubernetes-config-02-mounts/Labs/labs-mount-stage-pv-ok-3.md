### 

#### 0. Установка NFS
* ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \

helm repo add stable https://charts.helm.sh/stable && helm repo update && \

helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y

```
* WorkerNode
```
apt install nfs-common -y
```

#### 1. 
* манифест `stage-front-back.yaml`

```yml
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
```
#### 3. Создаем Namespace stage
```
controlplane $ kubectl create ns stage
namespace/stage created
```

#### 4. Запуск StatefulSet 
```
controlplane $ kubectl apply -f statefulset-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
```
* Под запустился после создания 
```
controlplane $ kubectl -n stage get po
NAME                     READY   STATUS              RESTARTS   AGE
fb-pod-57bdd94bd-ldwg5   0/2     ContainerCreating   0          8s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                     READY   STATUS    RESTARTS   AGE
fb-pod-57bdd94bd-ldwg5   2/2     Running   0          34s
```
* Под в статусе Running
```
controlplane $ kubectl -n stage get po
NAME                     READY   STATUS    RESTARTS   AGE
fb-pod-57bdd94bd-ldwg5   2/2     Running   0          2m15s
```

#### Проверка возможности записи в том

* Выполняем запись в общий том для backend
```
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-ldwg5 -c backend -- sh -c "echo '43' > /157/cache/43.txt"
```
* Выполняем запись в общий том для backend
```
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-ldwg5 -c frontend -- sh -c "echo '42' > /static/42.txt"
```
#### Проверка возможности считвыания из тома

* Считывание для frontend. Оба файла доступны
```
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-ldwg5 -c frontend -- ls -la /static                    
total 16
drwxrwxrwx 2 root root 4096 Jul 15 15:13 .
drwxr-xr-x 1 root root 4096 Jul 15 15:10 ..
-rw-r--r-- 1 root root    3 Jul 15 15:13 42.txt
-rw-r--r-- 1 root root    3 Jul 15 15:13 43.txt
```
* Считывание для backend. Оба файла доступны
```
controlplane $ kubectl -n stage exec fb-pod-57bdd94bd-ldwg5 -c backend -- ls -la /157/cache                    
total 16
drwxrwxrwx 2 root root 4096 Jul 15 15:13 .
drwxr-xr-x 3 root root 4096 Jul 15 15:10 ..
-rw-r--r-- 1 root root    3 Jul 15 15:13 42.txt
-rw-r--r-- 1 root root    3 Jul 15 15:13 43.txt
```
* Узнаем на какой ноде развернулся под. На node01
```
controlplane $ kubectl -n stage get po fb-pod-57bdd94bd-ldwg5 -o yaml | grep nodeName
  nodeName: node01
```
* Уточнием какие uid у томов пода
```
controlplane $ kubectl -n stage get po fb-pod-57bdd94bd-ldwg5 -o yaml | grep uid     
    uid: fa5904cb-3c15-4f4a-8efb-13f3bf269b67
  uid: fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa
```
#### Выполняем проверку где распологаются созданные файла на ноде
* Подключаемся к ноде 01
```
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
```
* Выполняем поиск файлов
```
node01 $ find /var/lib/kubelet -name 42.txt
/var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume/42.txt
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
/var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume/43.txt
node01 $ 
node01 $ ls -lha /var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume 
total 16K
drwxrwxrwx 2 root root 4.0K Jul 15 15:13 .
drwxr-xr-x 3 root root 4.0K Jul 15 15:10 ..
-rw-r--r-- 1 root root    3 Jul 15 15:13 42.txt
-rw-r--r-- 1 root root    3 Jul 15 15:13 43.txt
node01 $ 
node01 $ find /var/lib/kubelet/ -name my-volume | grep volumes
/var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume
node01 $ 
node01 $ find /var/lib/kubelet/ -name my-volume | grep volumes | xargs ls -la
total 16
drwxrwxrwx 2 root root 4096 Jul 15 15:13 .
drwxr-xr-x 3 root root 4096 Jul 15 15:10 ..
-rw-r--r-- 1 root root    3 Jul 15 15:13 42.txt
-rw-r--r-- 1 root root    3 Jul 15 15:13 43.txt
```
* Содержимое тома `my-volume`
```
node01 $ ls -lha /var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume/
total 16K
drwxrwxrwx 2 root root 4.0K Jul 15 15:13 .
drwxr-xr-x 3 root root 4.0K Jul 15 15:10 ..
-rw-r--r-- 1 root root    3 Jul 15 15:13 42.txt
-rw-r--r-- 1 root root    3 Jul 15 15:13 43.txt
```
* Считываем содержимое общих файлов
```
node01 $ cat /var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume/42.txt
42
node01 $ 
node01 $ cat /var/lib/kubelet/pods/fbe0ffb6-9237-4d34-a8a4-51f411ebe0aa/volumes/kubernetes.io~empty-dir/my-volume/43.txt
43
node01 $ 
```
#### Ход решения:

##### Используемые манифесты:

* `pv.yaml` Манифест для создания сетевого хранилища на ноде в директории /data/pv на основе storageClassName nfs. Режим доступа - Чтение и запись для многих. Размер - 2Гб.

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
* `pvc.yaml` Манифест для создания запроса на сетевоге хранилище. 
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

* `stage-front-back.yaml` Манифест развертывания приложений с возможностью монитрования директории контейнеров /static к volume на основе запроса PVC

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

### 3. Репликация stage.

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
fb-pod-6d5f85cbb8-jpw4l   2/2     Running                  0          5m10s
```
### 4. Тестирование доступа к общему тому. 
* На backend выполняем в директории общего доступа /static, к которой примонитрован volume
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "echo '42' > /static/42.txt"
```
* Проверяем наличие файла
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "ls -lha /static"
total 12K
drwxr-xr-x 2 root root 4.0K Jul 23 04:47 .
drwxr-xr-x 1 root root 4.0K Jul 23 04:37 ..
-rw-r--r-- 1 root root    3 Jul 23 04:47 42.txt
```
* Проверяем контент файла
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
42
```
* Для frontend stage-volume недоступен

```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/42.txt"
cat: /static/42.txt: No such file or directory
command terminated with exit code 1
```
### 5. Поиск файла 42.txt на ноде node01

```
node01 $ find /data/stage/pv -name 42.txt
/data/stage/pv/42.txt
```
```
node01 $ cat /data/stage/pv/42.txt
42
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
42
44
```

#### Проверка доступности общих файлов для всех контейнеров всех реплик

##### Для пода fb-pod-6d5f85cbb8-6wck8
* frontend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/42.txt"
42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-6wck8 -c backend -- sh -c "cat /static/42.txt"
42
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
42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-88chm -c backend -- sh -c "cat /static/42.txt"
42
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
42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c frontend -- sh -c "cat /static/43.txt"
43
```
* backend
```
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -- sh -c "cat /static/42.txt"
42
44
controlplane $ kubectl -n stage exec fb-pod-6d5f85cbb8-jpw4l -c backend -- sh -c "cat /static/43.txt"
43
```
