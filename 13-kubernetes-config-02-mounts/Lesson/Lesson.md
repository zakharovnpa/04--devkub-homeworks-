## Ход выполнения ДЗ по теме "13.2 разделы и монтирование"

Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.

Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
* установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
* добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
* установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner


### Пояснения преподавателя:
1. Данные команды выполнять на локальной ОС, на которой установлен kubectl
2. Все делается через API кластера
3. Инсталляция Helm, NFS будет произведена а кластереKubernetes

В конце установки будет выдан пример создания PVC для этого сервера.

## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

Пояснение: показать, что оно доступно из другого пода.

- ["Успешное подключение - 2" к PV через StorageClass Deployment in stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-stage-pv-ok-2.md)

### Ход выполнения ДЗ вопрос №1

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

#### 1. Исходный манифест `stage-front-back.yaml` для развертывания приложений на одной  тойже ноде

```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod        # Имя пода
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

#### 2. Манифесты с добавлением возможности подключения Volume `Stage-front-back.yaml`

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
      
      volumes:
        - name: my-volume
          emptyDir: {}

      
#      volumes:
#        - name: my-volume
#          persistentVolumeClaim:
#            claimName: pvc

        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/157/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
              
              
#     volumes:
#        - name: my-volume
#          persistentVolumeClaim:
#            claimName: pvc
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
#### 3. Логи выполненя задания

- итоговый манифест `stage-front-back.yaml`

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
- Логи выполнения ДЗ на сайте killercoda `https://killercoda.com/playgrounds/scenario/kubernetes`

* Создаем NAmespace stage
```
controlplane $ kubectl create ns stage
namespace/stage created
```

#### Первая попытка запуска StatefilSet
```
controlplane $ kubectl apply -f statefulset-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
```
* StatefulSet запущен. Почему-то только один контейнер запустился
```
controlplane $ kubectl -n stage get po,svc,pv,pvc 
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-697b65674f-kcx46   1/1     Running   0          2m25s

NAME             TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.103.168.232   <none>        80:30080/TCP   2m25s
```
#### Создание файлов в дирекотриях контейнеров, подключенных к общему тому
* На frontend
```
controlplane $ kubectl -n stage exec fb-pod-697b65674f-kcx46 -c frontend -- sh -c "echo '42' > /static/42.txt"
```
* На backend. Не создается из-за ошибки "конетйнер backend отсутствет в поде"
```
controlplane $ kubectl -n stage exec fb-pod-697b65674f-kcx46 -c backend -- sh -c "echo '43' > /157cache/43.txt"
Error from server (BadRequest): container backend is not valid for pod fb-pod-697b65674f-kcx46
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-697b65674f-kcx46 -c backend -- sh -c "echo '43' > /157/cache/43.txt"
Error from server (BadRequest): container backend is not valid for pod fb-pod-697b65674f-kcx46
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-697b65674f-kcx46 -c backend -- sh -c "echo '43' > /157/cache/43.txt"
Error from server (BadRequest): container backend is not valid for pod fb-pod-697b65674f-kcx46
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-697b65674f-kcx46 -c backend -it bash --                             
error: you must specify at least one command for the container
```
* Статус пода - Running. Один контейнер запущен.
```
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-697b65674f-kcx46   1/1     Running   0          13m
```
* Статус пода - Running в раширенном виде
```
controlplane $ kubectl -n stage get po -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
fb-pod-697b65674f-kcx46   1/1     Running   0          14m   192.168.1.4   node01   <none>           <none>
```
* Описание пода показывает, что контейнер backend не запущен.
```
controlplane $ kubectl -n stage describe po fb-pod-697b65674f-kcx46 
Name:         fb-pod-697b65674f-kcx46
Namespace:    stage
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Fri, 15 Jul 2022 14:40:24 +0000
Labels:       app=fb-app
              pod-template-hash=697b65674f
Annotations:  cni.projectcalico.org/containerID: c3c64f32b34d9708bf7282df68e0f19140418a4045cd85b41829ce35903f1812
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  ReplicaSet/fb-pod-697b65674f
Containers:
  frontend:
    Container ID:   containerd://f308419387171c8d128b1ed2e0e77226a59da6dd8468bdcef0870e93bf1d3efd
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Fri, 15 Jul 2022 14:40:32 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jkwpn (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-jkwpn:
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
  Normal  Scheduled  15m   default-scheduler  Successfully assigned stage/fb-pod-697b65674f-kcx46 to node01
  Normal  Pulling    15m   kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     14m   kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 6.948000613s
  Normal  Created    14m   kubelet            Created container frontend
  Normal  Started    14m   kubelet            Started container frontend
```
* Под в статусе Running. ЗАпущен только один контейнер
```
controlplane $ kubectl -n stage get po        
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-697b65674f-kcx46   1/1     Running   0          25m
```
* Удаляем под
```
controlplane $ kubectl delete -f statefulset-front-back.yaml 
deployment.apps "fb-pod" deleted
service "fb-pod" deleted
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f statefulset-front-back.yaml 
error: error validating "statefulset-front-back.yaml": error validating data: [ValidationError(Deployment.spec.template.spec.volumes[1]): unknown field "image" in io.k8s.api.core.v1.Volume, ValidationError(Deployment.spec.template.spec.volumes[1]): unknown field "imagePullPolicy" in io.k8s.api.core.v1.Volume, ValidationError(Deployment.spec.template.spec.volumes[1]): unknown field "volumeMounts" in io.k8s.api.core.v1.Volume]; if you choose to ignore these errors, turn validation off with --validate=false
```
* Подов запущенных нет.
```
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
```
#### Вторая попытка запуска StatefulSet 
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
* Описание пода. Созданы два конейнера - backend и frontend
```
controlplane $ kubectl -n stage describe po fb-pod-57bdd94bd-ldwg5 
Name:         fb-pod-57bdd94bd-ldwg5
Namespace:    stage
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Fri, 15 Jul 2022 15:10:21 +0000
Labels:       app=fb-app
              pod-template-hash=57bdd94bd
Annotations:  cni.projectcalico.org/containerID: d81c02c0f038198471eb64880e308c7dd29a6d267c93464021a130d187626dcc
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:           192.168.1.5
Controlled By:  ReplicaSet/fb-pod-57bdd94bd
Containers:
  frontend:
    Container ID:   containerd://9c3fbe86a57f13f8f440c392eeec6b0c3d6958bf18908e37f644726fff078761
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Fri, 15 Jul 2022 15:10:22 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mzqdx (ro)
  backend:
    Container ID:   containerd://cd736728f233c8301e74a2858cd7a78e6b9a86d1646c9f6af16d4ebf733c8a60
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 15 Jul 2022 15:10:46 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /157/cache from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mzqdx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-mzqdx:
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
  Normal  Scheduled  65s   default-scheduler  Successfully assigned stage/fb-pod-57bdd94bd-ldwg5 to node01
  Normal  Pulled     65s   kubelet            Container image "zakharovnpa/k8s-frontend:05.07.22" already present on machine
  Normal  Created    64s   kubelet            Created container frontend
  Normal  Started    64s   kubelet            Started container frontend
  Normal  Pulling    64s   kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     41s   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 23.627716599s
  Normal  Created    40s   kubelet            Created container backend
  Normal  Started    40s   kubelet            Started container backend
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


## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.


### Пояснения преподавателя:

1. Запустить контейнер с сервером NFS для создания общего сетевого ресурса в поде
2. Подключить Backend-ы из Stage и Prod к одному и тому же PV в режиме ReadWriteMany
3. Можно делать с помощью Storage Class и Persistent Volume Clame, который автоматически создастся
4. Для Backend все описано в одном StatefuSset (деплойменте)

1. Для Frontend создается другой StatefuSet (деплоймент)
2. Этот StatefuSset подключается  к тому же PV, к которому подключаются Backend также в режиме ReadWriteMany
3. Файлы, созданные на Stage Backend должны быть доступны на Prod Backend и на Prod Frontend
4. Показать, что файлы, записаные на Backend доступны на Frontend и наоборот


#### Ход выполнения заданя 2

#### Задача:
##### 1. Запуск на ноде в отдельном поде сервера NFS

 Если на используется NFS, то создать папку на ноде и указать ее в качестве PV

1. Это будет аналог сетевой общей папки для подключения к ней наших пирложенй
2. Сделать PV, который будет иметь доступ к серверу NFS
3.

##### Х. Неверная трактовка задания: Подключить Backend-ы из Stage и Prod к одному и тому же PV
##### 2. Верная трактовка задания: Подключить экземпляры Backend из всех его реплик в окружении Stage к одному и тому же PV.
##### 3. Верная трактовка задания: Подключить экземпляры Backend из всех его реплик в окружении Prod к одному и тому же PV.

1. В манифесте StatefuSet Backend Stage
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;


2. В манифесте StatefuSet Backend Prod
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;

##### Х. Неверная трактовка: Подключить Frontend из Prod к тому же PV с NFS, что Backend 

1. В манифесте StatefuSet Frontend Prod
  - Добавть монитроване к Volume
  - Добавить Volume, StorageClass, ReadWriteMany, PVC
  - в спецификации пода необходимо указать ссылку на PersistentVolumeClaim (запрос на том);
  - в спецификации PersistentVolumeClaim указываются необходимые параметры тома: размер и режим доступа;

##### 4. Порядок запуска

1. PV
2. PVC
3. Pod

##### 5. Примеры манифестов

* Пример манифеста PersistentVolume `pv.yaml`
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""      # сюда записать имя
  accessModes:
    - ReadWriteOnce       #режим подключения - чтать и записывать только одному
  capacity:
    storage: 2Gi
  hostPath:           # тип хранилища
    path: /data/pv
```
* Пример манифеста PersistentVolumeClaim `pvc.yaml`
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
* Пример манифеста пода с примонтированием PV `pod.yaml`
```yml
---
apiVersion: v1
kind: Pod
metadata:
  name: pod
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
      - mountPath: "/data/pv"
        name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```

#### Ход выполнения тестового подключения. Используется конфигурация для frontend, backend из одного пода в окружении stage.

##### Иcпользуется материал ЛР
- [Успешное подключение к PV через StorageClass Deployment in stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-stage-pv-ok.md)


```
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Jul 21 13:55 .
drwx------ 8 root root 4.0K Jul 21 13:55 ..
-rw-r--r-- 1 root root  186 Jul 21 13:51 pv.yaml
-rw-r--r-- 1 root root  197 Jul 21 13:55 pvc.yaml
-rw-r--r-- 1 root root 1.1K Jul 21 13:55 stage-front-back.yaml
controlplane $ 
controlplane $ 
```
* cat pv.yaml

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
* cat pvc.yaml
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
##### 1. Проdеряем состав кластера перед развертыванием
* Статус Pod сервера NFS - Running
```
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          5m31s
```
* PersistentVolume отсутствуют в Namespace default
```
controlplane $ kubectl get pv
No resources found
```
* PersistentVolumeClaim отсутствуют в Namespace default
```
controlplane $ kubectl get pvc
No resources found in default namespace.
```
* PersistentVolume отсутствуют в Namespace stage
```
controlplane $ kubectl -n stage get pv 
No resources found
```
* PersistentVolumeClaim отсутствуют в Namespace stage
```
controlplane $ kubectl -n stage get pvc
No resources found in stage namespace.
```
* Pod отсутствуют в Namespace stage
```
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
```
* Services отсутствуют в Namespace stage
```
controlplane $ kubectl -n stage get svc
No resources found in stage namespace.
```
* Deployments отсутствуют в Namespace stage
```
controlplane $ kubectl -n stage get deployments.apps 
No resources found in stage namespace.
```


##### 2. Создаем PersistentVolume - постоянный том в сети на основе StoageClass `nfs`
```
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
```
* Persistent Volume в статусе Available в Namespace stage. Режим доступа - RWX - ReadWriteMany
```
controlplane $ kubectl -n stage get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     7s
```
* Persistent Volume в статусе Available в Namespace default. Режим доступа - RWX - ReadWriteMany
```
controlplane $ kubectl -n default get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     20s
```
##### 3. Создаем PersistentVolumeClaim, принадлежать он будет Namespace stage
```
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
```
```
controlplane $ kubectl -n default get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl -n stage get pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            11s
```
##### 4. Создаем Deployment в Namespace stage с контейнерами front и back
```
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ kubectl -n stage get pod              
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-lqh7v   2/2     Running   0          36s
```
* Заходим в контейнере frontend в общую папку static
```
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c frontend -it bash   
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-lqh7v:/app# 
root@fb-pod-6c4fbd7c86-lqh7v:/app# cd /
root@fb-pod-6c4fbd7c86-lqh7v:/# ls -lha | grep static
drwxr-xr-x   2 root root 4.0K Jul 21 13:57 static
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# cd static/
```
* Директория для общих файлов пока пустая
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 21 13:57 .
drwxr-xr-x 1 root root 4.0K Jul 21 13:57 ..
```
* Создаем новый общий файл
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# echo '42' > 42.txt
```
* Считываем его содержимое
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# cat 42.txt 
42
```
* Заходим в контейнере backend в общую папку static

```
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-lqh7v:/app# cd /
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# cd static/
```
* Видим в общей директории файл 42.txt, созданный ранее в контейнере Frontend
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt
```
* Создаем новый общий файл 43.txt
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# echo '43' > 43.txt
```
* Видим в общей директории новый файл 43.txt, и файл 42.txt, созданный ранее в контейнере Frontend
```
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt  43.txt
```

##### 5. Реплицируем Deployment
```
controlplane $ kubectl -n stage scale deployment fb-pod --replicas=3
deployment.apps/fb-pod scaled
```

* Смотрим количество реплик подов
```
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6c4fbd7c86-8tprw   2/2     Running                  0          5m6s
fb-pod-6c4fbd7c86-jncwt   2/2     Running                  0          3m50s
fb-pod-6c4fbd7c86-lqh7v   2/2     Running                  0          12m
```
##### 6. Во всех контейнерах есть общие папки и общие файлы
* Для пода fb-pod-6c4fbd7c86-8tprw
```
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c backend -it bash -- ls /static
42.txt  43.txt
```
* Для пода fb-pod-6c4fbd7c86-jncwt
```
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-jncwt -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-jncwt -c backend -it bash -- ls /static
42.txt  43.txt
```
* Для пода fb-pod-6c4fbd7c86-lqh7v
```
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c backend -it bash -- ls /static
42.txt  43.txt
```
##### 7. Проdеряем состав кластера после развертыванием



#### Ход выполнения тестового подключения. Используется конфигурация для frontend, backend, где каждый в своем поде в окружении prod

##### Установка NFS

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

##### Используемые манифесты
##### Манифесты томов
* pv.yaml
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
* pvc.yaml
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: prod
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```


##### Манифесты окружения
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
              name: my-volume
      terminationGracePeriodSeconds: 30
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc
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
---
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
              name: my-volume
      terminationGracePeriodSeconds: 30
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc

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
---
# The END
```

##### Команды создания файлов в конейнере

##### Команды просмотра наличия файлов в конейнере

##### Команды просмотра содержимого файлов в конейнере

##### Команды просмотра содержимого файлов в ноде

##### Логи выполнения



---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
