## Лог 1. Задание 1: подготовить helm чарт для приложения. Вариант 2

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
