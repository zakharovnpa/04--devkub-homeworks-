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
" > deployment.yaml && \
echo "
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
" > service.yaml && \
cd .. && \
echo "
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
" > values.yaml && \
cd .. && \
helm template fb-pod && \
helm install fb-pod fb-pod && \
kubectl -n stage get po && \
echo "kubectl -n stage get po"
```

```
echo "
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
 
```
#### файл шаблона `values.yaml`

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

###  Ход выполнения

#### Команды

```
echo 
```


### Логи

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
