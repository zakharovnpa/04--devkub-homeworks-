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
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
```
helm repo add stable https://charts.helm.sh/stable && helm repo update
```
```
helm install nfs-server stable/nfs-server-provisioner
```
```
apt install nfs-common -y
```

#### 2.1 Worker Node
```
apt install nfs-common -y
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
### 5. NFS установлен. Создаем запрос (PVC) на том и создаем тестовый Pod с Nginx

* pvc.yaml
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
* pod.yaml
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
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
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


#### 6.2 Результат:
  - общая директория монтируется через запрос PVC только к тому PV? 
  - подключение с одного контейнера к двум разным PVC, находящимся в разных Namespace - невозможно
  - Подключение к одному PVC из контейнеров из разных Namespace - невозможно

#### 6.3 Логи можно увидеть здесь 
- [Подключение к NFS пода в namespace stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-stage-pvc.md)
- [Подключение к NFS подов в default и stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-default-stage-pvc.md)
- [Невозможное решение: Подключение к PV через StorageClass подов в default и stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-default-stage-pv-sc-pvc.md)
- [Подключение к PV через StorageClass подов в prod и stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-prod-stage-pv-sc-pvc.md)
- [Успешное подключение к PV через StorageClass для Deployment в окружении stage](/13-kubernetes-config-02-mounts/Labs/labs-mount-stage-pv-ok.md)


### 7. Создаем поды для Prod

#### 7.1 Frontend [mount-prod-frontend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-frontend.yaml)

```
kubectl apply -f mount-prod-frontend.yaml
```
* `mount-prod-frontend.yaml`
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
# The END

```
#### 7.2 Backend [mount-prod-backend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-backend.yaml)
```
kubectl apply -f mount-prod-backend.yaml
```
* `mount-prod-backend.yaml`
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

```
