## Лог 8. Задание 1, вопрос 2, часть 2. Успешная установка `fb-pod-app2` в окружение `app1`



```
Sun Jul 31 17:44:51 UTC 2022
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
LAST DEPLOYED: Sun Jul 31 17:44:52 2022
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
fb-pod-app1-6464948946-prb9r   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running   0          2m58s
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app3 get po
No resources found in app3 namespace.
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
nodePort: 30081

controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml  

apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: 12.07.22

controlplane $ 
controlplane $ ustanovka vtoroy versii application in namespace app1 ====
ustanovka: command not found
controlplane $ 
controlplane $ date
Sun Jul 31 17:50:42 UTC 2022
controlplane $ 
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
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app2 fb-pod-app2
NAME: fb-pod-app2
LAST DEPLOYED: Sun Jul 31 17:52:18 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy.

Deployed to app1 namespace. 
nodePort is port= 30081.
Application name=fb-pod-app2.
Image tag: 12.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n app2 get po
No resources found in app2 namespace.
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          8m27s
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          61s
fb-pod-app2-6f45f8798b-xzc58   0/2     ContainerCreating        0          2s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po
NAME                           READY   STATUS                   RESTARTS   AGE
fb-pod-app1-6464948946-prb9r   2/2     Running                  0          9m3s
fb-pod-app2-6f45f8798b-rcfdw   0/2     ContainerStatusUnknown   2          97s
fb-pod-app2-6f45f8798b-xzc58   2/2     Running                  0          38s
controlplane $ 
controlplane $ 
controlplane $ 
```
