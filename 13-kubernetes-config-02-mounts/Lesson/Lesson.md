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

### Ход выполнения ДЗ вопрос №1

1. Манифесты Stage-front-back.yaml

```
# Config Deployment Frontend & Backend
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
            - mountPath: "/data/pv"
              name: my-volume
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc

        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/data/pv"
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

2. Сервисы

* pv.yaml
```yml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```
* pvc.yaml
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
* Пример манифеста с примонтированием PV `pod.yaml`
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



## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.


### Пояснения преподавателя:

1. Запустить контейнер с сервером NFS для создания общего сетевого ресурса в поде
2. Подключить Backend-ы из Stage и Prod к одному и тому же PV в режиме ReadWriteMany
3. Можно делать с помощью Storage Class и Persistent Volume Clame, который автоматически создастся
4. Для Backend все описано в одном деплойменте

1. Для Frontend создается другой деплоймент
2. Этот деплоймент подключается  к тому же PV, к которому подключаются Backend также в режиме ReadWriteMany
3. Файлы, созданные на Stage Backend должны быть доступны на Prod Backend и на Prod Frontend
4. Показать, что файлы, записаные на Backend доступны на Frontend и наоборот




---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
