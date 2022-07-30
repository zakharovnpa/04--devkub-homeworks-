## Задание 1: подготовить helm чарт для приложения. Вариант 1

### 1. Подготовка рабочего пространства

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
cd My-Project/stage && \
touch stage-pv.yaml stage-pvc.yaml stage-front-back.yaml && \
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
clear && \
kubectl get po && \
date && \
pwd
```

### 2. Команды
* Создание первого чарта
```
helm repo list
```
* Создание чарта first в папке charts
```
helm create fb-pod
```
* Сборка ресурсов из шаблона 
```
helm template fb-pod
```
* Linter
```
helm lint fb-pod
```
* Деплой Release deploy
```
helm install fb-pod fb-pod
kubectl get ns
```
* Версия образа
```
kubectl get fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
```
* Обновление приложения после изменения версии. Upgrade release
```
helm upgrade demo-release charts/01-simple
```
* Обновление с установкой. Upgrade or install release
```
helm upgrade --install demo-release charts/01-simple
```
* Удаление релиза. Uninstall release
```
helm uninstall demo-release
```
* Установка релиза в новый namespace с переопределением параметров
```
helm install new-release -f charts/01-simple/new-values2.yaml charts/01-simple
kubectl -n new get deploy demo -o jsonpath={.spec.template.spec.containers[0].image}
```
* Просмотр пользовательских переменных
```
helm get values demo-release
helm get values new-release
```
* Список релизов
```
helm list
```
* Отладка
```
helm install --dry-run --debug aaa --set namespace=aaa charts/01-simple
```
### Технология сборки приложения.
1. Создание в папке templates шаблонов `helm create first`
2. Запуск сборки ресурсов из шаблона `helm template first`
  * после выполнения команды в терминале появятся содержимое файлов
```
-- first
    |-- Chart.yaml
    |-- charts
    |-- templates
    |   |-- NOTES.txt
    |   |-- _helpers.tpl
    |   |-- deployment.yaml
    |   |-- hpa.yaml
    |   |-- ingress.yaml
    |   |-- service.yaml
    |   |-- serviceaccount.yaml
    |   `-- tests
    |       `-- test-connection.yaml
    `-- values.yaml
```
3. Запуск линтера `helm lint fb-pod`


### Задание: 
Используя манифесты разработанного приложения frontend,backend, database
создать шаблоны для упаковки в чарт составных частей приложений.

В результате получить файлы:
  * values.yaml
  * NOTES.txt
  * deployment.yaml
  * service.yaml
  * Chart.yaml
 
    
### Процесс заполнения шаблона
#### Источник - манифест `fb-pod.yaml`
```yml
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
            - mountPath: "/static"
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/tmp/cache"
              name: my-volume
      volumes:
        - name: my-volume
          emptyDir: {}
 
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
```

#### Приемник - файл шаблона `deployment.yaml`

```
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
 
```
#### Приемник - файл шаблона `service.yaml`
```yml
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

```

#### Приемник - файл шаблона `values.yaml`

```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

namespace: stage

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"


```
#### Notes.txt
```
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
```




### 3. Деплой приложения
  * `helm lint fb-pod`
  * `helm install fb-pod fb-pod` 

### Технология создания версий приложения


### Логи

* Tab 1
```
controlplane $ pwd
/root/My-Procect/stage/chart01
controlplane $ 
controlplane $ helm create first
Creating first
controlplane $ 
```
```
controlplane $ helm template first
```
* serviceaccount.yaml
```yml
---
# Source: first/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
---
```
* service.yaml
```yml
# Source: first/templates/service.yaml
---
apiVersion: v1
kind: Service
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
---
```
* deployment.yaml
```yml
# Source: first/templates/deployment.yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: release-name-first
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: first
      app.kubernetes.io/instance: release-name
  template:
    metadata:
      labels:
        app.kubernetes.io/name: first
        app.kubernetes.io/instance: release-name
    spec:
      serviceAccountName: release-name-first
      securityContext:
        {}
      containers:
        - name: first
          securityContext:
            {}
          image: "nginx:1.16.0"
          imagePullPolicy: IfNotPresent
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {}
---
```
* test-connection.yaml
```yml
# Source: first/templates/tests/test-connection.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: "release-name-first-test-connection"
  labels:
    helm.sh/chart: first-0.1.0
    app.kubernetes.io/name: first
    app.kubernetes.io/instance: release-name
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
  annotations:
    "helm.sh/hook": test
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args: ['release-name-first:80']
  restartPolicy: Never
---
```
```
controlplane $ helm install first
Error: INSTALLATION FAILED: must either provide a name or specify --generate-name
controlplane $ 
controlplane $ helm install first first
NAME: first
LAST DEPLOYED: Fri Jul 29 07:11:55 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=first,app.kubernetes.io/instance=first" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                             READY   STATUS    RESTARTS      AGE
alertmanager-0                                   0/1     Pending   0             37m
first-5f9fd64764-2gsgw                           1/1     Running   0             10s
nfs-server-nfs-server-provisioner-0              1/1     Running   0             37m
nginx-ingress-controller-9b5c967bf-5jzbd         0/1     Running   15 (5s ago)   37m
nginx-ingress-default-backend-85b4b4dd44-5wxm2   1/1     Running   0             37m
controlplane $ 
```
### Логи - 2

```
controlplane $ date
Sat Jul 30 07:23:10 UTC 2022

NAME                                             READY   STATUS    RESTARTS   AGE
alertmanager-0                                   0/1     Pending   0          2s
nfs-server-nfs-server-provisioner-0              1/1     Running   0          24s
nginx-ingress-controller-9b5c967bf-hxs2l         0/1     Pending   0          0s
nginx-ingress-default-backend-85b4b4dd44-dv7ps   0/1     Pending   0          0s
Sat Jul 30 07:04:21 UTC 2022
/root/My-Procect/stage/chart01/charts/nginx-ingress
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ helm create fb-pod
Creating fb-pod
controlplane $ 
controlplane $ mc

controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   `-- tests
`-- values.yaml

3 directories, 5 files
controlplane $ 
```
#### values.yaml 
```
controlplane $ cat values.yaml 
```
```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.
---
replicaCount: 1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"

```
#### deployment.yaml
```
controlplane $ cat templates/deployment.yaml 
```
```
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
```
```
controlplane $ date
Sat Jul 30 07:23:10 UTC 2022
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts/fb-pod
controlplane $ 
controlplane $ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
alertmanager    default         1               2022-07-30 07:04:19.044655091 +0000 UTC deployed        alertmanager-0.19.0             v0.23.0    
nfs-server      default         1               2022-07-30 07:03:56.095597041 +0000 UTC deployed        nfs-server-provisioner-1.1.3    2.3.0      
nginx-ingress   default         1               2022-07-30 07:04:20.772116071 +0000 UTC deployed        nginx-ingress-1.41.3            v0.34.1    
controlplane $ 
controlplane $ helm template fb-pod
Error: failed to download "fb-pod"
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod
Error: template: fb-pod/templates/NOTES.txt:2:14: executing "fb-pod/templates/NOTES.txt" at <.Values.ingress.enabled>: nil pointer evaluating interface {}.enabled

Use --debug flag to render out invalid YAML
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ helm lint fb-pod 
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended
[ERROR] templates/: template: fb-pod/templates/NOTES.txt:2:14: executing "fb-pod/templates/NOTES.txt" at <.Values.ingress.enabled>: nil pointer evaluating interface {}.enabled

Error: 1 chart(s) linted, 1 chart(s) failed
controlplane $ 
controlplane $ 
controlplane $ helm lint fb-pod
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ cat fb-pod/templates/NOTES.txt 
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
```
```
controlplane $ helm template fb-pod 
```
```yml
---
# Source: fb-pod/templates/deployment.yaml
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
```
#### helm install fb-pod fb-pod
```
controlplane $ helm install fb-pod fb-pod
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:36:16 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                             READY   STATUS             RESTARTS       AGE
alertmanager-0                                   0/1     Pending            0              32m
nfs-server-nfs-server-provisioner-0              1/1     Running            0              32m
nginx-ingress-controller-9b5c967bf-hxs2l         0/1     CrashLoopBackOff   13 (64s ago)   32m
nginx-ingress-default-backend-85b4b4dd44-dv7ps   1/1     Running            0              32m
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-qtrww   0/2     ContainerCreating   0          28s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running   0          31s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running   0          33s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ tree
.
|-- Chart.yaml
|-- charts
|-- templates
|   |-- NOTES.txt
|   |-- _helpers.tpl
|   |-- deployment.yaml
|   `-- tests
`-- values.yaml

3 directories, 5 files
```
```
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22
controlplane $ 
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Error: failed to download "fb-pod"
controlplane $ 
controlplane $ pwd
/root/My-Procect/stage/chart01/charts/fb-pod
```
#### helm upgrade fb-pod fb-pod
```
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:47:17 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Running             0          11m
fb-pod-6f45f8798b-82wht   0/2     ContainerCreating   0          14s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-qtrww   2/2     Terminating   0          11m
fb-pod-6f45f8798b-82wht   2/2     Running       0          20s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-82wht   2/2     Running   0          49s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:12.07.22controlplane $ 
```
#### helm upgrade fb-pod fb-pod
```
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:49:31 2022
NAMESPACE: default
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to  namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-69fc56646b-ncqdp   2/2     Running       0          8s
fb-pod-6f45f8798b-82wht   2/2     Terminating   0          2m22s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:13.07.22controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-69fc56646b-ncqdp   2/2     Running   0          43s
controlplane $ 
controlplane $ cat fb-pod/values.yaml 
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "13.07.22"

controlplane $ 
controlplane $ date
Sat Jul 30 07:51:01 UTC 2022
controlplane $ 
controlplane $ 
```

![screen-helm-upgrade-fb-pod.png](/13-kubernetes-config-04-helm/Files/screen-helm-upgrade-fb-pod.png)

#### helm upgrade fb-pod fb-pod
```
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 07:58:47 2022
NAMESPACE: default
STATUS: deployed
REVISION: 4
TEST SUITE: None
NOTES:
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to stage namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod/values.yaml 
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

namespace: stage

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"

controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-ch5xk   2/2     Running       0          21s
fb-pod-69fc56646b-ncqdp   2/2     Terminating   0          9m37s
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
```
### Логи - 3

```
NAME                                             READY   STATUS              RESTARTS   AGE
alertmanager-0                                   0/1     Pending             0          3s
nfs-server-nfs-server-provisioner-0              1/1     Running             0          28s
nginx-ingress-controller-9b5c967bf-6hqxc         0/1     ContainerCreating   0          1s
nginx-ingress-default-backend-85b4b4dd44-tnzt9   0/1     Pending             0          1s
Sat Jul 30 09:19:23 UTC 2022
/root/My-Project/stage/chart01/charts/nginx-ingress
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/chart01/charts/nginx-ingress
controlplane $ 
controlplane $ cd ..
controlplane $ cd ..
controlplane $ 
controlplane $ pwd/root/My-Project/stage/chart01
controlplane $ 
controlplane $ helm create fb-pod
Creating fb-pod
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ date
Sat Jul 30 09:26:31 UTC 2022
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/chart01/fb-pod
controlplane $ 
controlplane $ cd ..
controlplane $ 
controlplane $ helm template fb-pod
Error: YAML parse error on fb-pod/templates/service.yaml: error converting YAML to JSON: yaml: line 17: could not find expected ':'

Use --debug flag to render out invalid YAML
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
  replicas: "1"
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
controlplane $ helm lint fb-pod
==> Linting fb-pod
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
controlplane $ 
controlplane $ helm install fb-pod fb-pod
Error: INSTALLATION FAILED: unable to build kubernetes objects from release manifest: error validating "": error validating data: ValidationError(Deployment.spec.replicas): invalid type for io.k8s.api.apps.v1.DeploymentSpec.replicas: got "string", expected "integer"
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
controlplane $ 
controlplane $ helm install fb-pod fb-pod
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 09:35:23 2022
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
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-trh6r   0/2     ContainerCreating   0          25s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-trh6r   0/2     ContainerCreating   0          28s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6464948946-trh6r   2/2     Running   0          49s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
error: the server doesn't have a resource type "fb-pod"
controlplane $ 
controlplane $ kubectl -n stage get pod fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
Error from server (NotFound): pods "fb-pod" not found
controlplane $ 
controlplane $ kubectl -n stage get deploy fb-pod -o jsonpath={.spec.template.spec.containers[0].image}
zakharovnpa/k8s-frontend:05.07.22controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm upgrade fb-pod fb-pod
Release "fb-pod" has been upgraded. Happy Helming!
NAME: fb-pod
LAST DEPLOYED: Sat Jul 30 09:40:50 2022
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
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-mdf25   0/2     ContainerCreating   0          8s
fb-pod-6464948946-trh6r   2/2     Running             0          5m34s
fb-pod-6f45f8798b-x9q7f   0/2     ContainerCreating   0          8s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-mdf25   0/2     Terminating         0          29s
fb-pod-6464948946-trh6r   2/2     Running             0          5m55s
fb-pod-6f45f8798b-jcmf2   0/2     ContainerCreating   0          20s
fb-pod-6f45f8798b-x9q7f   2/2     Running             0          29s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS              RESTARTS   AGE
fb-pod-6464948946-mdf25   2/2     Terminating         0          37s
fb-pod-6464948946-trh6r   2/2     Running             0          6m3s
fb-pod-6f45f8798b-jcmf2   0/2     ContainerCreating   0          28s
fb-pod-6f45f8798b-x9q7f   2/2     Running             0          37s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-mdf25   2/2     Terminating   0          53s
fb-pod-6464948946-trh6r   2/2     Terminating   0          6m19s
fb-pod-6f45f8798b-jcmf2   2/2     Pending       0          44s
fb-pod-6f45f8798b-x9q7f   2/2     Running       0          53s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-mdf25   2/2     Terminating   0          60s
fb-pod-6464948946-trh6r   2/2     Terminating   0          6m26s
fb-pod-6f45f8798b-jcmf2   2/2     Pending       0          51s
fb-pod-6f45f8798b-x9q7f   2/2     Running       0          60s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS        RESTARTS   AGE
fb-pod-6464948946-trh6r   2/2     Terminating   0          6m38s
fb-pod-6f45f8798b-jcmf2   2/2     Pending       0          63s
fb-pod-6f45f8798b-x9q7f   2/2     Running       0          72s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          73s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          82s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          6s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          90s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          99s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          23s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          101s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          110s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          34s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          2m3s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          2m12s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          56s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          2m15s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          2m24s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          68s
controlplane $ 
controlplane $ kubectl -n stage get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6f45f8798b-jcmf2   0/2     Error     1          2m23s
fb-pod-6f45f8798b-x9q7f   2/2     Running   0          2m32s
fb-pod-6f45f8798b-zl9c6   2/2     Running   0          76s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ pwd
/root/My-Project/stage/chart01
controlplane $ 
controlplane $ cd fb-pod/
controlplane $ 
controlplane $ ls
Chart.yaml  charts  templates  values.yaml
controlplane $ 
controlplane $ cat values.yaml 
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "2"

namespace: stage

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "12.07.22"


controlplane $ 
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
controlplane $ cat templates/deployment.yaml 
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
 
controlplane $ 
controlplane $ cat templates/service.yaml    
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
controlplane $ cat templates/NOTES.txt    
---------------------------------------------------------

Content of NOTES.txt appears after deploy.
Deployed to {{ .Values.namespace }} namespace.

---------------------------------------------------------
controlplane $ 
controlplane $ 
```
