## Ход выполнения ДЗ к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet"
В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения
Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:
* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
* в переменных чарта измените образ приложения для изменения версии.

### Ход выполнения
Пояснения:
* Необходимо упаковать приложение в чарт для деплоя в разные окружения (namespace app1 и app2)

* Требования:
* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
  * для сервиса
  * для деплоя
* в переменных чарта измените образ приложения для изменения версии.
  * использовать разные версии образа 

### Варианты решения:
- [Задание 1: подготовить helm чарт для приложения. Вариант 1](/13-kubernetes-config-04-helm/Labs/labs-exercise-01-v1.md)
- [Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Labs/labs-exercise-01-v2.md)

### Логи, из которых сделать ответ на Вопрос 1
[Логи отсюда](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Logs/logs6-helm-chart-fb-pod-app1-app2.md#%D0%BB%D0%BE%D0%B3-6-%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-1-%D0%BF%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%B8%D1%82%D1%8C-helm-%D1%87%D0%B0%D1%80%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D0%BD%D1%82-2)

#### Таблица версий чартов, приложений и образов
Версия Chart.yaml|Версия Application|namespace|Версия images|Log installation
|-|-|-|-|-|
[0.1.0](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%B5%D0%BC-%D1%87%D0%B0%D1%80%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-fb-pod-app1-appversion-050722)|fb-pod-app1|app2|05.07.22|
[0.1.0](https://github.com/zakharovnpa/04--devkub-homeworks-/edit/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%B5%D0%BC-%D1%87%D0%B0%D1%80%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-fb-pod-app1-appversion-120522)|fb-pod-app1|app|12.07.22|
[0.1.0](https://github.com/zakharovnpa/04--devkub-homeworks-/edit/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%B5%D0%BC-%D1%87%D0%B0%D1%80%D1%82-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-fb-pod-app2-appversion-120522)|fb-pod-app2|app|13.07.22|[fb-pod-app2](https://github.com/zakharovnpa/04--devkub-homeworks-/edit/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%D0%B0%D0%B5%D0%BC-%D0%B8%D0%BD%D1%81%D1%82%D0%B0%D0%BB%D0%BB%D1%8F%D1%86%D0%B8%D1%8E-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D1%8F-fb-pod-app2)

* Обрывки логов команды `helm install fb-pod-app1` при работе стартового скрипта
```
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
---
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
  namespace: app1
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
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app1/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
NAME: fb-pod-app1
LAST DEPLOYED: Sun Jul 31 13:29:01 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   0/2     Pending   0          0s
kubectl -n app1 get po
```
```
controlplane $ ls -l
total 8
drwxr-xr-x 4 root root 4096 Jul 31 13:29 fb-pod-app1
drwxr-xr-x 4 root root 4096 Jul 31 13:29 fb-pod-app2
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-pv.yaml
-rw-r--r-- 1 root root    0 Jul 31 13:29 stage-pvc.yaml
```

```
controlplane $ kubectl -n app1 get po,svc,deploy
NAME                               READY   STATUS              RESTARTS   AGE
pod/fb-pod-app1-6464948946-lljvq   0/2     ContainerCreating   0          25s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.107.178.87   <none>        80:30080/TCP   26s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   0/1     1            0           26s
```

```
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
```
* Результат инсталляции приложения.  
```
controlplane $ kubectl get po,svc,deploy
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0          58s

NAME                                        TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                                                     AGE
service/kubernetes                          ClusterIP   10.96.0.1      <none>        443/TCP                                                                                                     83d
service/nfs-server-nfs-server-provisioner   ClusterIP   10.102.92.84   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   58s
```

```
controlplane $ pwd                
/root/My-Project/stage
controlplane $ 
controlplane $ ls fb-pod-app1
Chart.yaml  charts  templates  values.yaml
controlplane $ 
controlplane $ cat fb-pod-app1/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.0"
```
##### Создаем чарт для приложения fb-pod-app1, appVersion: "05.07.22"
```
controlplane $ vi fb-pod-app1/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app1/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)
##### Создаем чарт для приложения fb-pod-app1, appVersion: "12.05.22"
```
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.05.22"
```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)
##### Создаем чарт для приложения fb-pod-app2, appVersion: "12.05.22"
```
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.05.22"
```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)

##### Создаем файл с переменными values.yaml для приложения fb-pod-app1, appVersion: "05.07.22", namespace: app1
```
controlplane $ cat fb-pod-app1/values.yaml  

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)

##### Создаем файл с переменными values.yaml для приложения fb-pod-app2, appVersion: "05.07.22", namespace: app1
```
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)

##### Создаем файл с переменными values.yaml для приложения fb-pod-app2, appVersion: "12.07.22", namespace: app1
```
controlplane $ vi fb-pod-app2/values.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22

```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)

#### Подготовка к инсталляции. Получаем текст манифестов, основанных на шаблонах
```
controlplane $ helm template fb-pod-app2
---
# Source: fb-pod-app2/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app2
  namespace: app1
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
---
# Source: fb-pod-app2/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app2
  namespace: app1
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
        - image: zakharovnpa/k8s-frontend:12.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:12.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app2/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
#### Запускаем инсталляцию приложения fb-pod-app2
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
NAME: fb-pod-app2
LAST DEPLOYED: Sun Jul 31 13:37:54 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
```
#### Приложение запустилось. В итоге поменяли версию Chart.yml и номер порта для сервиса на 30081
```
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS              RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   2/2     Running             0          9m10s
fb-pod-app2-6f45f8798b-fg4zq   0/2     ContainerCreating   0          17s
controlplane $ 
controlplane $ 
controlplane $ date
Sun Jul 31 13:40:40 UTC 2022
```
[Назад к таблице версий чартов](https://github.com/zakharovnpa/04--devkub-homeworks-/blob/main/13-kubernetes-config-04-helm/Lesson/Lesson.md#%D1%82%D0%B0%D0%B1%D0%BB%D0%B8%D1%86%D0%B0-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D0%B9-%D1%87%D0%B0%D1%80%D1%82%D0%BE%D0%B2-%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B9-%D0%B8-%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%BE%D0%B2)

```
controlplane $ v itoge pomenyali versiyu Chart.yml i nomer porta servisa na 30081
v: command not found
controlplane $ 
controlplane $ zapuskaem versiyu 13.07.22 v namespace app2
zapuskaem: command not found
```
#### Запускаем версию приложения 13.07.22 в namespace app2
```
controlplane $ date
Sun Jul 31 13:42:24 UTC 2022
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: "13.05.22"
```
##### Создаем файл с переменными values.yaml для приложения fb-pod-app2, appVersion: "13.05.22"
```
controlplane $ vi fb-pod-app2/values.yaml 
controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app2

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

```
##### Собираем шаблон для namespace app2 и образа версии 13.07.22
```
controlplane $ helm template fb-pod-app2
---
# Source: fb-pod-app2/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app2
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod
---
# Source: fb-pod-app2/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app2
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app2/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
##### Запускаем установку версии приложения с образом 13.07.22. Неуспешно. Причина - одинаковые настройки  NodePort
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ cp -r fb-pod-app2 fb-pod-app3
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod-app3/values.yaml 
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
```
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: Service "fb-pod-app3" is invalid: spec.ports[0].nodePort: Invalid value: 30081: provided port is already allocated
```
```
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30083
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```

```
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
```

```
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-lljvq   2/2     Running   0          21m
fb-pod-app2-6f45f8798b-fg4zq   0/2     Error     1          12m
fb-pod-app2-6f45f8798b-jvffr   2/2     Running   0          11m
```

```
controlplane $ kubectl -n app2 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app3-69fc56646b-jbx4w   0/2     ContainerStatusUnknown   2          66s
fb-pod-app3-69fc56646b-n7bxv   2/2     Running                  0          10s
```

```
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30085
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
##### Меняем номер порта сетевого сервиса во избежание ошибок при запуске
```
controlplane $ helm template --set nodePort=30088 fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30088
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```

```
controlplane $ cat fb-pod-app3/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

nodePort: 30085
```

```
controlplane $ cat fb-pod-app3/templates/service.yaml 

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.name }}
  namespace: {{ .Values.namespace }}
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: {{ .Values.nodePort }}
  selector:
    app: fb-pod

```

```
controlplane $ vi fb-pod-app3/templates/NOTES.txt 
```

```
controlplane $ helm template --set nodePort=30089 fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30089
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```

```
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS                   RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-jbx4w   0/2     ContainerStatusUnknown   2          27m
pod/fb-pod-app3-69fc56646b-n7bxv   2/2     Running                  0          26m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app3   1/1     1            1           27m
```

```
controlplane $ kubectl -n app2 delete pod fb-pod-app3-69fc56646b-jbx4w 
pod "fb-pod-app3-69fc56646b-jbx4w" deleted
controlplane $ 
controlplane $ kubectl -n app2 delete pod fb-pod-app3-69fc56646b-n7bxv 
pod "fb-pod-app3-69fc56646b-n7bxv" deleted
```

```
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-rvs95   2/2     Running   0          52s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app3   1/1     1            1           29m
```

```
controlplane $ kubectl -n app2 delete deployments.apps fb-pod-app3     
deployment.apps "fb-pod-app3" deleted
controlplane $
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          12s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          21s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          27s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-55rx2   2/2     Terminating   0          37s
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
```

```
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deploy
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30085
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```

```
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
```

```
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30085
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```

```
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: cannot re-use a name that is still in use

```

## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.

### Ход выполнения
Пояснения:
* другая версия - это о приложении. 
* нужно сделать три версии приложения
  * скорее всего придется отследить чтобы не было совпадения портов в разных версиях приложения 


- [Лог 4. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs4-helm-chart-fb-pod-app1-app2.md)

#### Выполнение задания 2
```
Sat Jul 30 19:03:55 UTC 2022
/root/My-Project/stage
```
* Создание деплоя
```
helm creating f-pod
Creating fb-pod
```
* Показаны конфигурационные файлы
```yml
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
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
```yml
---
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: app1
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
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
```
```ps
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
NAME: fb-pod-app1
LAST DEPLOYED: Sat Jul 30 19:03:56 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-tsp4f   0/2     Pending   0          0s
kubectl -n app1 get po
```

* После изменения версии образа приложения с "05.07.22" на "13.07.22" создаем новые объекты для деплоя в окружении "app1"
```
controlplane $ helm template fb-pod
```
```yml
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
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
```yml
---
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: app1
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
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
* Создаем копию каталога "fb-pod" для запуска его в том же окружении "app1" под другим менем "fb-pod-app2"
```
controlplane $ cp -r fb-pod fb-pod-app2
```
* Собираем приложение с версией образа "13.07.22" под именем "fb-pod-app2" для установки в окружении "app1"
```
controlplane $ helm template fb-pod-app2
```
```yml
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app1
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod
```
```yml
---
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: app1
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
* Неуспешная попытка апгрейда приложения с версией "05.07.22", запущенного в окружении "app1" на версию "13.07.22". Helm не считает изменение версии образа причиной для апгрейда работающего приложения
```
controlplane $ helm upgrade fb-pod fb-pod
Error: UPGRADE FAILED: "fb-pod" has no deployed releases
```
* Запущенные деплои и поды в среде "app1"
```
controlplane $ kubectl -n app1 get deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           9m21s
controlplane $ 
controlplane $ kubectl -n app1 get pod   
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-tsp4f   2/2     Running   0          9m26s
```
* Неуспешная попытка инсталяции приложения с другой версии образа и под другим именем "fb-pod-app2" в среде "app1" рядом с первой версией приложения
```
controlplane $ helm install fb-pod-app2 fb-pod-app2 
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
```
* Переменные для первой версии приложения
```
controlplane $ cat fb-pod/values.yaml 
```
```yml

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

```
* Переменные для второй версии приложения
```
controlplane $ cat fb-pod-app2/values.yaml 
```
```yml

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

```
* Файл чарта для первой версии приложения
```
controlplane $ cat fb-pod/Chart.yaml   
```
```ps
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes

type: application
version: 0.1.0
appVersion: "05.07.22"
```
```
controlplane $ cat fb-pod-app2/Chart.yaml 
```
* Файл чарта для второй версии приложения
```ps
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes

type: application
version: 0.1.0
appVersion: "13.07.22"
```
* Собираем вторую версию приложения "13.07.22" для инсталляции в окружение "app2"
```
controlplane $ helm template fb-pod-app2 
```
```yml
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod
```
```yml
---
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: /tmp/cache
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
```
```
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
* Успешная инсталляция второй версии приложения "13.07.22" в окружении "app2"
```
controlplane $ helm install fb-po-app2 fb-pod-app2 
NAME: fb-po-app2
LAST DEPLOYED: Sat Jul 30 19:18:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 

---------------------------------------------------------
```
* Результат инсталляции первой версии приложения "05.07.22" в окружение "app1"
```
controlplane $ kubectl -n app1 get po,svc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6464948946-tsp4f   2/2     Running   0          15m

NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.97.166.222   <none>        80:30080/TCP   15m
controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22
controlplane $ 
```
* Результат инсталляции второй версии приложения "13.07.22" в окружение "app2"
```
controlplane $ kubectl -n app2 get po,svc
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-69fc56646b-w5qbq   2/2     Running   0          42s

NAME             TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.105.126.146   <none>        80:30081/TCP   42s
controlplane $ 
controlplane $ kubectl -n app2 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
```
```
controlplane $ cat fb-pod-app2/values.yaml 
```
```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22

```
```
controlplane $ cat fb-pod/values.yaml 
```
```yml

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
```
- [Лог 7. Задание 1, вопрос 2 часть-3. Неуспешная установка `fb-pod-app3` в окружение `app1` и потом успешная установка в окружение `app2` ](/13-kubernetes-config-04-helm/Logs/logs7-helm-chart-fb-pod-app1-app2.md)

- [Лог 8. Задание 1, вопрос 2, часть 2. Успешная установка `fb-pod-app2` в окружение `app1`](/13-kubernetes-config-04-helm/Logs/logs8-helm-chart-fb-pod-app1-app2.md)

## Задание 3 (*): повторить упаковку на jsonnet
Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.

### Ход выполнения
Пояснения:

Выполнене идет здесь:
- [Задание 3(*): Работа с Jsonnet. Вариант 1](/13-kubernetes-config-04-helm/Labs/labs-jsonnet-01-v1.md)
- [Задание 3(*): Работа с Jsonnet. Создание из файла jsonnet шаблона jsonnet для создания манифестов. Группировка по объектам и категорям](/13-kubernetes-config-04-helm/Labs/labs-jsonnet-02-v1.md)

### Решение Задания №3.
Успешная попытка конвертировать в формат json готовые манифесты, подготовленные для разворачвания приложения но основе чарта Helm.
- [ЛР-4. Создание файлов в формате json из готовых манфестов чарта Helm.](/13-kubernetes-config-04-helm/Labs/labs-create-file-json-from-manifest.md)

Успешная попытка инсталляци приложения через чарт Helm
- [ЛР-5. Инсталляция из конвертрованных манфестов чарта Helm.](/13-kubernetes-config-04-helm/Labs/labs-install-helm-from-convert-manifest.md)
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
