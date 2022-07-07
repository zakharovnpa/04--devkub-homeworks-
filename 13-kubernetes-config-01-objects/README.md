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
