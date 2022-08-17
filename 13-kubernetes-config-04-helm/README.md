# Домашнее задание к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet" - Захаров Сергей Николаевич
В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения
Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:
* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
* в переменных чарта измените образ приложения для изменения версии.


## Ход выполнения ДЗ вопрос 1

[Скрипт разворачиввания окружения и запуска приложения в app1](/13-kubernetes-config-04-helm/Files/start-script.sh)

* Tab 1
```
Tue Aug 16 17:36:29 UTC 2022
/root/My-Project/stage
```
* Резульат выполнения команды `helm install fb-pod-app1 fb-pod-app1`
```
Creating fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
LAST DEPLOYED: Tue Aug 16 17:36:30 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------

```
* В неймспейс app1 запустились деплоймент, под и сервис:
```
controlplane $ kubectl -n app1 get deployments.apps,pod,svc
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           93s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-t7g74   2/2     Running   0          93s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.99.80.142   <none>        80:30080/TCP   93s
```
* в неймспейс app2 пока ничего не запущено:
```
controlplane $ kubectl -n app2 get deployments.apps,pod,svc
No resources found in app2 namespace.
```
* Определяем рабочий каталог. Для дальнейших действий надо находиться в каталоге, на уровень выше каталога с чартом Helm,
```
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ tree
.
|-- fb-pod-app1
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- deployment.yaml
|   |   `-- service.yaml
|   `-- values.yaml
|-- fb-pod-app2
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- deployment.yaml
|   |   `-- service.yaml
|   `-- values.yaml
|-- fb-pod-app3
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- NOTES.txt
|   |   |-- deployment.yaml
|   |   `-- service.yaml
|   `-- values.yaml
|-- stage-front-back.yaml
|-- stage-pv.yaml
`-- stage-pvc.yaml

9 directories, 18 files
```
* Попытка развернуть приложение в том же самом неймспейс app1.
* Собираем из шаблонов манифесты деплоя с именем fb-pod-app1, неймспейс app1. Замечаний у Kubernetes на этом этапе нет.
```
controlplane $ helm template fb-pod-app1 fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
```
* Установка того же самого приложения в тот же неймспейс app1 неуспешная. Причина неудачи - имя деплоя уже используется в рамках этого кластера.
```
controlplane $ helm install fb-pod-app1 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
```

* Устанавливаем приложение в неймспейс app2 с помощью деплоя с другим именем и с другим портом nodePort
```
controlplane $ helm install fb-pod-app1-v2 fb-pod-app1 --set namespace=app2 --set nodePort=30082
NAME: fb-pod-app1-v2
LAST DEPLOYED: Tue Aug 16 17:44:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app2 namespace. 
nodePort is port= 30082.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------
```
* Запущенное приложение в namespace app1
```

controlplane $ kubectl -n app1 get deployments.apps,pod,svc
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           13m

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-t7g74   2/2     Running   0          13m

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.99.80.142   <none>        80:30080/TCP   13m
```
* Запущенное приложение в namespace app2
```
controlplane $ kubectl -n app2 get deployments.apps,pod,svc
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           4m57s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-pxbsr   2/2     Running   0          4m57s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.99.240.179   <none>        80:30082/TCP   4m57s
```
### Ответ: запустили тоже самое приложение в том же самом неймспейс, но для этого необходимо изменить имя деплоя и номер порта в nodePort сетевого сервиса.

## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.


### Пояснения:
* другая версия - это о приложении. 
* нужно сделать три версии приложения
  * необходимо отследить чтобы в разных версиях приложения не было совпадения портов, которые слушают севисы 


- [Лог 4. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs4-helm-chart-fb-pod-app1-app2.md)

#### Ход выполнения задания 2
```
Sat Jul 30 19:03:55 UTC 2022
/root/My-Project/stage
```
##### Создание деплоя c 
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


## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.

### Выполнение задания 2

#### Таблица распределения версий инстансов приложений по неймспейсам 

Chart ver.|App Name|NS|Image tag
|-|-|-|-|
0.1.0|fb-pod-app1|app1|05.07.22
0.2.0|fb-pod-app1-v2|app1|12.07.22
0.3.1|fb-pod-app1-v3|app2|13.07.22

#### 1. Создание деплоя. При этом создаются директория и файлы манифесты приложения
```
Wed Aug 17 13:04:37 UTC 2022
/root/My-Project/stage
Creating fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
LAST DEPLOYED: Wed Aug 17 13:04:39 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.

---------------------------------------------------------
```
* Результат: смотри описание файла NOTES.txt
  * в неймспейс app1
  * задеплоили приложение fb-pod-app1
  * с вресией образа 05.07.22
  * 1 реплика
  

```sh
Deployed to app1 namespace. 
nodePort is port= 30080.
Application name=fb-pod-app1.
Image tag: 05.07.22.
ReplicaCount: 1.
```

#### Согласно заданию меняем версию приложения (image) с "05.07.22" на "12.07.22"
* Порядок смены версии:
  * В volues.yaml - меняем image.tag:12.07.22, nodePort: 30081
```sh
replicaCount: 1
name: fb-pod-app2
namespace: app1
image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30081
```  
  * В Charts.yaml - меняем version: 0.2.0, appVersion: 12.07.22, 
```sh

apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: 12.07.22
```
#### Тестируем сборку менифестов из шаблонов

```
controlplane $ pwd
/root/My-Project/stage/fb-pod-app2
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app2
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
#### Деплой второй версии приложения завершился с ошибкой
```
controlplane $ helm install fb-pod-app1 fb-pod-app2
Error: INSTALLATION FAILED: cannot re-use a name that is still in use    
```
### Снова меняем имя деплоя приложения на fb-pod-app1-v2
```
controlplane $ cat fb-pod-app2/Chart.yaml 

apiVersion: v2
name: fb-pod-app1-v2
description: A Helm chart for Kubernetes
type: application
version: 0.2.0
appVersion: 12.07.22

controlplane $ 
controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1-v2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 12.07.22
nodePort: 30081

```
### Успешный деплой второй версии приложения в первый неймспекйс app1
```
controlplane $ helm install fb-pod-app2 fb-pod-app2             
NAME: fb-pod-app2
LAST DEPLOYED: Wed Aug 17 13:39:03 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30081.
Application name=fb-pod-app1-v2.
Image tag: 12.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
```
### Ответ: установлена вторая версия приложения в первый неймспейс

### Готовим третью версию приложения для деплоя в неймспейс app2

#### Меняем файлы
* Порядок смены версии:
 * В Charts.yaml - меняем version: 0.3.0, appVersion: 13.07.22, 


```
controlplane $ cat Chart.yaml 

apiVersion: v2
name: fb-pod-app1-v3
description: A Helm chart for Kubernetes
type: application
version: 0.3.0
appVersion: 13.07.22

```
  * В volues.yaml - меняем image.tag:13.07.22, nodePort: 30082
```
controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1-v3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22
nodePort: 30082

```
#### Проверяем манифесты
```
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3   
Error: failed to download "fb-pod-app3"
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app3
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod-app1-v3 fb-pod-app3
---
# Source: fb-pod-app1-v3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1-v3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30082
  selector:
    app: fb-pod
---
# Source: fb-pod-app1-v3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1-v3
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
# Source: fb-pod-app1-v3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
### Деплоим
```
controlplane $ helm install fb-pod-app1-v3 fb-pod-app3
NAME: fb-pod-app1-v3
LAST DEPLOYED: Wed Aug 17 13:53:44 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app2 namespace. 
nodePort is port= 30082.
Application name=fb-pod-app1-v3.
Image tag: 13.07.22.
ReplicaCount: 1.

---------------------------------------------------------
```
### Результат: установлены в разных неймспецйс разные версии приложения
```
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1      1/1     1            1           49m
deployment.apps/fb-pod-app1-v2   1/1     1            1           15m

NAME                                  READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-cnlzt      2/2     Running   0          49m
pod/fb-pod-app1-v2-6f45f8798b-z5kdr   2/2     Running   0          15m

NAME                     TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1      NodePort   10.99.225.5      <none>        80:30080/TCP   49m
service/fb-pod-app1-v2   NodePort   10.111.224.177   <none>        80:30081/TCP   15m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1-v3   1/1     1            1           38s

NAME                                  READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-v3-69fc56646b-jthng   2/2     Running   0          38s

NAME                     TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1-v3   NodePort   10.98.66.157   <none>        80:30082/TCP   38s
```

### Ответ: приложения установены.





## Задание 3 (*): повторить упаковку на jsonnet
Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
