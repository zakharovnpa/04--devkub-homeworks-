## Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints" - Захаров Сергей Николаевич

Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. 
Его можно найти в папке 13-kubernetes-config.



## Задание 1: подготовить тестовый конфиг для запуска приложения


Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

### Ответ:

#### 1. Файл для деплоя контейнеров с приложениями Frontend, Backend, а также создания сервиса, позволяющего подключаться к поду по порту 80.
! Важно: имя сервиса должно совпадать с именем пода
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod        # Имя пода
  namespace: default
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
#### 2. Файл для создания Statefulset для пода с БД, а также создания сервиса для подключения к БД по порту 5432.

```yml
# Config PostgreSQL StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432

```
#### 3. Скриншоты вывода команды kubectl со списком запущенных объектов каждого типа
  * pods
  
![kubectl-get-pod-stage](/13-kubernetes-config-01-objects/Files/kubectl-get-pod-stage.png)
 
  * deployments
  
![kubectl-get-deploy-stage](/13-kubernetes-config-01-objects/Files/kubectl-get-deploy-stage.png)
  * statefulset
   
![kubectl-get-statefulset-stage](/13-kubernetes-config-01-objects/Files/kubectl-get-statefulset-stage.png)
  * service 

![kubectl-get-service-stage](/13-kubernetes-config-01-objects/Files/kubectl-get-service-stage.png)
 
 * скриншот из самого Kubernetes, что сервисы подняты и работают.

![kubectl-logs-backend-stage](/13-kubernetes-config-01-objects/Files/kubectl-logs-backend-stage.png)

![kubectl-logs-db-stage](/13-kubernetes-config-01-objects/Files/kubectl-logs-db-stage.png)

![curl-db-stage](/13-kubernetes-config-01-objects/Files/curl-db-stage.png)


## Задание 2: подготовить конфиг для production окружения


Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

### Ответ: 
#### 1. Для запуска каждого компонента в своем поде необходимо создать под черз StatefulSet

* Statefulset для Frontend с прописанным через окружение адресом Backend

```yaml
# Config Frontend StatefulSet & Services
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
            value: "http://b-pod:9000"      # адрес сервиса Backend
          name: frontend
          ports:
          - containerPort: 80
      terminationGracePeriodSeconds: 30
```
* Statefulset для Backend с прописанным через окружение адресом удаленной БД
```yml
# Config Backend StatefulSet & Services
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
            value: "postgres://postgres:postgres@db:5432/news"    # Адрес удаленной БД
          name: backend
          ports:
          - containerPort: 9000
      terminationGracePeriodSeconds: 30

```

#### 2. Для доступа к Frontend из Интернет создан Service типа NodePort. Порт 30080.

```yml
# Config Service NodePort
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

```

#### 3. Для доступа Frontend к Backend по порту 9000 создан Service типа ClasterIP

```yml
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

```

#### 4. Для доступа Backend к удаленной БД по порту 5432 созданы Service типа ClasterIP и EndPoint


```yml
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
```
```yml
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

#### 5. Компоненты кластера в работе
```
NAME          READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
pod/b-pod-0   1/1     Running   0          94m   10.233.90.14   node1   <none>           <none>
pod/f-pod-0   1/1     Running   0          94m   10.233.90.15   node1   <none>           <none>

NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE   SELECTOR
service/b-pod   ClusterIP   10.233.52.86   <none>        9000/TCP       94m   app=b-app
service/db      ClusterIP   10.233.14.62   <none>        5432/TCP       94m   <none>
service/f-svc   NodePort    10.233.1.189   <none>        80:30080/TCP   94m   app=f-app

NAME              ENDPOINTS           AGE
endpoints/b-pod   10.233.90.14:9000   94m
endpoints/db      10.128.0.23:5432    94m
endpoints/f-svc   10.233.90.15:80     94m

NAME                     READY   AGE   CONTAINERS   IMAGES
statefulset.apps/b-pod   1/1     94m   backend      zakharovnpa/k8s-backend:12.07.22
statefulset.apps/f-pod   1/1     94m   frontend     zakharovnpa/k8s-frontend:12.07.22

NAME         STATUS   ROLES           AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
node/cp1     Ready    control-plane   6h10m   v1.24.2   10.128.0.8    <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
node/node1   Ready    <none>          6h9m    v1.24.2   10.128.0.19   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6

```
![kubectl-get-prod](/13-kubernetes-config-01-objects/Files/kubectl-get-prod.png)

![screen-site-frontend](/13-kubernetes-config-01-objects/Files/screen-site-frontend.png)



## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).


---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения:
* прикрепите к ДЗ конфиг файлы для деплоя. 
* Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа
  * pods, 
  * deployments, 
  * statefulset, 
  * service 
  * или скриншот из самого Kubernetes, что сервисы подняты и работают.

---
