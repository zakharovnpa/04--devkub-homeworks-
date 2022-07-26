

# Домашнее задание к занятию "13.2 разделы и монтирование"

Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.

Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
* установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
* добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
* установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner

В конце установки будет выдан пример создания PVC для этого сервера.


## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

### Ход решения:

#### Используемый манифест деплоя

* fb-pod.yaml

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
            - mountPath: "/tmp/cache"
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


##### Создаем namespace "stage"
```
controlplane $ kubectl create namespace stage
namespace/stage created
```
##### Разворачивание среды stage
```
controlplane $ kubectl apply -f fb-pod.yaml 
deployment.apps/fb-pod created
service/fb-pod created
```
##### Тестирование среды stage
```
controlplane $ kubectl -n stage get po,sc,pv,pvc,svc,deploy
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6464948946-lqhcc   2/2     Running   0          25s

NAME             TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.103.189.210   <none>        80:30080/TCP   25s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod   1/1     1            1           25s
```
##### Работа с общими файлами и директориями
* Общих файлов в общих директориях пока никаких нет
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- ls -la /static
total 8
drwxrwxrwx 2 root root 4096 Jul 26 01:46 .
drwxr-xr-x 1 root root 4096 Jul 26 01:46 ..
```
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- ls -la /tmp/cache
total 8
drwxrwxrwx 2 root root 4096 Jul 26 01:46 .
drwxrwxrwt 1 root root 4096 Jul 26 01:46 ..
```
* Создаем на frontend файл 42.txt, в котором записано число 42
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- sh -c "echo '42' > /static/42.txt"
```
* На backend в общей директории появился файл 42.txt
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- ls -la /tmp/cache
total 12
drwxrwxrwx 2 root root 4096 Jul 26 01:49 .
drwxrwxrwt 1 root root 4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
```
* Создаем на backend файл 43.txt, в котором записано число 43
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- sh -c "echo '43' > /tmp/cache/43.txt"
```
* На frontend в общей директории появился файл 43.txt. Теперь там два файла.
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- ls -la /static
total 16
drwxrwxrwx 2 root root 4096 Jul 26 01:51 .
drwxr-xr-x 1 root root 4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root    3 Jul 26 01:51 43.txt
```
* На frontend читаем содержимое общих файлов
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- cat /static/42.txt
42
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- cat /static/43.txt
43
```
* На backend читаем содержимое общих файлов
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- cat /tmp/cache/42.txt 
42
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- cat /tmp/cache/43.txt
43
```
* Создаем на frontend файл 10mb.txt размером 10Мб
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- dd if=/dev/zero of=/static/10mb.txt bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.00479298 s, 2.2 GB/s
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- ls -la /static
total 10256
drwxrwxrwx 2 root root     4096 Jul 26 01:54 .
drwxr-xr-x 1 root root     4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root 10485760 Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root        3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root        3 Jul 26 01:51 43.txt
```
* На backend также появился файл 10mb.txt
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- ls -la /tmp/cache
total 10256
drwxrwxrwx 2 root root     4096 Jul 26 01:54 .
drwxrwxrwt 1 root root     4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root 10485760 Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root        3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root        3 Jul 26 01:51 43.txt
```
#### Где на ноде расположены общие файлы

```
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
```
* Ищем директорию с нашими файлми "42.txt" и "43.txt"
```
node01 $ find /var/lib/kubelet -name 42.txt
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/42.txt
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/43.txt
```
* Просматриваем содержимое общей директории. Видим здесь все три файла.
```
node01 $ ls -lha /var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/
total 11M
drwxrwxrwx 2 root root 4.0K Jul 26 01:54 .
drwxr-xr-x 3 root root 4.0K Jul 26 01:46 ..
-rw-r--r-- 1 root root  10M Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root    3 Jul 26 01:51 43.txt
```
* Другой вариант просмотра содержимого директории
```
node01 $ find /var/lib/kubelet -name my-volume | grep volumes
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume
```
```
node01 $ find /var/lib/kubelet -name my-volume | grep volumes | xargs ls -lha
total 11M
drwxrwxrwx 2 root root 4.0K Jul 26 01:54 .
drwxr-xr-x 3 root root 4.0K Jul 26 01:46 ..
-rw-r--r-- 1 root root  10M Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root    3 Jul 26 01:51 43.txt
```

### Ответ:
* в поде подключены общие папки для передачи данных между контейнерами (во frontend - /static, в backend - /tmp/cache);
* после сохранения данных в контейнере backend файлы можно получить из контейнера frontend.




## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.

### Ход решения:

#### 1. Установка NFS

* Выполним скрипт на ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y
```
* Выполним команду на WorkerNode
```
apt install nfs-common -y
```
#### 2. Создаем namespace prod
```
kubectl create namespace prod
```
#### 3. Используемые манифесты
##### 3.1 Манифесты создания и подключения общих томов
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

##### 3.2 Манифесты для создания окружения
* Для Frontend `prod-frontend.yaml`

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
* Для Backend `prod-backend.yaml`

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
#### 4. Разворачиваем окружение
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
#### 5. Тестирование окружения
* StorageClass "nfs"
```
controlplane $ kubectl -n prod get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   8m14s
```
* PersistentVolume "pv-prod". Статус - подключен, режим доступа - чтение и запись для многих (RWX)
```
controlplane $ kubectl -n prod get persistentvolume              
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM           STORAGECLASS   REASON   AGE
pv-prod   2Gi        RWX            Retain           Bound    prod/pvc-prod   nfs                     116s
```
* PersistentVolumeClaim "pvc-prod". Статус - подключен, режим доступа - чтение и запись для многих (RWX)
```
controlplane $ kubectl -n prod get persistentvolumeclaims 
NAME       STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc-prod   Bound    pv-prod   2Gi        RWX            nfs            2m1s
```
* Поды frontend, backend
```
controlplane $ kubectl -n prod get pod                    
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          2m12s
f-pod-0   1/1     Running   0          2m12s
```
* StatefulSet frontend, backend
```
controlplane $ kubectl -n prod get statefulsets.apps 
NAME    READY   AGE
b-pod   1/1     2m20s
f-pod   1/1     2m20s
```
#### 6. Тестирование доступа к общему тому для Fronend и для Backend. 

* Пока еще пустые директории для обмена данными на backend и на frontend
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "ls -lha /static"
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 26 04:57 .
drwxr-xr-x 1 root root 4.0K Jul 26 04:57 ..
controlplane $ 
controlplane $ kubectl -n prod exec f-pod-0 -- sh -c "ls -lha /static"
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 26 04:57 .
drwxr-xr-x 1 root root 4.0K Jul 26 04:57 ..
```

* Создаем файл 42.txt на backend

```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "echo '42' > /static/42.txt"
controlplane $ 
```
* Читаем файл 42.txt на frontend
```
controlplane $ kubectl -n prod exec f-pod-0 -- sh -c "cat /static/42.txt"
42
```
* Создаем файл 43.txt на frontend
```
controlplane $ kubectl -n prod exec b-pod-0 -- sh -c "echo '43' > /static/43.txt"
```
* Читаем файл 43.txt на backend
```
controlplane $ kubectl -n prod exec f-pod-0 -- sh -c "cat /static/43.txt"
43
```

### Ответ:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, доступны фронту.



---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
