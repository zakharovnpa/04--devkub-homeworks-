### "Успешное подключение - 4" к PV не используя StorageClass для Deployment в окружении stage. Ход решения для выполнения ДЗ 13.2-1


#### Задача:
1. Использовать только Volume (не используя PersistentVolume, StorageClass)
2. Развернуть деплоймент из двух приложений frontend, backend с возможностью обмена данными сежду приложениями (у каждого своя дирекотрия для общих файлов). 
3. Проверить возможность создания и получения доступа к общим файлам
4. Проверить место нахождение дирекотрии для Volume на ноде 

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

* Tab 1
```
Initialising Kubernetes... done

controlplane $ date
Tue Jul 26 01:42:53 UTC 2022
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ vi fb-pod.yaml
```
##### Создаем namespace "stage"
```
controlplane $ kubectl create namespace stage
namespace/stage created
```
##### Тестирование кластера
```
controlplane $ kubectl get po,sc,pv,pvc,svc
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   78d
controlplane $ 
controlplane $ kubectl -n stage get po,sc,pv,pvc,svc
No resources found
controlplane $ 
controlplane $ kubectl -n stage get po,sc,pv,pvc,svc,deploy
No resources found
controlplane $ 
controlplane $ kubectl get po,sc,pv,pvc,svc,deploy
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   78d
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







### Оставшиеся логи
```
controlplane $ date
Tue Jul 26 01:55:40 UTC 2022
controlplane $ 
controlplane $ kubectl -n stage get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
fb-pod-6464948946-lqhcc   2/2     Running   0          10m   192.168.1.3   node01   <none>           <none>
controlplane $ 
controlplane $ kubectl -n stage get pod fb-pod-6464948946-lqhcc -o yaml | grep nodeName
  nodeName: node01
controlplane $ 
controlplane $ kubectl -n stage get pod fb-pod-6464948946-lqhcc -o yaml | grep uid     
    uid: daa04cff-33c5-45b8-a9a7-7925d23f7f51
  uid: 70abe7ee-53b4-436e-b066-4a2e4ae342ee
controlplane $ 
```
#### Неуспешная попытка реплицирования деплоя
```
controlplane $ kubectl -n stage scale deploy/fb-pod --replicas=3
deployment.apps/fb-pod scaled
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-bgbhz   0/2     ContainerCreating   0          23s
fb-pod-6464948946-c94xj   2/2     Running             0          23s
fb-pod-6464948946-lqhcc   2/2     Running             0          17m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-bgbhz   2/2     Running   0          39s
fb-pod-6464948946-c94xj   2/2     Running   0          39s
fb-pod-6464948946-lqhcc   2/2     Running   0          17m
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c frontend -- ls -la /static
total 10256
drwxrwxrwx 2 root root     4096 Jul 26 01:54 .
drwxr-xr-x 1 root root     4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root 10485760 Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root        3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root        3 Jul 26 01:51 43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- ls -la /static
ls: cannot access '/static': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-lqhcc -c backend -- ls -la /tmp/cache
total 10256
drwxrwxrwx 2 root root     4096 Jul 26 01:54 .
drwxrwxrwt 1 root root     4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root 10485760 Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root        3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root        3 Jul 26 01:51 43.txt
```
* Под перестал отвечать
```
controlplane $ kubectl -n stage exec fb-pod-6464948946-bgbhz -c frontend -- ls -la /static
error: cannot exec into a container in a completed pod; current phase is Failed
```
* Поды расплодились, но некоторые находятся в состоянии "Evicted"
```
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-4b6hn   0/2     Evicted                  0          67s
fb-pod-6464948946-bgbhz   0/2     ContainerStatusUnknown   2          2m15s
fb-pod-6464948946-c94xj   2/2     Running                  0          2m15s
fb-pod-6464948946-d6w52   0/2     Evicted                  0          67s
fb-pod-6464948946-lqhcc   2/2     Running                  0          19m
fb-pod-6464948946-pm7md   0/2     Evicted                  0          67s
fb-pod-6464948946-qj6rb   0/2     Evicted                  0          66s
fb-pod-6464948946-rfs58   0/2     Evicted                  0          67s
fb-pod-6464948946-tvwcz   0/2     Evicted                  0          66s
fb-pod-6464948946-vq252   2/2     Running                  0          65s
fb-pod-6464948946-vtvh6   0/2     Evicted                  0          67s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-4b6hn   0/2     Evicted                  0          86s
fb-pod-6464948946-bgbhz   0/2     ContainerStatusUnknown   2          2m34s
fb-pod-6464948946-c94xj   2/2     Running                  0          2m34s
fb-pod-6464948946-d6w52   0/2     Evicted                  0          86s
fb-pod-6464948946-lqhcc   2/2     Running                  0          19m
fb-pod-6464948946-pm7md   0/2     Evicted                  0          86s
fb-pod-6464948946-qj6rb   0/2     Evicted                  0          85s
fb-pod-6464948946-rfs58   0/2     Evicted                  0          86s
fb-pod-6464948946-tvwcz   0/2     Evicted                  0          85s
fb-pod-6464948946-vq252   2/2     Running                  0          84s
fb-pod-6464948946-vtvh6   0/2     Evicted                  0          86s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-4b6hn   0/2     Evicted                  0          104s
fb-pod-6464948946-bgbhz   0/2     ContainerStatusUnknown   2          2m52s
fb-pod-6464948946-c94xj   2/2     Running                  0          2m52s
fb-pod-6464948946-d6w52   0/2     Evicted                  0          104s
fb-pod-6464948946-lqhcc   2/2     Running                  0          19m
fb-pod-6464948946-pm7md   0/2     Evicted                  0          104s
fb-pod-6464948946-qj6rb   0/2     Evicted                  0          103s
fb-pod-6464948946-rfs58   0/2     Evicted                  0          104s
fb-pod-6464948946-tvwcz   0/2     Evicted                  0          103s
fb-pod-6464948946-vq252   2/2     Running                  0          102s
fb-pod-6464948946-vtvh6   0/2     Evicted                  0          104s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-4b6hn   0/2     Evicted                  0          2m45s
fb-pod-6464948946-bgbhz   0/2     ContainerStatusUnknown   2          3m53s
fb-pod-6464948946-c94xj   2/2     Running                  0          3m53s
fb-pod-6464948946-d6w52   0/2     Evicted                  0          2m45s
fb-pod-6464948946-lqhcc   2/2     Running                  0          20m
fb-pod-6464948946-pm7md   0/2     Evicted                  0          2m45s
fb-pod-6464948946-qj6rb   0/2     Evicted                  0          2m44s
fb-pod-6464948946-rfs58   0/2     Evicted                  0          2m45s
fb-pod-6464948946-tvwcz   0/2     Evicted                  0          2m44s
fb-pod-6464948946-vq252   2/2     Running                  0          2m43s
fb-pod-6464948946-vtvh6   0/2     Evicted                  0          2m45s
```
* Исследование одного из упавших подов
```
controlplane $ kubectl -n stage get pod fb-pod-6464948946-4b6hn
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-4b6hn   0/2     Evicted   0          3m5s
controlplane $ 
controlplane $ kubectl -n stage get pod fb-pod-6464948946-4b6hn -o wide
NAME                      READY   STATUS    RESTARTS   AGE     IP       NODE           NOMINATED NODE   READINESS GATES
fb-pod-6464948946-4b6hn   0/2     Evicted   0          3m13s   <none>   controlplane   <none>           <none>
controlplane $ 
controlplane $ kubectl -n stage describe pod fb-pod-6464948946-4b6hn -o wide
error: unknown shorthand flag: 'o' in -o
See 'kubectl describe --help' for usage.
controlplane $ 
controlplane $ kubectl -n stage describe pod fb-pod-6464948946-4b6hn        
Name:           fb-pod-6464948946-4b6hn
Namespace:      stage
Priority:       0
Node:           controlplane/
Start Time:     Tue, 26 Jul 2022 02:04:10 +0000
Labels:         app=fb-app
                pod-template-hash=6464948946
Annotations:    <none>
Status:         Failed
Reason:         Evicted
Message:        Pod The node had condition: [DiskPressure]. 
IP:             
IPs:            <none>
Controlled By:  ReplicaSet/fb-pod-6464948946
Containers:
  frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-m7r64 (ro)
  backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /tmp/cache from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-m7r64 (ro)
Volumes:
  my-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-m7r64:
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
  Type     Reason     Age    From               Message
  ----     ------     ----   ----               -------
  Warning  Evicted    3m44s  kubelet            The node had condition: [DiskPressure].
  Normal   Scheduled  3m44s  default-scheduler  Successfully assigned stage/fb-pod-6464948946-4b6hn to controlplane
```
* Кол-во деплоев соответствует команде репликации
```
controlplane $ kubectl -n stage get deploy                     
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   3/3     3            3           22m
```
* Удаляем деплоймент
```
controlplane $ kubectl delete -f fb-pod.yaml 
deployment.apps "fb-pod" deleted
service "fb-pod" deleted
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get deploy
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get pod                                
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-c94xj   2/2     Terminating   0          6m36s
fb-pod-6464948946-lqhcc   2/2     Terminating   0          23m
fb-pod-6464948946-vq252   2/2     Terminating   0          5m26s
controlplane $ 
controlplane $ kubectl -n stage get pod
No resources found in stage namespace.
controlplane $ 
controlplane $ 
```
#### Вторая попытка реплицирования деплоя
```
controlplane $ kubectl apply -f fb-pod.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          4s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage scale --replicas=3  deployment/fb-pod         
deployment.apps/fb-pod scaled
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          4s
fb-pod-6464948946-74q8r   2/2     Running             0          73s
fb-pod-6464948946-9fhnq   2/2     Running             0          4s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          9s
fb-pod-6464948946-74q8r   2/2     Running             0          78s
fb-pod-6464948946-9fhnq   2/2     Running             0          9s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          13s
fb-pod-6464948946-74q8r   2/2     Running             0          82s
fb-pod-6464948946-9fhnq   2/2     Running             0          13s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          17s
fb-pod-6464948946-74q8r   2/2     Running             0          86s
fb-pod-6464948946-9fhnq   2/2     Running             0          17s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          22s
fb-pod-6464948946-74q8r   2/2     Running             0          91s
fb-pod-6464948946-9fhnq   2/2     Running             0          22s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          26s
fb-pod-6464948946-74q8r   2/2     Running             0          95s
fb-pod-6464948946-9fhnq   2/2     Running             0          26s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          30s
fb-pod-6464948946-74q8r   2/2     Running             0          99s
fb-pod-6464948946-9fhnq   2/2     Running             0          30s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerCreating   0          35s
fb-pod-6464948946-74q8r   2/2     Running             0          104s
fb-pod-6464948946-9fhnq   2/2     Running             0          35s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          40s
fb-pod-6464948946-74q8r   2/2     Running   0          109s
fb-pod-6464948946-9fhnq   2/2     Running   0          40s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          44s
fb-pod-6464948946-74q8r   2/2     Running   0          113s
fb-pod-6464948946-9fhnq   2/2     Running   0          44s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          48s
fb-pod-6464948946-74q8r   2/2     Running   0          117s
fb-pod-6464948946-9fhnq   2/2     Running   0          48s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          52s
fb-pod-6464948946-74q8r   2/2     Running   0          2m1s
fb-pod-6464948946-9fhnq   2/2     Running   0          52s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          56s
fb-pod-6464948946-74q8r   2/2     Running   0          2m5s
fb-pod-6464948946-9fhnq   2/2     Running   0          56s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          60s
fb-pod-6464948946-74q8r   2/2     Running   0          2m9s
fb-pod-6464948946-9fhnq   2/2     Running   0          60s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          66s
fb-pod-6464948946-74q8r   2/2     Running   0          2m15s
fb-pod-6464948946-9fhnq   2/2     Running   0          66s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-5wqnt   2/2     Running   0          71s
fb-pod-6464948946-74q8r   2/2     Running   0          2m20s
fb-pod-6464948946-9fhnq   2/2     Running   0          71s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          75s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m24s
fb-pod-6464948946-9fhnq   2/2     Running                  0          75s
fb-pod-6464948946-wpj6l   2/2     Running                  0          2s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          79s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m28s
fb-pod-6464948946-9fhnq   2/2     Running                  0          79s
fb-pod-6464948946-wpj6l   2/2     Running                  0          6s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          89s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m38s
fb-pod-6464948946-9fhnq   2/2     Running                  0          89s
fb-pod-6464948946-wpj6l   2/2     Running                  0          16s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          95s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m44s
fb-pod-6464948946-9fhnq   2/2     Running                  0          95s
fb-pod-6464948946-wpj6l   2/2     Running                  0          22s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          99s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m48s
fb-pod-6464948946-9fhnq   2/2     Running                  0          99s
fb-pod-6464948946-wpj6l   2/2     Running                  0          26s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          103s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m52s
fb-pod-6464948946-9fhnq   2/2     Running                  0          103s
fb-pod-6464948946-wpj6l   2/2     Running                  0          30s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          107s
fb-pod-6464948946-74q8r   2/2     Running                  0          2m56s
fb-pod-6464948946-9fhnq   2/2     Running                  0          107s
fb-pod-6464948946-wpj6l   2/2     Running                  0          34s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-5wqnt   0/2     ContainerStatusUnknown   2          111s
fb-pod-6464948946-74q8r   2/2     Running                  0          3m
fb-pod-6464948946-9fhnq   2/2     Running                  0          111s
fb-pod-6464948946-wpj6l   2/2     Running                  0          38s
controlplane $ 
controlplane $ kubectl delete -n stage pod fb-pod-6464948946-5wqnt 
pod "fb-pod-6464948946-5wqnt" deleted
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          3m42s
fb-pod-6464948946-9fhnq   2/2     Running   0          2m33s
fb-pod-6464948946-wpj6l   2/2     Running   0          80s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          3m45s
fb-pod-6464948946-9fhnq   2/2     Running   0          2m36s
fb-pod-6464948946-wpj6l   2/2     Running   0          83s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          3m49s
fb-pod-6464948946-9fhnq   2/2     Running   0          2m40s
fb-pod-6464948946-wpj6l   2/2     Running   0          87s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          3m51s
fb-pod-6464948946-9fhnq   2/2     Running   0          2m42s
fb-pod-6464948946-wpj6l   2/2     Running   0          89s
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-74q8r   2/2     Running   0          3m54s
fb-pod-6464948946-9fhnq   2/2     Running   0          2m45s
fb-pod-6464948946-wpj6l   2/2     Running   0          92s
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-wpj6l -c backend -- sh -c "echo '43' > /tmp/cache/43.txt"
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-9fhnq -c backend -- cat /tmp/cache/43.txt
cat: /tmp/cache/43.txt: No such file or directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6464948946-wpj6l -c backend -- cat /tmp/cache/43.txt
43
controlplane $ 


```
* Tab 2
```
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $ find /var/lib/kubelet -name 42.txt
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/42.txt
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/43.txt
node01 $ 
node01 $ ls -lha /var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/
total 11M
drwxrwxrwx 2 root root 4.0K Jul 26 01:54 .
drwxr-xr-x 3 root root 4.0K Jul 26 01:46 ..
-rw-r--r-- 1 root root  10M Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root    3 Jul 26 01:51 43.txt
node01 $ 
node01 $ ls -la /var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume/
total 10256
drwxrwxrwx 2 root root     4096 Jul 26 01:54 .
drwxr-xr-x 3 root root     4096 Jul 26 01:46 ..
-rw-r--r-- 1 root root 10485760 Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root        3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root        3 Jul 26 01:51 43.txt
node01 $ 
node01 $ find /var/lib/kubelet -name my-volume | grep volumes
/var/lib/kubelet/pods/70abe7ee-53b4-436e-b066-4a2e4ae342ee/volumes/kubernetes.io~empty-dir/my-volume
node01 $ 
node01 $ find /var/lib/kubelet -name my-volume | grep volumes | xargs ls -lha
total 11M
drwxrwxrwx 2 root root 4.0K Jul 26 01:54 .
drwxr-xr-x 3 root root 4.0K Jul 26 01:46 ..
-rw-r--r-- 1 root root  10M Jul 26 01:54 10mb.txt
-rw-r--r-- 1 root root    3 Jul 26 01:49 42.txt
-rw-r--r-- 1 root root    3 Jul 26 01:51 43.txt
node01 $ 
node01 $ find /var/lib/kubelet -name 43.txt
node01 $ 
node01 $ date
Tue Jul 26 02:15:36 UTC 2022
node01 $ 
```



### Неверный ход решения:


#### 1. Установка NFS
* Команды на ControlNode
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \

helm repo add stable https://charts.helm.sh/stable && helm repo update && \

helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y

```
* Команды на WorkerNode
```
apt install nfs-common -y
```
### 2. Создание namespace `stage`

```
kubectl create namespace stage
```

### 3. Тестирование кластера
#### 3.1 StorageClass
```
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   91s
```
#### 3.2 Services
```
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     68d
nfs-server-nfs-server-provisioner   ClusterIP   10.96.246.57   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   2m12s
```
#### 3.3 Pod
```
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          3m13s
```
### 4. Создаем запрос (PVC) с именем pvc на том(volume) на основе storageClassName nfs. Режим доступа - ReadWriteMany. 

* `pvc.yaml`
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

### 6. Создаем поды для Stage

* Frontend и Backend [mount-stage-front-back.yaml](/13-kubernetes-config-02-mounts/Files/mount-stage-front-back.yaml)

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
```
kubectl apply -f mount-stage-front-back.yaml
```

#### 6.1 Проверяем доступность тома и возможность создания файлов в NFS

#### 6.1.1 Создаем в контейнере nginx в директории монтирования /static файл 42.txt
```
controlplane $ kubectl exec pod -c nginx -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@pod:/# 
root@pod:/# 
root@pod:/# ls -lha | grep static
drwxrwsrwx   2 root root 4.0K Jul 18 12:59 static
root@pod:/# 
root@pod:/# cd static/
root@pod:/static# 
root@pod:/static# ls -lha
total 8.0K
drwxrwsrwx 2 root root 4.0K Jul 18 12:59 .
drwxr-xr-x 1 root root 4.0K Jul 18 13:00 ..
root@pod:/static# 
root@pod:/static# echo '42' > 42.txt
root@pod:/static# 
root@pod:/static# cat 42.txt 
42
root@pod:/static# 
```
#### 6.1.2 Ищем файл 42.txt на ноде, на которой запущен под и контейнер с NFS сервером
```
controlnode$ ssh node01
node01 $
node01 $ find / -name 42.txt
/var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
```
```
node01 $ ls -lha /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/      
total 16K
drwxrwsrwx 2 root root 4.0K Jul 18 13:16 .
drwxr-x--- 3 root root 4.0K Jul 18 13:00 ..
-rw-r--r-- 1 root root    3 Jul 18 13:03 42.txt
-rw-r--r-- 1 root root    3 Jul 18 13:16 43.txt
node01 $ cat /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/42.txt
42
node01 $ 
node01 $ cat /var/lib/kubelet/pods/027aa5b4-dd73-41bc-aaab-a9438a49c54a/volumes/kubernetes.io~nfs/pvc-bdba834f-9043-4096-87d0-e532abdff6a7/43.txt
43
node01 $ 
```
### Ответ: 

#### 6.2 Результат:
  - общая директория монтируется через запрос PVC только к тому PV? 
  - подключение с одного контейнера к двум разным PVC, находящимся в разных Namespace - невозможно
  - Подключение к одному PVC из контейнеров из разных Namespace - невозможно
