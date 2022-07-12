## Ход выполнения ДЗ по теме "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.


### В лекции по ДЗ      - 02:09:10

## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

#### Пояснение: 
  * приложения можно ставить и свои, но аналогичные
  * манифесты можно брать от преподавателя и создать то, что нам нужно

* Важно: 
  * конфиг для теста (задача 1) и для продакшена (задача 2) - разные 

* В тестовом конфиге в описании одного пода находятся два контейнера — фронтенд, бекенд;
* Надо сделать БД через statefulset.
* Пример направления трафика на внешнюю БД:
![pod-to-db](/13-kubernetes-config-01-objects/Files/pod-to-db.png)

* Что еще на описано но надо иметь ввиду:
  * фронтенд может обращаться к бэеэнду напрямую. Они в одном поде
  * Создать сервис для обращения к БД. Нам нужен сервис. Без него не сможем обратиться к БД.
  * мы сделали БД через statefulset
  * в описании пода указать метки (селекторы и т.д.)
  * селекторы мы должны указать в сервисе, который будет обращаться к подам

### Ход решения Задания 1

#### 1. Созданы образы для запуска контейнеров
* Процесс создания описан здесь: [Ход создания образов приложений Frontend, Backand, DataBase](/13-kubernetes-config-01-objects/Lesson/build-docker-compose-images.md)
* Приготовленные образы размещаем на Dockerhub
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker push zakharovnpa/k8s-frontend:05.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-frontend]
352d627bd336: Pushed 
a5b05b1f6d07: Pushed 
cf2af7b6ae79: Pushed 
649f9ccbcc97: Pushed 
e7344f8a29a3: Mounted from library/nginx 
44193d3f4ea2: Mounted from library/nginx 
41451f050aa8: Mounted from library/nginx 
b2f82de68e0d: Mounted from library/nginx 
d5b40e80384b: Mounted from library/nginx 
08249ce7456a: Mounted from library/nginx 
05.07.22: digest: sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a size: 2401
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config# docker push zakharovnpa/k8s-backend:05.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-backend]
59283fad6e30: Pushed 
c4bf1e206190: Pushed 
fbd3193641ee: Pushed 
de4ab17faf49: Pushed 
a4023f1effb2: Pushed 
843f990feb92: Mounted from library/python 
70dce5ebf427: Mounted from library/python 
aba5ac262080: Mounted from library/python 
2df8715307ad: Mounted from library/python 
e6fd4ebbaaab: Mounted from library/python 
261e5d6450d3: Mounted from library/python 
65d22717bade: Mounted from library/python 
3abde9518332: Mounted from library/python 
0c8724a82628: Mounted from library/python 
05.07.22: digest: sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f size: 3264
```
#### 2. Создаем план развертывания приложений в кластере.
* Количество нод - не оговаривается, но возьмем две ноды
* В первом поде содержатся контейнеры:
  * Frontend
  * Backend
  >  Будем делать первый Deploy, в котором описано создание Frontend и Backend в одном поде
* Во втором поде содержится:
  *  БД
  >  Будем делать первый Statefulset, в котором описано создание БД в одном отдельном поде
* Необходимо создать сервис для обращения к БД
  * селекторы мы должны указать в сервисе, который будет обращаться к подам

#### 3. Создаем манифесты для разворачивания приложений на основе созданых подов с помощью Kubectl

##### 3.1 Deployment для Frontend
1. При создании файла-манифеста, на основании которого создается Deployment для frontend, воспользуемся утилитой kubectl.
* Команда `kubectl create deployment k8s-frontend --image=zakharovnpa/k8s-frontend:05.07.22` запускаетсоздание деплоймента на основе образа для Frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl create deployment k8s-frontend --image=zakharovnpa/k8s-frontend:05.07.22
deployment.apps/k8s-frontend created
```
* Dеployment создан
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-frontend   1/1     1            1           26s
```
* Полученный при создании файл-манифест Deployment для frontend
```yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment -o yaml
apiVersion: v1
items:
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    annotations:
      deployment.kubernetes.io/revision: "1"
    creationTimestamp: "2022-07-04T19:51:47Z"
    generation: 1
    labels:
      app: k8s-frontend
    name: k8s-frontend
    namespace: default
    resourceVersion: "81654"
    uid: c4e0c5f7-ed0f-4f2a-a1cf-4dd759986d22
  spec:
    progressDeadlineSeconds: 600
    replicas: 1
    revisionHistoryLimit: 10
    selector:
      matchLabels:
        app: k8s-frontend
    strategy:
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 25%
      type: RollingUpdate
    template:
      metadata:
        creationTimestamp: null
        labels:
          app: k8s-frontend
      spec:
        containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: k8s-frontend
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        schedulerName: default-scheduler
        securityContext: {}
        terminationGracePeriodSeconds: 30
  status:
    availableReplicas: 1
    conditions:
    - lastTransitionTime: "2022-07-04T19:52:00Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: Deployment has minimum availability.
      reason: MinimumReplicasAvailable
      status: "True"
      type: Available
    - lastTransitionTime: "2022-07-04T19:51:47Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: ReplicaSet "k8s-frontend-7d4b4986f5" has successfully progressed.
      reason: NewReplicaSetAvailable
      status: "True"
      type: Progressing
    observedGeneration: 1
    readyReplicas: 1
    replicas: 1
    updatedReplicas: 1
kind: List
metadata:
  resourceVersion: ""

```
##### 3.2 Deployment для Backend
1. При создании файла-манифеста, на основании которого создается Deployment для Backend, воспользуемся утилитой kubectl.
* Команда `kubectl create deployment k8s-backend --image=zakharovnpa/k8s-backend:05.07.22` запускаетсоздание деплоймента на основе образа для Backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl create deployment k8s-backend --image=zakharovnpa/k8s-backend:05.07.22
deployment.apps/k8s-backend created
```
* Dеployment создан
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-backend    0/1     1            0           7s
k8s-frontend   5/5     5            5           9h
```
* Полученный при создании файл-манифест Deployment для frontend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment k8s-backend -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2022-07-05T04:58:29Z"
  generation: 1
  labels:
    app: k8s-backend
  name: k8s-backend
  namespace: default
  resourceVersion: "137025"
  uid: 9a93f04d-8960-4cad-a9a0-de57f423895a
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: k8s-backend
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: k8s-backend
    spec:
      containers:
      - image: zakharovnpa/k8s-backend:05.07.22
        imagePullPolicy: IfNotPresent
        name: k8s-backend
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2022-07-05T04:58:59Z"
    lastUpdateTime: "2022-07-05T04:58:59Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2022-07-05T04:58:29Z"
    lastUpdateTime: "2022-07-05T04:58:59Z"
    message: ReplicaSet "k8s-backend-95b5f4f77" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

```


#### 4. Готовим манифесты для Deployment Frontend и Backend. В этих же файлах будут описаны манифесты для создания сервисов. Данные для создания сервисов берем из файла `docker-compose.yml`

* Файл `docker-compose.yml`
```yml
version: "3.7"

services:
  frontend:
    build: ./frontend
    ports:
      - 8000:80

  backend:
    build: ./backend
    links:
      - db
    ports:
      - 9000:9000

  db:
    image: postgres:13-alpine
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: news
```

* Deployment frontend
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: froontend
  name: froontend
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: froontend
  template:
    metadata:
      labels:
        app: froontend
    spec:
      containers:
      - image: nginx:1.20
        imagePullPolicy: IfNotPresent
        name: nginx
      - image: praqma/network-multitool:alpine-extra
        imagePullPolicy: IfNotPresent
        name: multitool
        env:
          - name: HTTP_PORT
            value: "8080"
# Далле идет описание сервиса, с помощью которого можно будет подключаться к вышеописанному поду        
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: postgres-db-lb
spec:
  selector:
    app: postgres-db
  type: LoadBalancer
  ports:
    - port: 5432
      targetPort: 5432

```


#### 5. Готовим StatefulSet для создания БД. БД будет распологаться в кластере Kubernetes.

* Порядок подготовки:
  * Подготовить Dockerfile для создания образа
  * Подготовить файл .env с указанием переменных окружения
  * Подготовить манифест для сервиса с указанием протоколов и портов для подключений

* Dockerfile
```
FROM postgres:13-alpine
```
* Файл `.env` с переменными окружения
```
POSTGRES_PASSWORD=postgres
POSTGRES_USER=postgres
POSTGRES_DB=news

```

* Подготовка образа для БД. Находясь в директории, где расположены Dockerfile и файл с переменными `.env` запускаем команду. Не забываем про точку в конце - указание контекста сборки - директории где мы запускаемся.
`docker build -t zakharovnpa/k8s-database:05.07.22 .`

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/database# docker build -t zakharovnpa/k8s-database:05.07.22 .
Sending build context to Docker daemon  3.072kB
Step 1/1 : FROM postgres:13-alpine
 ---> 2bb8cea1e0bb
Successfully built 2bb8cea1e0bb
Successfully tagged zakharovnpa/k8s-database:05.07.22
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/database# docker image list
REPOSITORY                                                          TAG               IMAGE ID       CREATED         SIZE
zakharovnpa/k8s-backend                                             05.07.22          bf58e470d5a5   19 hours ago    1.07GB
zakharovnpa/k8s-frontend                                            05.07.22          5438a0c5806b   19 hours ago    142MB
zakharovnpa/k8s-database                                            05.07.22          2bb8cea1e0bb   13 days ago     213MB

```
* Пушим образ в репозиторий zakharovnpa на Dockerhub
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/database# docker push zakharovnpa/k8s-database:05.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-database]
0bc5f2edb483: Mounted from library/postgres 
c703c3dc0dd0: Mounted from library/postgres 
16da13de1326: Mounted from library/postgres 
adc529f3f318: Mounted from library/postgres 
ffa3969dfaf6: Mounted from library/postgres 
14f83c4d2ba1: Mounted from library/postgres 
2acf3ef23fe4: Mounted from library/postgres 
24302eb7d908: Mounted from library/postgres 
05.07.22: digest: sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5 size: 1985
```



* Работающий StatefulSet `k8s-database.yml`, примененный в кластере для создания БД
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: k8s-database
spec:
  serviceName: k8s-database-svc
  selector:
    matchLabels:
      app: k8s-database
  replicas: 1
  template:
    metadata:
      labels:
        app: k8s-database
    spec:
      containers:
        - name: k8s-database
          image: postgres:13-alpine
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
  name: k8s-database-svc
spec:
  selector:
    app: k8s-database
  type: LoadBalancer
  ports:
    - port: 5432
      targetPort: 5432

```
* Запуск создания БД на основе StatefulSet
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ vim k8s-database.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl apply -f k8s-database.yml 
statefulset.apps/k8s-database created
service/k8s-database-svc created
```
* Поды, запущенные на нодах кластера
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          3h57m   10.233.90.4   node1   <none>           <none>
k8s-database-0                  1/1     Running   0          66m     10.233.96.6   node2   <none>           <none>
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          4h20m   10.233.90.3   node1   <none>           <none>
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          13h     10.233.96.1   node2   <none>           <none>
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          4h20m   10.233.90.2   node1   <none>           <none>
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          4h20m   10.233.96.3   node2   <none>           <none>
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          4h20m   10.233.96.2   node2   <none>           <none>
```
* Логи пода с БД
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-database-0
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-05 07:49:06.512 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-05 07:49:07.846 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-05 07:49:07.851 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-05 07:49:07.879 UTC [37] LOG:  database system was shut down at 2022-07-05 07:49:07 UTC
2022-07-05 07:49:07.892 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down....2022-07-05 07:49:08.233 UTC [36] LOG:  received fast shutdown request
2022-07-05 07:49:08.247 UTC [36] LOG:  aborting any active transactions
2022-07-05 07:49:08.249 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-05 07:49:08.249 UTC [38] LOG:  shutting down
2022-07-05 07:49:08.324 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-05 07:49:08.368 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-05 07:49:08.369 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-05 07:49:08.369 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-05 07:49:08.378 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-05 07:49:08.407 UTC [50] LOG:  database system was shut down at 2022-07-05 07:49:08 UTC
2022-07-05 07:49:08.418 UTC [1] LOG:  database system is ready to accept connections

```
* Без парметров `env` в файле-манифесте для БД, под не запускался. Были ошибки
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-database-0
Error: Database is uninitialized and superuser password is not specified.
       You must specify POSTGRES_PASSWORD to a non-empty value for the
       superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

       You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
       connections without a password. This is *not* recommended.

       See PostgreSQL documentation about "trust":
       https://www.postgresql.org/docs/current/auth-trust.html

```


* Пример манифеста StatefulSet для БД [Postgres-SQL](/13-kubernetes-config-01-objects/Files/statefulset-for-postgres-db.yml)

* Пример файла-манифеста для StatefulSet для приложения [Prometheus](/13-kubernetes-config-01-objects/Files/statefulset-for-prometheus.yml)


#### 6. Тестирование доступности приложений м БД, работа сервисов

* Запущенные сервисы
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get svc -o wide
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   174m   app=k8s-database
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          28h    <none>
```
* Запущенные Endpoints
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get ep -o wide
NAME               ENDPOINTS          AGE
k8s-database-svc   10.233.96.6:5432   175m
kubernetes         10.128.0.18:6443   28h
```




## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными StatefulSet (ранее говорилось что deployment’ами);
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

#### Пояснение     -01:12:35
  * Сервисы для каждого компонента свой отдельный 
  * в окружении фронта (Environment) нужно  прописан адрес сервиса бекенда 
  * в окружении бекенда прописан адрес сервиса базы данных.
  * БД запускать не в Кубере, а отдельно.


## Ответ:
Согласно пояснению преподавателя необходимо сделать так, чтобы приложения фронта и бекаенда запускалиьс каждый в своем поде, а БД запускалась вне
кластера Kubernetes.
### 1. Создаем namespace
```
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ kubectl create namespace prod
namespace/prod created
controlplane $ 
controlplane $ kubectl create namespace test
namespace/test created
controlplane $ 
```
```
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   64d
kube-node-lease   Active   64d
kube-public       Active   64d
kube-system       Active   64d
prod              Active   90s
stage             Active   95s
test              Active   86s
```
### 1. Создаем два файла с StatefulSet. Так каждое приложение будет запущено в своем поде.
#### 1.1 StatefulSet Frontend
* в окружении фронта прописать адрес сервиса бекенда

```
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: BASE_URL
            value: "http://localhost:9000"
          name: frontend
          ports:
          - containerPort: 80
```
*




#### 1.2 StatefulSet Backend
* в окружении бекенда прописать адрес сервиса базы данных
```
      containers:
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: "postgres://postgres:postgres@db:5432/news"
          name: backend
          ports:
          - containerPort: 9000
```
* StatefulSet для создания отдельного пода с контейнером Frontend
* Service ClasterIP и Endpoint для возможности соединения Frontend с удаленной БД
```yml
# Config PostgresSQL Deployment & Services
# home/maestro/learning-kubernetes/Betta/manifest/postgres/prod/training/v-220712/v-11-20/StatefulSet-backend.yaml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: b-app
  name: b-pod
  namespace: stage
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
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: "postgres://postgres:postgres@db:5432/news"
          name: backend
          ports:
          - containerPort: 9000
      terminationGracePeriodSeconds: 30
---

```
* Развертывание пода и сервисов
```
controlplane $ kubectl apply -f StatefulSet-backend.yaml 
statefulset.apps/b-pod created
service/db created
endpoints/db created
controlplane $ 
controlplane $ 
controlplane $ kubectl get -n stage po,svc,ep -o wide
NAME          READY   STATUS    RESTARTS   AGE    IP            NODE     NOMINATED NODE   READINESS GATES
pod/b-pod-0   1/1     Running   0          3m3s   192.168.1.4   node01   <none>           <none>

NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE    SELECTOR
service/db   ClusterIP   10.99.4.64   <none>        5432/TCP   3m4s   <none>

NAME           ENDPOINTS          AGE
endpoints/db   10.128.0.14:5432   3m4s
```



### 2. Создаем два файла с Service
#### 2.1 Service NodePort для доступа к Frontend из Интернета



#### 2.2 Service EndPoint для доступа Backend к удаленной БД

### 3. Создаем БД за пределами кластера k8s

#### План создания
* На отдельной ноде устанавливается docker, docker-compose
* На основе файла docker-compose.yaml запускается  контейнер с БД
* При этом с другой ноды по адресу ноды будут доступны порт 5432

#### Решение: ход создания описан в [файле](/13-kubernetes-config-01-objects/Lesson/works-in-docker-2.md)

#### 3.1 Service для доступа к БД от Backend

* На других нодах разорачивается кластер K8S
* На одном из подов ставится приложение multitool
* Также добавляются сервисы для доступа к БД, расположенной на отельной ноде.

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl -n default get svc,ep,po -o wide
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE     SELECTOR
service/kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP    5h41m   <none>
service/multitool    ClusterIP   10.233.58.43   <none>        5432/TCP   18m     app=multitool

NAME                   ENDPOINTS          AGE
endpoints/kubernetes   10.128.0.20:6443   5h41m
endpoints/multitool    10.233.96.1:5432   17m

NAME                             READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
pod/db-0                         1/1     Running   0          28s     10.233.90.3   node1   <none>           <none>
pod/multitool-86dd874c4c-9snbd   2/2     Running   0          5h18m   10.233.96.1   node2   <none>           <none>

```
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/main$ kubectl -n default get svc,ep,po -o wide
NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE     SELECTOR
service/kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP    5h41m   <none>
service/multitool    ClusterIP   10.233.58.43   <none>        5432/TCP   18m     app=multitool

NAME                   ENDPOINTS          AGE
endpoints/kubernetes   10.128.0.20:6443   5h41m
endpoints/multitool    10.233.96.1:5432   17m

NAME                             READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
pod/db-0                         1/1     Running   0          28s     10.233.90.3   node1   <none>           <none>
pod/multitool-86dd874c4c-9snbd   2/2     Running   0          5h18m   10.233.96.1   node2   <none>           <none>
```
* Сервис доступа к БД
```yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-01$ kubectl get svc multitool -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"app":"multitool"},"name":"multitool","namespace":"default"},"spec":{"ports":[{"name":"5432","port":5432,"targetPort":5432}],"selector":{"app":"multitool"}}}
  creationTimestamp: "2022-07-10T14:13:23Z"
  labels:
    app: multitool
  name: multitool
  namespace: default
  resourceVersion: "33684"
  uid: 7f2ee0f3-a8ad-4bfe-b986-743123c84c1f
spec:
  clusterIP: 10.233.58.43
  clusterIPs:
  - 10.233.58.43
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: "5432"
    port: 5432
    protocol: TCP
    targetPort: 5432
  selector:
    app: multitool
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

```
* Сервис Endpoint

```yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/training/v-01$ kubectl get ep multitool -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-10T14:13:23Z"
  creationTimestamp: "2022-07-10T14:14:05Z"
  labels:
    app: multitool
  name: multitool
  namespace: default
  resourceVersion: "33685"
  uid: 58dac7ca-d6e0-4355-bd1c-ea461dfc7fde
subsets:
- addresses:
  - ip: 10.233.96.1
    nodeName: node2
    targetRef:
      kind: Pod
      name: multitool-86dd874c4c-9snbd
      namespace: default
      uid: faf97b11-7e1f-4851-8ed7-b3f5187657ad
  ports:
  - name: "5432"
    port: 5432
    protocol: TCP

```
* Файлы, с которыми работает доступ к порту БД на удаленной ноде с приложением multitool

```yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ cat clasterip-db.yaml 
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: multitool
  namespace: default
spec:
  ports:
    - name: db      
      port: 5432
      targetPort: 5432
```

```yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/stage/multitool$ cat endpoint-db.yml 
---
apiVersion: v1
kind: Endpoints
metadata:
  name: multitool 
  namespace: default
subsets:
  - addresses:
      - ip: 10.128.0.10
    ports:
      - port: 5432

```



## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).

#### Пояснение:
* 

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают.

---
