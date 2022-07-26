

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
```
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
node01 $ 
node01 $ date
Tue Jul 26 02:15:36 UTC 2022
node01 $ 
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

### Ответ: 



---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
