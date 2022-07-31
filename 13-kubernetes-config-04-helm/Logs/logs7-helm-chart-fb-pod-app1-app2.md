## - Лог 7. Задание 1: подготовить helm чарт для приложения. Вариант 2. Неуспешная установка `fb-pod-app3` в окружение `app1` и потом успешная установка в окружение `app2`

```
Sun Jul 31 16:19:13 UTC 2022
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
LAST DEPLOYED: Sun Jul 31 16:19:14 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 
NodePort is 30080.

---------------------------------------------------------
NAME                           READY   STATUS    RESTARTS   AGE
fb-pod-app1-6464948946-8hnzc   0/2     Pending   0          0s
kubectl -n app1 get po
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cp fb-pod-app2 fb-pod-app3        
cp: -r not specified; omitting directory 'fb-pod-app2'
controlplane $ 
controlplane $ cp -r fb-pod-app2 fb-pod-app3
controlplane $ 
controlplane $ vi fb-pod-app2/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
controlplane $ 
controlplane $ vi fb-pod-app1/Chart.yaml 
controlplane $ 
controlplane $ cat fb-pod-app1/Chart.yaml 
apiVersion: v2
name: fb-pod-app1
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "05.07.22"
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app2/Chart.yaml 
apiVersion: v2
name: fb-pod-app2
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "12.07.22"
controlplane $ 
controlplane $ cat fb-pod-app3/Chart.yaml 
apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.0
appVersion: "13.07.22"
controlplane $ 
controlplane $ date && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && helm repo add stable https://charts.helm.shcontrolplane $ FILE=/ks/wait-background.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}controlplane $ date && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && helm repo add stable https://charts.helm.shcontrolplane $ cp fb-pod-app2 fb-pod-app3controlplane $ kubectl -n app1 get po,deploy,svcNAME                               READY   STATUS    RESTARTS   AGEpod/fb-pod-app1-6464948946-8hnzc   2/2     Running   0          8m58sNAME                          READY   UP-TO-DATE   AVAILABLE   AGEdeployment.apps/fb-pod-app1   1/1     1            1           8m58s

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.109.16.90   <none>        80:30080/TCP   8m58s
controlplane $ 
controlplane $ kubectl -n app2 get po,deploy,svc
No resources found in app2 namespace.
controlplane $ 
controlplane $ helm listh
Error: unknown command "listh" for "helm"

Did you mean this?
        lint
        list

Run 'helm --help' for usage.
controlplane $ 
controlplane $ 
controlplane $ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
fb-pod-app1     default         1               2022-07-31 16:19:14.352447645 +0000 UTC deployed        fb-pod-app1-0.1.0               1.16.0     
nfs-server      default         1               2022-07-31 16:18:53.565256502 +0000 UTC deployed        nfs-server-provisioner-1.1.3    2.3.0      
controlplane $ 
controlplane $ helm template fb-pod-app1
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
controlplane $ helm upgrade fb-pod-app1 fb-pod-app1
Release "fb-pod-app1" has been upgraded. Happy Helming!
NAME: fb-pod-app1
LAST DEPLOYED: Sun Jul 31 16:31:03 2022
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app1 namespace. 
NodePort is 30080.

---------------------------------------------------------
controlplane $ 
controlplane $ helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
fb-pod-app1     default         2               2022-07-31 16:31:03.589250114 +0000 UTC deployed        fb-pod-app1-0.1.0               05.07.22   
nfs-server      default         1               2022-07-31 16:18:53.565256502 +0000 UTC deployed        nfs-server-provisioner-1.1.3    2.3.0      
controlplane $ 
controlplane $ date
Sun Jul 31 16:32:19 UTC 2022
controlplane $ 
controlplane $ helm template --set nodePort=30083 --set namespace=app2 --set image.tag=13.07.22 fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
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
    nodePort: 30083
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ helm template --set nodePort=30083 --set namespace=app2 --set image.tag=13.07.22 --set name=f-pod-app3 fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: f-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30083
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: f-pod-app3
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: Service "fb-pod-app1" in namespace "app1" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "fb-pod-app3": current value is "fb-pod-app1"
controlplane $ 
controlplane $ vi fb-pod-app3/Chart.yaml 
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
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
# Source: fb-pod-app3/templates/deployment.yaml
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm template fb-pod-app3
---
# Source: fb-pod-app3/templates/service.yaml
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod-app3
  namespace: app2
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30083
  selector:
    app: fb-pod
---
# Source: fb-pod-app3/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod-app3
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
# Source: fb-pod-app3/templates/deployment.yaml
# Config Deployment Frontend & Backend with Volume
controlplane $ 
controlplane $ 
controlplane $ helm install fb-pod-app3 fb-pod-app3
NAME: fb-pod-app3
LAST DEPLOYED: Sun Jul 31 16:46:25 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to app2 namespace. 
nodePort is port= 30083.
Application name=fb-pod-app3.
Image tag: 13.07.22.
ReplicaCount: 1.

---------------------------------------------------------
controlplane $ 
controlplane $ kubectl -n app2 get po,svc,deployment
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app3-69fc56646b-h4ql9   2/2     Running   0          41s

NAME                  TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app3   NodePort   10.98.21.13   <none>        80:30083/TCP   41s

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app3   1/1     1            1           41s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n app1 get po,svc,deployment
NAME                               READY   STATUS    RESTARTS   AGE
pod/fb-pod-app1-6464948946-8hnzc   2/2     Running   0          28m

NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/fb-pod-app1   NodePort   10.109.16.90   <none>        80:30080/TCP   28m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fb-pod-app1   1/1     1            1           28m
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app3/Chart.yaml 
apiVersion: v2
name: fb-pod-app3
description: A Helm chart for Kubernetes
type: application
version: 0.1.2
appVersion: "13.07.22"
controlplane $ 
controlplane $ cat fb-pod-app3/values.yaml 

# Default values for fb-pod.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

name: fb-pod-app3

namespace: app2

image:
  repository: zakharovnpa
  name_front: k8s-frontend
  name_back: k8s-backend
  tag: 13.07.22
nodePort: 30083

controlplane $ 
controlplane $ 
controlplane $ cat fb-pod-app3/templates/NOTES.txt 
--------------------------------------------------------- 

Content of NOTES.txt appears after deploy. 
Deployed to {{ .Values.namespace }} namespace. 
nodePort is port= {{ .Values.nodePort }}.
Application name={{ .Values.name }}.
Image tag: {{ .Values.image.tag }}.
ReplicaCount: {{ .Values.replicaCount }}.

---------------------------------------------------------
controlplane $ 
controlplane $ 
controlplane $ 
```
