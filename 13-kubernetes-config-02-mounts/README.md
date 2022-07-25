

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
