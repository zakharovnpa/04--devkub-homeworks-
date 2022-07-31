## Лог 5. Задание 1: подготовить helm чарт для приложения. Вариант 2

#### Анализ действий. Успешная становка другой версии приложения в одном и том же окружении, но под ругим именем самого приложения.
```
Sun Jul 31 11:20:47 UTC 2022
/root/My-Project/stage
Creating fb-pod
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
NAME: fb-pod-app1
LAST DEPLOYED: Sun Jul 31 11:20:48 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
No resources found in app1 namespace.
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po,svc,deploy
NAME                          READY   STATUS    RESTARTS   AGE
pod/fb-pod-6464948946-g42f7   2/2     Running   0          52s

NAME             TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod   NodePort   10.111.198.183   <none>        80:30080/TCP   53s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod   1/1     1            1           53s
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ ls -l
total 4
drwxr-xr-x 4 root root 4096 Jul 31 11:20 fb-pod
-rw-r--r-- 1 root root    0 Jul 31 11:20 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Jul 31 11:20 stage-pv.yaml
-rw-r--r-- 1 root root    0 Jul 31 11:20 stage-pvc.yaml
controlplane $ 
controlplane $ cp -r fb-pod fb-pod-app2
controlplane $ 
controlplane $ cd fb-pod-app2/
controlplane $ 
controlplane $ ls -l
total 16
-rw-r--r-- 1 root root 1142 Jul 31 11:22 Chart.yaml
drwxr-xr-x 2 root root 4096 Jul 31 11:22 charts
drwxr-xr-x 2 root root 4096 Jul 31 11:22 templates
-rw-r--r-- 1 root root  254 Jul 31 11:22 values.yaml
controlplane $ 
controlplane $ cat Chart.yaml 
apiVersion: v2
name: fb-pod
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
controlplane $ 
controlplane $ vi Chart.yaml 
controlplane $ vi Chart.yaml 
controlplane $ 
controlplane $ cat Chart.yaml 
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
controlplane $ 
controlplane $ vi values.yaml 
```
```yml
# controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
```
```
controlplane $ vi templates/deployment.yaml 
```
```yml
# controlplane $ cat templates/deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }} 
  namespace: {{ .Values.namespace }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}
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
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app2
controlplane $ 
controlplane $ cd ../fb-pod
controlplane $ 
controlplane $ vi Chart.yaml 
```
```yml
# controlplane $ cat Chart.yaml 
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
controlplane $ 
controlplane $ vi values.yaml 
```
```yml
# controlplane $ cat values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

```
```
controlplane $ vi templates/deployment.yaml 
```
* Исправленный файл `templates/deployment.yaml`
```yml
# controlplane $ cat templates/deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: {{ .Values.name }} 
  namespace: {{ .Values.namespace }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: {{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}
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
controlplane $ vi templates/service.yaml 
```
* Исправленный файл `templates/service.yaml`
```yml
# controlplane $ cat templates/service.yaml 

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
    nodePort: 30080
  selector:
    app: fb-pod
```
```
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod
controlplane $ 
controlplane $ cd ../fb-pod-app2/
controlplane $ 
controlplane $ vi templates/service.yaml 
controlplane $ 
controlplane $ 
controlplane $ date
Sun Jul 31 11:30:47 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app2
controlplane $ 
controlplane $ helm template --set name=fb-pod-app2 fb-pod-app2
Error: failed to download "fb-pod-app2"
```
* Переходим на 1 уровень каталогов выше
```
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
```
* Сборка объектов с пререопределением имени приложения с "fb-pod" на "fb-pod-app2"
```yml
# controlplane $ helm template --set name=fb-pod-app2 fb-pod-app2
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app2     # имя переопределено
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
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app2      # имя переопределено
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
* Запущенный скриптом при старте pod в окружении "app1"
```
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-g42f7   2/2     Running   0          16m
```
* Неуспешная установка приложения под другим именем "fb-pod-app2" в окружении "app1"
```
controlplane $ helm install fb-pod-app2 fb-pod-app2 
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
```
* Запускаем создание объектов с переопределением окружения на "app2"
```yml
# controlplane $ helm template --set namespace=app2 fb-pod-app2
---
# Source: fb-pod/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: app2   # окружение переопределилось
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
# Source: fb-pod/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: app2    # окружение переопределилось
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
* Неуспешная попытка установки (не отредактирован файл чарта Chart.yml)
```ps
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
controlplane $ 
```
* редакрируем чарт
```
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ cd fb-pod-app2/
controlplane $ 
controlplane $ vi Chart.yaml 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod-app2
controlplane $ 
controlplane $ vi Chart.yaml 
```
* Неуспешная команда запуска установки (неверный контекст запуска)
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: failed to download "fb-pod-app2"
```
* Поднимаемся выше на один уровень
```
controlplane $ cd ..
```
* Неуспешная попытка установки 
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
```
* Неуспешная попытка установки с переопределением тега (неверная команда --set tag=13.07.22)
```
controlplane $ helm install --set tag=13.07.22 fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
controlplane $ 
```
* Неуспешное переопределение тега приложения при сборке объекта (неверная команда --set tag=13.07.22)
```yml
# controlplane $ helm template --set tag=13.07.22 fb-pod-app2            
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
        - image: zakharovnpa/k8s-frontend:05.07.22  # тег не переопределился
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22  # тег не переопределился
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
* Успешное переопределение тега приложения при сборке объекта 
```yml
# controlplane $ helm template --set image.tag=13.07.22 fb-pod-app2
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
        - image: zakharovnpa/k8s-frontend:13.07.22    # тег переопределился
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: /static
              name: my-volume
        - image: zakharovnpa/k8s-backend:13.07.22    # тег переопределился
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
* Попытка установки разных версий приложения под одним и тем же именем "fb-pod", в одно окружение "app1"
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
```
```
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
```

```yml
#controlplane $ cat fb-pod/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
```

```yml
#controlplane $ cat fb-pod-app2/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

```
```yml
#controlplane $ cat fb-pod/Chart.yaml   
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
```
```yml
#controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "13.07.22"
controlplane $ 
```
```
controlplane $ vi fb-pod-app2/values.yaml 
```
```yml
#controlplane $ cat fb-pod-app2/values.yaml

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
```
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
```
* В окружении "app1" запущен под
```
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-g42f7   2/2     Running   0          56m
```
* В окружении "app2" ничего не установлено
```
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
```
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
# Source: fb-pod/templates/deployment.yaml
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
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: Service "fb-pod-app2" is invalid: spec.ports[0].nodePort: Invalid value: 30080: provided port is already allocated
controlplane $ 
controlplane $ helm template fb-pod-app2
---
# Source: fb-pod/templates/service.yaml
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
    nodePort: 30081
  selector:
    app: fb-pod
---
# Source: fb-pod/templates/deployment.yaml
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
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
```
* Вторая попытка установки неуспешная, не проверив, что при первой попытке приложение установилось, но была ошибка в неуникальности порта сетевого сервиса
```
controlplane $ helm install fb-pod-app2 fb-pod-app2
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
```
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
```
* Обе версии приложения установлены в одном окружкении "app1"
```
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-g42f7        2/2     Running   0          58m
fb-pod-app2-6f45f8798b-rdxfz   2/2     Running   0          61s
controlplane $ 
controlplane $ 

```
