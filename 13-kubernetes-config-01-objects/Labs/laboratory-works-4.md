## 12.07.2022 Ход работ по ДЗ "13.1 контейнеры, поды, deployment, statefulset, services, endpoints" - Задача №2

### Задачи:
1. В Яндекс.Облаке развернуть три ВМ для  cp1, node1, node2 кластера Kubernetes
2. На node2 развернуть в Docker-compose контейнер с БД PostgresSQL
3. На нодах cp1, node1 развернуть кластер Kubernetes
4. В кластере Kubernetes развернуть приложения Frontend, Backend 
5. Связать приложение Backend с БД, расположенной на node2. Проверить доступность
  * Вручную добавить переменную окружения для доступа к БД
  * Запустить сервисы ClasterIP, EndPoint
6. Связать приложение Frontend с Backend. Проверить доступность
  * Вручную добавить переменную окружения для доступа к Backend
7. Предоставить доступ к Frontend из Интерента для доступа ко всем приложениям
  * Добавить сервис типа NodePort
8. Проверить функционал работы приложений
  * В БД должны записыватья скрипты
  * Логи подключений
  * Скриншоты страницы

### Задачи дополнительные
1. Пересобрать образы приложений Frontend, Backend так, чтобы переменные окружения были добавлены в новый образ

### Ход выполнения

#### 4. В кластере Kubernetes развернуть приложения Frontend, Backend 

1. Рабочая директория
```
/home/maestro/learning-kubernetes/Betta/manifest/postgres/prod/training/v-220712/v-13-14
$ date
Вт 12 июл 2022 15:36:42 +04

```


2. Согласно задания необходимо создать Namespace "prod"
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres/prod/training/v-220712/v-13-14$ kubectl create namespace prod
namespace/prod created
```
3. Файл для StatefulSet Frontend
```yml
# Config PostgresSQL Deployment & Services
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
#  serviceName: b-pod
  selector:
    matchLabels:
      app: f-app
  template:
    metadata:
      labels:
        app: f-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          env: 
          - name: BASE_URL
            value: "http://localhost:9000"
          name: frontend
          ports:
          - containerPort: 80
      terminationGracePeriodSeconds: 30


# Config Service ClasterIP
#---
#apiVersion: v1
#kind: Service
#metadata:
#  name: b-pod
#  namespace: prod
#spec:
#  ports:
#    - name: b-pod      
#      port: 9000
#      targetPort: 9000
#  selector:
#    app: f-app

# Config Service NodePort
---
apiVersion: v1
kind: Service
metadata:
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
4. Файл для StatefulSet Backend
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
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: "postgres://postgres:postgres@db:5432/news"
          name: backend
          ports:
          - containerPort: 9000
      terminationGracePeriodSeconds: 30

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

# Config Service NodePort
#---
#apiVersion: v1
#kind: Service
#metadata:
#  name: b-nod
#spec:
#  type: NodePort
#  selector:
#    app: b-nod
#  ports:
#  - port: 9000
#    targetPort: 9000
#    nodePort: 30090

# The END

```





#### 5. Связать приложение Backend с БД, расположенной на node2. Проверить доступность
  * Вручную добавить переменную окружения для доступа к БД
  * Запустить сервисы ClasterIP, EndPoint
#### 6. Связать приложение Frontend с Backend. Проверить доступность
  * Вручную добавить переменную окружения для доступа к Backend
#### 7. Предоставить доступ к Frontend из Интерента для доступа ко всем приложениям
  * Добавить сервис типа NodePort
#### 8. Проверить функционал работы приложений
  * В БД должны записыватья скрипты
  * Логи подключений
  * Скриншоты страницы
