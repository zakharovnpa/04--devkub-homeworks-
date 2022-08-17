
## Задание 3 (*): повторить упаковку на jsonnet
Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.

### Ход выполнения ДЗ вопрос 3 (*)

#### Задание будет выполнено по следующесу плану:
1. Взять файлы yaml из Helm чарта для деплоя приложения
2. С помощью конвертера перевести их в формат json, а затем в формат jsonnet
3. Выполнить деплой приложения с файлами в формате jsonnet


#### 1.
* Файлы манифестов в формате yaml
* deployment.yaml
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
* service.yaml

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
* values.yaml
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


#### 2. 
* Helm 
* Конвертер yaml2jsonnet
* Ковертируем файл
```
yaml2jsonnet deployment.yaml | jsonnetfmt - -o deployment.jsonnet
```

```
yaml2jsonnet service.yaml | jsonnetfmt - -o service.jsonnet
```

#### 3.
