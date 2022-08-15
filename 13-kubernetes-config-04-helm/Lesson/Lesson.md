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
