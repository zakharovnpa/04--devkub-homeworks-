## Лог 9. Выполнение ДЗ вопрос 1

### Запущено приложение fv-pod-app1 в namespace app1
```
controlplane $ kubectl -n app1 get po,deployments.apps,svc
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-5nv5v   2/2     Running   0          22m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           22m

NAME                  TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.111.185.152   <none>        80:30080/TCP   22m
```

### Запускаем приложение fv-pod-app1 в namespace app2      
#### Меняем неймспейс в файле value

* Первоначальный файл fb-pod-app1/values.yaml 
```yml

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1

namespace: app1   # Namespace

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
nodePort: 30080

```
* Измененный файл fb-pod-app1/values.yaml 
```
controlplane $ cat fb-pod-app1/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1

namespace: app2     # Namespace

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
nodePort: 30080

```
* Проверяем манифесты
```
controlplane $ helm template fb-pod-app1 fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
  namespace: app2
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
* Запускаем установку приложения в namespace app2. Установить тоже смое приложение в namespace app2 не удалось, т.к. нельзя повторно использовать имя приложения, которое еще работает.
```
controlplane $ helm install fb-pod-app1 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
```
* Меняем имя приложения на fb-pod-app1-v2. Опять ошибка. На этот раз порты сетевых служб совпадают.
```
controlplane $ helm install fb-pod-app1-v2 fb-pod-app1
Error: INSTALLATION FAILED: Service "fb-pod-app1" is invalid: spec.ports[0].nodePort: Invalid value: 30080: provided port is already allocated
```

* При удалении с помощью helm надо указывать только имя деплоя (без указания имени дирекотрии чарта), иначе можно удалить лишнее, как здесь:
```
controlplane $ helm delete fb-pod-app1-v2 fb-pod-app1
release "fb-pod-app1-v2" uninstalled
release "fb-pod-app1" uninstalled
```
```
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app1-6464948946-vffk5   2/2     Terminating   0          11m
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
No resources found in app2 namespace.
```
* Разобрать логи
```
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set nodePort=30082
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
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
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1 --set nodePort=30082
NAME: fb-pod-app1
LAST DEPLOYED: Tue Aug 16 17:11:53 2022
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
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           16s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-m2b4d   2/2     Running   0          16s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.97.224.84   <none>        80:30082/TCP   16s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc 
No resources found in app1 namespace.
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
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
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ helm install fb-pod-app1-v1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
NAME: fb-pod-app1-v1
LAST DEPLOYED: Tue Aug 16 17:14:05 2022
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
controlplane $ 
```

* Меняем при инсталляции имя деплоймента на fb-pod-app1-v1

```
controlplane $ helm install fb-pod-app1-v1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
NAME: fb-pod-app1-v1
LAST DEPLOYED: Tue Aug 16 17:14:05 2022
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
controlplane $ 
```




* Приложение можно установить в разных неймспейсах при условии разных имен деплойментов и разных nodeport сетевых сервисов
```
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           2m19s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-m2b4d   2/2     Running   0          2m19s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.97.224.84   <none>        80:30082/TCP   2m19s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           16s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-6k5ll   2/2     Running   0          16s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.110.79.193   <none>        80:30080/TCP   16s
```

### Ход выполнения (полные логи)
```
Tue Aug 16 16:22:22 UTC 2022
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
LAST DEPLOYED: Tue Aug 16 16:22:23 2022
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
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-5nv5v   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-5nv5v   2/2     Running   0          30s
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ 
controlplane $ 1. Change namespace in file Values.yaml
1.: command not found
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
controlplane $ 
controlplane $ 1. Change namespace in file fb-pod-app1/Values.yaml
1.: command not found
controlplane $ 
controlplane $ vi fb-pod-app1/values.yaml 
controlplane $ 
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
nodePort: 30080

controlplane $ 
controlplane $ vi fb-pod-app1/values.yaml 
controlplane $ 
controlplane $ cat fb-pod-app1/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app1

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22
nodePort: 30080

controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-5nv5v   2/2     Running   0          9m36s
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ 2. Install application in ns app22.: command not foundcontrolplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ ls -l
total 12
drwxr-xr-x 4 root root 4096 Aug 16 16:30 fb-pod-app1
drwxr-xr-x 4 root root 4096 Aug 16 16:22 fb-pod-app2
drwxr-xr-x 4 root root 4096 Aug 16 16:22 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-pvc.yaml
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
  namespace: app2
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
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po,deployments.apps,svc
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-5nv5v   2/2     Running   0          22m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           22m

NAME                  TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.111.185.152   <none>        80:30080/TCP   22m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane 
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 5 root root 4.0K Aug 16 16:22 .
drwxr-xr-x 5 root root 4.0K Aug 16 16:22 ..
drwxr-xr-x 4 root root 4.0K Aug 16 16:30 fb-pod-app1
drwxr-xr-x 4 root root 4.0K Aug 16 16:22 fb-pod-app2
drwxr-xr-x 4 root root 4.0K Aug 16 16:22 fb-pod-app3
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-front-back.yaml
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-pv.yaml
-rw-r--r-- 1 root root    0 Aug 16 16:22 stage-pvc.yaml
controlplane $ 
controlplane $ cd fb-pod-app1
controlplane $ 
controlplane $ ls -lha
total 28K
drwxr-xr-x 4 root root 4.0K Aug 16 16:30 .
drwxr-xr-x 5 root root 4.0K Aug 16 16:22 ..
-rw-r--r-- 1 root root  349 Aug 16 16:22 .helmignore
-rw-r--r-- 1 root root 1.2K Aug 16 16:22 Chart.yaml
drwxr-xr-x 2 root root 4.0K Aug 16 16:22 charts
drwxr-xr-x 2 root root 4.0K Aug 16 16:22 templates
-rw-r--r-- 1 root root  289 Aug 16 16:30 values.yaml
controlplane $ 
controlplane $ cat Chart.yaml 
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
controlplane $ 
controlplane $ vim Chart.yaml 
controlplane $ 
controlplane $ cat Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1
Error: failed to download "fb-pod-app1"
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
  namespace: app2
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
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ helm install fb-pod-app1-v2 fb-pod-app1
Error: INSTALLATION FAILED: Service "fb-pod-app1" is invalid: spec.ports[0].nodePort: Invalid value: 30080: provided port is already allocated
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set=nodePort:30082
Error: failed parsing --set data: key "nodePort:30082" has no value
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set nodePort=30082
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
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
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app1-v2 fb-pod-app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-vffk5   2/2     Running   0          7m26s
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   1/1     1            1           7m43s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod-app1   1/1     1            1           44m
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           46m

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-5nv5v   2/2     Running   0          46m

NAME                  TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.111.185.152   <none>        80:30080/TCP   46m
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           9m43s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-vffk5   2/2     Running   0          9m43s
controlplane $ 
controlplane $ helm delete fb-pod-app1-v2 fb-pod-app1
release "fb-pod-app1-v2" uninstalled
release "fb-pod-app1" uninstalled
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app1-6464948946-vffk5   2/2     Terminating   0          11m
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                               READY   STATUS        RESTARTS   AGE
pod/fb-pod-app1-6464948946-vffk5   2/2     Terminating   0          11m
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
No resources found in app2 namespace.
controlplane $ 
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1                     
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
  namespace: app2
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
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set nodePort=30082
---
# Source: fb-pod-app1/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app1
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
# Source: fb-pod-app1/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app1
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
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1 --set nodePort=30082
NAME: fb-pod-app1
LAST DEPLOYED: Tue Aug 16 17:11:53 2022
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
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           16s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-m2b4d   2/2     Running   0          16s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.97.224.84   <none>        80:30082/TCP   16s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc 
No resources found in app1 namespace.
controlplane $ 
controlplane $ helm template fb-pod-app1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
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
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ helm install fb-pod-app1-v1 fb-pod-app1 --set nodePort=30080 --set namespace=app1
NAME: fb-pod-app1-v1
LAST DEPLOYED: Tue Aug 16 17:14:05 2022
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
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           2m19s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-m2b4d   2/2     Running   0          2m19s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.97.224.84   <none>        80:30082/TCP   2m19s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps,pod,svc 
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           16s

NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-6k5ll   2/2     Running   0          16s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.110.79.193   <none>        80:30080/TCP   16s
controlplane $ 
controlplane $ 
controlplane $ 
```
