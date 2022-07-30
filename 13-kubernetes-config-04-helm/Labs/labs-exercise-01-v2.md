## Задание 1: подготовить helm чарт для приложения. Вариант 2

> Задача: для приложения создать 
#### Установка Helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
./get_helm.sh
```
#### Скрипт разворачивания окружения

* Устанавливаем Helm
* Включаем автодополнение для Helm
* Добавляем репозиторий чартов stable
* Добавляем репозиторий чартов prometheus-community
* Устанавливаем nfs-server
* Устанавливаем mc
* Создаем namespace stage
* Создаем namespace app1
* Создаем namespace app2
* Создаем директорию проекта My-Procect/stage с пустыми файлами
* Создаем чарт chart01
* Деплоим alertmanager
* Деплоим nginx-ingress

```ps
date && \
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
helm repo add stable https://charts.helm.sh/stable && \
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
helm repo update && \
helm install nfs-server stable/nfs-server-provisioner && \
apt install nfs-common -y && \
helm completion bash > /etc/bash_completion.d/helm && \
apt install mc -y && \
apt install tree && \
kubectl create namespace stage && \
kubectl create namespace app1 && \
kubectl create namespace app2 && \
mkdir -p My-Project/stage && \
mkdir -p My-Project/app1 && \
mkdir -p My-Project/app2 && \
cd My-Project/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
cd ../app1 && \
touch app1-pv.yaml app1-pvc.yaml app1-front-back.yaml && \
cd ../app2 && \
touch app2-pv.yaml app2-pvc.yaml app2-front.yaml app2-back.yaml && \
cd ../stage && \
clear && \
date && \
pwd && \
helm create fb-pod && \
cd fb-pod && \
rm values.yaml && \
touch values.yaml && \
echo "" > values.yaml && \
cd templates && \
rm -r * && \
touch NOTES.txt deployment.yaml service.yaml && \
echo "--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to {{ .Values.namespace }} namespace. 

---------------------------------------------------------" > NOTES.txt && \
echo "
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
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
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
" > deployment.yaml && \
echo "
---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
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
" > service.yaml && \
cd .. && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
" > values.yaml && \
cd .. && \
helm template fb-pod && \
helm install fb-pod-app1 fb-pod && \
kubectl -n app1 get po && \
echo "kubectl -n app1 get po"
```

```
echo "
---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
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
" > test-1.txt
```
```
helm create chart01 && \
ls -lha && \
cd chart01 && \
tree && \
cd charts && \
helm pull prometheus-community/alertmanager && \
helm pull stable/nginx-ingress && \
tar -zxvf alertmanager-0.19.0.tgz && \
tar -xvzf nginx-ingress-1.41.3.tgz && \
cd alertmanager && \
helm install alertmanager prometheus-community/alertmanager && \
cd ../nginx-ingress && \
helm install nginx-ingress stable/nginx-ingress && \
kubectl get po && \
```

### Как устанавливать приложения в разные namespace
1. Изменить namespace в файле values.yml
2. Отследить уникальность портов сетевых сервисов при создании копий деплоя
3. Изменить версию чарта в файле Chart.yaml
4. Собрать приложение `helm template fb-pod`
5. Установить приложение поод другим именем `helm install fb-pod-app1 fb-pod`


### Исподьзуемые манифесты

#### Notes.txt
```
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
```

#### файл шаблона `service.yaml`
```yml
---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
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
#### файл шаблона `deployment.yaml`

```yml
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
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
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
```
#### файл шаблона `values.yaml`

```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
```

###  Ход выполнения

#### Команды

```
echo 
```

### Логи - 3

```
Sat Jul 30 17:50:20 UTC 2022
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
LAST DEPLOYED: Sat Jul 30 17:50:21 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-vbt5v   0/2     ContainerCreating   0          0s
kubectl -n app1 get po
controlplane $ date && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && helm repo add stable https://charts.helm.sh/stable && helm repo add prometheus-community https://prometheus-community.githcontrolplane $ controlplane $ kubectl -n app1 get poNAME                      READY   STATUS    RESTARTS   AGEfb-pod-6464948946-vbt5v   2/2     Running   0          56s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          96s
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ helm template fb-pod 
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
controlplane $ 
controlplane $ vi fb-pod/templates/service.yaml 
controlplane $ 
controlplane $ helm template fb-pod
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
controlplane $ 
controlplane $ helm install fb-pod-2 fb-pod
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-2": current value is "fb-pod-app1"
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          5m45s
controlplane $ 
controlplane $ kubectl -n app1 get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           6m59s
controlplane $ 
controlplane $ helm lint fb-pod-2 fb-pod
==> Linting fb-pod-2
Error unable to check Chart.yaml file in chart: stat fb-pod-2/Chart.yaml: no such file or directory

==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

Error: 2 chart(s) linted, 1 chart(s) failed
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm lint fb-pod fb-pod
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

2 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm lint fb-pod       
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          22m
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ helm template fb-pod
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
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
NAME: fb-pod-app2
LAST DEPLOYED: Sat Jul 30 18:15:33 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-vbt5v   2/2     Running   0          25m
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-69fc56646b-sfbpj   0/2     ContainerCreating   0          18s
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-69fc56646b-5wrxl   2/2     Running                  0          6m13s
fb-pod-69fc56646b-sfbpj   0/2     ContainerStatusUnknown   2          7m14s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 logs fb-pod-69fc56646b-sfbpj 
Defaulted container "frontend" out of: frontend, backend
Error from server (BadRequest): container "frontend" in pod "fb-pod-69fc56646b-sfbpj" is terminated
controlplane $ 
controlplane $ kubectl -n app2 logs fb-pod-69fc56646b-5wrxl 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/30 18:16:36 [notice] 1#1: using the "epoll" event method
2022/07/30 18:16:36 [notice] 1#1: nginx/1.23.0
2022/07/30 18:16:36 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/30 18:16:36 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/30 18:16:36 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/30 18:16:36 [notice] 1#1: start worker processes
2022/07/30 18:16:36 [notice] 1#1: start worker process 29
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/Chart.yaml 
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
version: 0.3.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# It is recommended to use it with quotes.
appVersion: "1.16.13"
controlplane $ 
controlplane $ cat fb-pod/values.yaml 

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

controlplane $ 
controlplane $ cat fb-pod/templates/deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
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

controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/templates/service.yaml    

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: {{ .Values.namespace }}
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30081
  selector:
    app: fb-pod

controlplane $ 
controlplane $ kubectl -n app1 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
controlplane $ 
```


### Логи - 2
```
Sat Jul 30 16:15:29 UTC 2022
/root/My-Project/stage
Creating fb-pod
---
# Source: fb-pod/templates/service.yaml
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
---
# Source: fb-pod/templates/deployment.yaml
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
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 16:15:30 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to stage namespace. 

---------------------------------------------------------
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-n2hl8   0/2     ContainerCreating   0          0s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-n2hl8   2/2     Running   0          46s
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
app1              Active   8m31s
app2              Active   8m31s
default           Active   82d
kube-node-lease   Active   82d
kube-public       Active   82d
kube-system       Active   82d
stage             Active   8m31s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-n2hl8   2/2     Running   0          9m21s
controlplane $ 
controlplane $ kubectl -n app1 get po
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 16:26:02 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
No resources found in app1 namespace.
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-n2hl8   2/2     Running   0          10m
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 16:26:42 2022
NAMESPACE: default
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
No resources found in app1 namespace.
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod fb-pod 
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ ls                        
fb-pod  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml  
controlplane $ 
controlplane $ help template fb-pod
bash: help: no help topics match `fb-pod'.  Try `help help' or `man -k fb-pod' or `info fb-pod'.
controlplane $ 
controlplane $ helm template fb-pod
---
# Source: fb-pod/templates/service.yaml
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
---
# Source: fb-pod/templates/deployment.yaml
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
controlplane $ 
controlplane $ 
controlplane $ helm template --set namespace=app1 fb-pod
---
# Source: fb-pod/templates/service.yaml
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
---
# Source: fb-pod/templates/deployment.yaml
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
controlplane $ 
controlplane $ 
controlplane $ mc

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/mcedit
  4. /usr/bin/vim.tiny
  5. /bin/ed

Choose 1-5 [1]: 2               

controlplane $ 
controlplane $ helm template fb-pod
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
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod fb-pod
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod
Error: INSTALLATION FAILED: Service "fb-pod" is invalid: spec.ports[0].nodePort: Invalid value: 30080: provided port is already allocated
controlplane $ 
controlplane $ mc

controlplane $ 
controlplane $ helm install fb-pod-app1 fb-pod
Error: INSTALLATION FAILED: cannot re-use a name that is still in use
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-4js64   2/2     Running   0          2m31s
fb-pod-6464948946-888vc   0/2     Error     1          3m31s
controlplane $ 
controlplane $ 
controlplane $ helm template --set namespace=app2 fb-pod
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
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Deployment "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ ls
fb-pod  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ vi fb-pod/Chart.yaml 
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Deployment "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm template fb-pod-app2       
Error: failed to download "fb-pod-app2"
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm template fb-pod     
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
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Deployment "fb-pod" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app2": current value is "fb-pod-app1"
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-4js64   2/2     Running   0          13m
fb-pod-6464948946-888vc   0/2     Error     1          14m
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          38m
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-n2hl8   2/2     Running   0          38m
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-4js64   2/2     Running   0          16m
fb-pod-6464948946-888vc   0/2     Error     1          17m
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 05.07.22

controlplane $ 
controlplane $ helm template   
Error: "helm template" requires at least 1 argument

Usage:  helm template [NAME] [CHART] [flags]
controlplane $ 
controlplane $ helm template fb-pod 
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
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
NAME: fb-pod-app2
LAST DEPLOYED: Sat Jul 30 16:55:32 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-br4nl   0/2     ContainerCreating   0          8s
controlplane $ 
controlplane $ 
controlplane $ 
```
```
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod
NAME: fb-pod-app2
LAST DEPLOYED: Sat Jul 30 16:55:32 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-br4nl   0/2     ContainerCreating   0          8s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app2 get po
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6464948946-br4nl   0/2     ContainerStatusUnknown   2          13m
fb-pod-6464948946-dlg58   2/2     Running                  0          12m
controlplane $ 
controlplan
controlplane $ kubectl -n app2 logs fb-pod-6464948946-br4nl 
Defaulted container "frontend" out of: frontend, backend
Error from server (BadRequest): container "frontend" in pod "fb-pod-6464948946-br4nl" is terminated
controlplane $ 
controlplane $ kubectl -n app2 logs fb-pod-6464948946-dlg58 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/30 16:56:26 [notice] 1#1: using the "epoll" event method
2022/07/30 16:56:26 [notice] 1#1: nginx/1.23.0
2022/07/30 16:56:26 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/30 16:56:26 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/30 16:56:26 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/30 16:56:26 [notice] 1#1: start worker processes
2022/07/30 16:56:26 [notice] 1#1: start worker process 30
controlplane $ 
controlplane
controlplane
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ cat fb-pod/templates/deployment.yaml 

# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
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

controlplane $ 
controlplane $ cat fb-pod/templates/service.yaml    

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: {{ .Values.namespace }}
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

### Логи - 1

```
Sat Jul 30 15:26:15 UTC 2022
/root/My-Project/stage
Creating fb-pod
controlplane $ 
controlplane $ ls
NOTES.txt  deployment.yaml  service.yaml
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod/templates
controlplane $ 
controlplane $ vi service.yaml 
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ cat NOTES.txt 
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ cat service.yaml 
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
controlplane $ 

controlplane $ 
controlplane $ 
controlplane $ cat deployment.yaml 
# Config Deployment Frontend & Backend with Volume
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: "{{ .Values.replicaCount }}"
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_front }}:{{ .Values.image.tag }}"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "{{ .Values.image.repository }}/{{ .Values.image.name_back }}:{{ .Values.image.tag }}"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
controlplane $ 
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ ls
Chart.yaml  charts  templates
controlplane $ 
controlplane $ touch values.yaml
controlplane $ 
controlplane $ vi values.yaml 
controlplane $ 
controlplane $ 
controlplane $ cd templates/
controlplane $ 
controlplane $ vi deployment.yaml 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/fb-pod/templates
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ cd ..
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ ls
fb-pod  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ helm template fb-pod
Error: YAML parse error on fb-pod/templates/service.yaml: error converting YAML to JSON: yaml: line 17: could not find expected ':'

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ cd fb-pod/templates/
controlplane $ 
controlplane $ vi service.yaml 
controlplane $ 
controlplane $ cd ..
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm template fb-pod
---
# Source: fb-pod/templates/service.yaml
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
---
# Source: fb-pod/templates/deployment.yaml
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
        - image: "zakharovnpa/k8s-frontend:05.07.22"  
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: "zakharovnpa/k8s-backend:05.07.22"
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
---
# Source: fb-pod/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod fb-pod
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 15:35:35 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to stage namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-ndfnv   0/2     ContainerCreating   0          17s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-ndfnv   2/2     Running   0          43s
controlplane $ 
controlplane 
controlplane $ 
controlplane $ ls
fb-pod  stage-front-back.yaml  stage-pv.yaml  stage-pvc.yaml
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage
controlplane $ 
controlplane $ helm upgrade fb-pod 
Error: "helm upgrade" requires 2 arguments

Usage:  helm upgrade [RELEASE] [CHART] [flags]
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 15:40:34 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to stage namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-ndfnv   2/2     Running             0          5m7s
fb-pod-6464948946-nqgg7   2/2     Running             0          9s
fb-pod-6464948946-rs6nr   0/2     ContainerCreating   0          9s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-ndfnv   2/2     Running             0          5m12s
fb-pod-6464948946-nqgg7   2/2     Running             0          14s
fb-pod-6464948946-rs6nr   0/2     ContainerCreating   0          14s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-ndfnv   2/2     Running   0          5m26s
fb-pod-6464948946-nqgg7   2/2     Running   0          28s
fb-pod-6464948946-rs6nr   2/2     Running   0          28s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-ndfnv   2/2     Running   0          5m33s
fb-pod-6464948946-nqgg7   2/2     Running   0          35s
fb-pod-6464948946-rs6nr   2/2     Running   0          35s
controlplane $ 
controlplane $ vi fb-pod/values.yaml 
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 15:42:27 2022
NAMESPACE: default
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to stage namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-8rmkx   2/2     Terminating   0          74s
fb-pod-6464948946-ndfnv   2/2     Terminating   0          7m10s
fb-pod-6464948946-nqgg7   2/2     Terminating   0          2m12s
fb-pod-6464948946-rs6nr   0/2     Error         1          2m12s
fb-pod-6f45f8798b-45xbc   2/2     Running       0          10s
fb-pod-6f45f8798b-6ccss   2/2     Running       0          11s
fb-pod-6f45f8798b-mkc4f   2/2     Running       0          19s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-8rmkx   2/2     Terminating   0          80s
fb-pod-6464948946-ndfnv   2/2     Terminating   0          7m16s
fb-pod-6464948946-nqgg7   2/2     Terminating   0          2m18s
fb-pod-6464948946-rs6nr   0/2     Error         1          2m18s
fb-pod-6f45f8798b-45xbc   2/2     Running       0          16s
fb-pod-6f45f8798b-6ccss   2/2     Running       0          17s
fb-pod-6f45f8798b-mkc4f   2/2     Running       0          25s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-8rmkx   2/2     Terminating   0          86s
fb-pod-6464948946-ndfnv   2/2     Terminating   0          7m22s
fb-pod-6464948946-nqgg7   2/2     Terminating   0          2m24s
fb-pod-6464948946-rs6nr   0/2     Error         1          2m24s
fb-pod-6f45f8798b-45xbc   2/2     Running       0          22s
fb-pod-6f45f8798b-6ccss   2/2     Running       0          23s
fb-pod-6f45f8798b-mkc4f   2/2     Running       0          31s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-rs6nr   0/2     Error     1          2m39s
fb-pod-6f45f8798b-45xbc   2/2     Running   0          37s
fb-pod-6f45f8798b-6ccss   2/2     Running   0          38s
fb-pod-6f45f8798b-mkc4f   2/2     Running   0          46s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:12.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-rs6nr   0/2     Error     1          3m25s
fb-pod-6f45f8798b-45xbc   2/2     Running   0          83s
fb-pod-6f45f8798b-6ccss   2/2     Running   0          84s
fb-pod-6f45f8798b-mkc4f   2/2     Running   0          92s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
```
