## Задание 1: подготовить helm чарт для приложения. Вариант 2

> Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
>
> * одну версию в namespace=app1;
> * вторую версию в том же неймспейсе;
> * третью версию в namespace=app2.

> Задача: 
> * для приложения создать нескольо версий
> * для Helm содать несколько чартов

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
helm create fb-pod-app1 && \
cd fb-pod-app1 && \
rm values.yaml && \
touch values.yaml && \
echo "" > values.yaml && \
cd templates && \
rm -r * && \
touch NOTES.txt deployment.yaml service.yaml && \
echo "--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to {{ .Values.namespace }} namespace. 
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------" > NOTES.txt && \
echo "
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
" > service.yaml && \
cd .. && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
" > values.yaml && \
cd .. && \
helm template fb-pod-app1 && \
helm install fb-pod-app1 fb-pod-app1 && \
cp -r fb-pod-app1 fb-pod-app2 && \
cp -r fb-pod-app1 fb-pod-app3 && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app2

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "12.07.22"
nodePort: 30081
" > fb-pod-app2/values.yaml && \
echo "
apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "13.07.22"
" > fb-pod-app3/Chart.yaml && \
echo "
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.07.22"
" > fb-pod-app2/Chart.yaml && \
echo "
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "13.07.22"
nodePort: 30082
" > fb-pod-app3/values.yaml && \
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


### Используемые манифесты

#### Notes.txt
```
---------------------------------------------------------

Content of NOTES.txt appears after deploy.

Deployed to {{ .Values.namespace }} namespace.
NodePort is {{ .Values.nodePort }}.
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------
```
#### файл шаблона с переменными `values.yaml`

```yml
# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: "1"

name: fb-pod-app1

namespace: app1

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: "05.07.22"
nodePort: 30080
```

#### файл шаблона `service.yaml`
```yml
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
#### файл шаблона `deployment.yaml`

```yml
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


###  Ход выполнения

#### Команды

```
echo 
```
### Логи - 8

- [Лог 8. Задание 1, вопрос 2, часть 2. Успешная установка `fb-pod-app2` в окружение `app1`](/13-kubernetes-config-04-helm/Logs/logs8-helm-chart-fb-pod-app1-app2.md)

### Логи - 7

- [Лог 7. Задание 1, вопрос 2, часть 3. Неуспешная установка `fb-pod-app3` в окружение `app1` и потом успешная установка в окружение `app2` ](/13-kubernetes-config-04-helm/Logs/logs7-helm-chart-fb-pod-app1-app2.md)

### Логи - 6

- [Лог 6. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs6-helm-chart-fb-pod-app1-app2.md)

### Логи - 5

- [Лог 5. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs5-helm-chart-fb-pod-app1-app2.md)

### Логи - 4

- [Лог 4. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs4-helm-chart-fb-pod-app1-app2.md)

### Логи - 3
- [Лог 3. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs3-helm-chart-fb-pod-app1-app2.md)


### Логи - 2
- [Лог 2. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs2-helm-chart-fb-pod-app1-app2.md)


### Логи - 1

- [Лог 1. Задание 1: подготовить helm чарт для приложения. Вариант 2](/13-kubernetes-config-04-helm/Logs/logs1-helm-chart-fb-pod-app1-app2.md)

